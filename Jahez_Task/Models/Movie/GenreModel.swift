//
//  GenreModel.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import Foundation

struct GenreModel: Codable {
    
    var genreID: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        
        case genreID = "id"
        case name = "name"
    }
}
