//
//  HomeViewModel.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var genresList: [GenreModel] = []
    // contains all movies loaded
    @Published var allMoviesList: [MovieModel] = []
    // movie list binded to view
    @Published var trendingMoviesList: [MovieModel] = []
    
    @Published var isLoading: Bool = false
    
    // for paginagtion
    @Published var isLoadingMore: Bool = false
    var currentPage = 1
    
    @Published var searchText: String = "" {
        didSet {
            applyFilters()
        }
    }
    
    @Published var selectedGenre: GenreModel? {
        didSet {
            applyFilters()
        }
    }
}

// MARK: fetch data
extension HomeViewModel {
    
    func getOfficialGenresList() {
        
        NetworkManager.shared.getOfficialGenresList(completion: { [weak self] (result: Result<GenreResponse, NetworkError>, _) in
            
            switch result {
            case .success(let data):
                print("data \(data)")
                self?.genresList.append(contentsOf: data.genres ?? [])
                
            case .failure(let error):
                print("error \(error)")
                AppAlertManager.showError(message: error.errorMessage())
                
            }
        })
    }
    
    func getTrendingMovies(page: Int = 1) {
        
        isLoading = true
        NetworkManager.shared.getTrendingMovies(page: page,
                                                completion: { [weak self] (result: Result<NetworkResponse<MovieModel>, NetworkError>, _) in
            self?.isLoadingMore = false
            switch result {
            case .success(let data):
                print("data \(data)")
                
                self?.allMoviesList.append(contentsOf: data.results ?? [])
                self?.applyFilters()
                
                self?.currentPage = data.page ?? 1
                
            case .failure(let error):
                print("error \(error)")
                AppAlertManager.showError(message: error.errorMessage())
            }
            self?.isLoading = false
        })
    }
}

// MARK: load more function
extension HomeViewModel {
    
    func loadMoreIfNeeded(currentMovie: MovieModel) {
        
        guard !isLoadingMore else { return }
        
        if currentMovie.id == trendingMoviesList.last?.id {
            isLoadingMore = true
            getTrendingMovies(page: self.currentPage + 1)
        }
    }
}

// MARK: search & filter function
extension HomeViewModel {
    
    func selectGenre(_ genre: GenreModel) {
        
        if selectedGenre?.id == genre.id {
            selectedGenre = nil
        } else {
            selectedGenre = genre
        }
    }
    
    func applyFilters() {
        
        var filtered = allMoviesList
        
        // Filter by genre if selected
        if let genreID = selectedGenre?.id {
            filtered = filtered.filter { $0.genreIDList?.contains(genreID) ?? false }
        }
        
        // Filter by search text if available
        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            filtered = filtered.filter {
                $0.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        
        trendingMoviesList = filtered
    }
}

// MARK: mock function
extension HomeViewModel {
    
    static func mock() -> HomeViewModel {
        
        let vm = HomeViewModel()
        
        vm.allMoviesList = [
            MovieModel(id: 1, title: "Inception"),
            MovieModel(id: 2, title: "Interstellar")
        ]
        
        vm.trendingMoviesList = [
            MovieModel(id: 1, title: "Inception"),
            MovieModel(id: 2, title: "Interstellar")
        ]
        
        vm.genresList = [
            GenreModel(id: 1, name: "genre 1"),
            GenreModel(id: 2, name: "genre 2")
        ]
        
        return vm
    }
}
