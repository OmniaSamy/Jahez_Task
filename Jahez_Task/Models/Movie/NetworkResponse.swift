//
//  NetworkResponse.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import Foundation

struct NetworkResponse<T: Codable>: Codable {
    
    // adding this to be genric to handle all apis with same structure
    var page:Int?
    var total_results: Int?
    var total_pages: Int?
    var results: [T]?
    var errors: [String]?
}
