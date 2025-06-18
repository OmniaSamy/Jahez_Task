//
//  NetworkManager+Movie.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import Foundation
import Moya

extension NetworkManager {
    
    func getOfficialGenresList(completion: @escaping(_ result: Swift.Result<GenreResponse, NetworkError>,
                                            _ statusCode: Int?) -> Void) {
        
        provider.request(MultiTarget(MovieService.getOfficialGenresList)) { result in
            self.parseResponse(moyaResult: result, completion: completion)
        }
    }
    
    func getTrendingMovies(page: Int,
                      completion: @escaping(_ result: Swift.Result<NetworkResponse<MovieModel>, NetworkError>,
                                            _ statusCode: Int?) -> Void) {
        
        provider.request(MultiTarget(MovieService.getTrendingMovies(page: page))) { result in
            self.parseResponse(moyaResult: result, completion: completion)
        }
    }
}
