//
//  CoreDataManager.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 21/06/2025.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "JahezDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData failed to load: \\(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
}

// MARK: movie operations
extension CoreDataManager {
    
    func saveMovies(_ movies: [MovieModel]) {
        let context = CoreDataManager.shared.context
        
        // Delete old movies
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDMovie.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? context.execute(deleteRequest)
        
        // Save new movies
        for movie in movies {
            let cdMovie = CDMovie(context: context)
            cdMovie.id = Int64(movie.id ?? 0)
            cdMovie.title = movie.title
            cdMovie.posterPath = movie.posterPath
            cdMovie.releaseDate = movie.releaseDate
            cdMovie.overview = movie.overview
            cdMovie.popularity = movie.popularity ?? 0
            cdMovie.genreIds = movie.genreIDList as NSArray?
        }
        
        try? context.save()
    }
    
    func loadMovies() -> [MovieModel] {
        
        let context = CoreDataManager.shared.context
        let request: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
        
        guard let cdMovies = try? context.fetch(request) else { return [] }
        
        return cdMovies.map {
            
            MovieModel(id: Int($0.id),
                       posterPath: $0.posterPath,
                       title: $0.title,
                       releaseDate: $0.releaseDate,
                       overview: $0.overview,
                       genreIDList: $0.genreIds as? [Int],
                       popularity: $0.popularity)
        }
    }
}

// MARK: genre operations
extension CoreDataManager {
    
    func saveGenres(_ genres: [GenreModel]) {
        let context = CoreDataManager.shared.context
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDGenre.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try? context.execute(deleteRequest)
        
        for genre in genres {
            let cdGenre = CDGenre(context: context)
            cdGenre.id = Int64(genre.id ?? 0)
            cdGenre.name = genre.name
        }
        
        try? context.save()
    }
    
    func loadGenres() -> [GenreModel] {
        
        let context = CoreDataManager.shared.context
        let request: NSFetchRequest<CDGenre> = CDGenre.fetchRequest()
        
        guard let cdGenres = try? context.fetch(request) else { return [] }
        
        return cdGenres.map {
            GenreModel(id: Int($0.id), name: $0.name)
        }
    }
}
