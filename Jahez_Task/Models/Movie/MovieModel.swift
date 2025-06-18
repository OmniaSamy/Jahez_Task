//
//  MovieModel.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import Foundation

struct MovieModel: Codable {
    
    var movieID: Int?
    var posterPath: String?
    var title: String?
    var releaseDate: String?
    var overview: String?
    
    enum CodingKeys: String, CodingKey {
        
        case movieID = "id"
        case title = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case overview = "overview"
    }
}
