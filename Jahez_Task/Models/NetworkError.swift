//
//  NetworkError.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import Foundation

import Foundation
import Moya
import Alamofire

struct NetworkError: Codable, Error, LocalizedError {
    
    var errors: ErrorModel?
    var type: Type?
    var message: String?
    var statusCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
    
    init() {  }
    
    init(error: MoyaError) {
        
        let errors = ErrorModel(message: error.errorDescription ?? "NA", type: "MoyaError")
        self.errors = errors
        
        if case let MoyaError.underlying(underlying, _) = error ,
           case let AFError.sessionTaskFailed(error: urlErrorDomain) = underlying {
            
            let nsError = urlErrorDomain as NSError
            
            if (999...1017) ~= abs(nsError.code) {
                print(error)
                self.type = .network
                let errors = ErrorModel(message: "No Internet", type: "MoyaError")
                self.errors = errors
                self.message = "No Internet"
            }
        }
    }
    
    init(error: Error) {
        print(error)
        print(error.localizedDescription)
        self.type = .mapping
    }
    
    func errorMessage () -> String {
        return message ?? "no message found"
    }
}

extension NetworkError {
    static let parseError: NetworkError = {
        var error = NetworkError()
        return error
    }()
    
    static let authorizeError: NetworkError = {
        var error = NetworkError()
        error.errors = ErrorModel(message: "Session Expire", type: "SessionError")
        error.type = Type.auth
        return error
    }()
    
    func getErrorMessage(errorsList: [String]) -> String {
        
        let errorMessage = errorsList.joined(separator: ",")
        return errorMessage
    }
}

struct ErrorModel: Codable {
    
    let type: String?
    let info: String?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case info = "error"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        info = try values.decodeIfPresent(String.self, forKey: .info)
    }
    
    init(message: String, type: String) {
        self.info = message
        self.type = type
    }
}

enum `Type`:String, Codable {
    case business
    case system
    case mapping
    case auth
    case network
}
