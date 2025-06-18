//
//  Environment.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import Foundation

enum Environment {
    
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
            static let apiKey = "API_KEY"
            static let imageBaseURL = "IMAGE_BASE_URL"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let baseURL: String = {
        guard let rootURLstring = Environment.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        let baseUrl = "https://\(rootURLstring)"
        return baseUrl
    }()
    
    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()
    
    static let imageBaseURL: String = {
        guard let imageURLstring = Environment.infoDictionary[Keys.Plist.imageBaseURL] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        let baseUrl = "https://\(imageURLstring)"
        return baseUrl
    }()
}
