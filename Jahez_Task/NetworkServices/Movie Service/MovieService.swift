//
//  MovieService.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import Foundation
import Moya

enum MovieService {
    case getOfficialGenresList
    case getTrendingMovies(page: Int)
}

extension MovieService: TargetType {
    
    var baseURL: URL {
        return URL(string: NetworkManager.networkConfig.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .getOfficialGenresList:
            return "/3/genre/movie/list"
        case .getTrendingMovies:
            return "/3/discover/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getOfficialGenresList:
            return .get
        case .getTrendingMovies:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        switch self {
        case .getOfficialGenresList:
            return .requestParameters(parameters: ["api_key": NetworkManager.networkConfig.apiKey],
                                      encoding: URLEncoding.default)
        case .getTrendingMovies(let page):
            
            var parames = ["page": page,
                           "include_video": false,
                           "api_key": NetworkManager.networkConfig.apiKey] as [String : Any]
            return .requestParameters(parameters: parames,
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

