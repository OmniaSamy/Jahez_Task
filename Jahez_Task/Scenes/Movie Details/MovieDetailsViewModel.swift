//
//  MovieDetailsViewModel.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 20/06/2025.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    
    @Published var movie: MovieModel?
    let allGenres: [GenreModel]?
    
    var genreNames: [String] {
        
        guard let genreIds = self.movie?.genreIDList else { return [] }
        return genreIds.compactMap { id in
            allGenres?.first(where: { $0.id == id })?.name
        }
    }
    
    init(movie: MovieModel, genres: [GenreModel]) {
        self.movie = movie
        self.allGenres = genres
    }
}
