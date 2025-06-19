//
//  HomeViewModel.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var genresList: [GenreModel] = []
    @Published var trendingMoviesList: [MovieModel] = []
    
    @Published var isLoading: Bool = false
    
    // for paginagtion
    @Published var isLoadingMore: Bool = false
    var currentPage = 1
    
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
                self?.trendingMoviesList.append(contentsOf: data.results ?? [])
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

// MARK: moc function
extension HomeViewModel {
    
      static func mock() -> HomeViewModel {
          
          let vm = HomeViewModel()
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
