//
//  GenreModel.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import Foundation

struct GenreModel: Codable, Identifiable {
    
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
    }
}
