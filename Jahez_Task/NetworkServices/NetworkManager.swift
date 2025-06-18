//
//  NetworkManager.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import Foundation
import Moya

class NetworkManager {
    
    typealias MoyaCompletion = Result<Moya.Response, MoyaError>
    typealias NetworkCompletion<T: Codable> = (_ result: Swift.Result<T, NetworkError>,
                                               _ statusCode: Int?) -> Void
    
    static var networkConfig: NetworkDefaults {
        return NetworkManager.shared._networkConfig!
    }
    
    static var shared: NetworkManager!
    var _networkConfig: NetworkDefaults?
    
    var provider: MoyaProvider<MultiTarget>!
    
    let accessTocken = AccessTokenPlugin(tokenClosure: { _ in
        return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMGM1NDM5YjdlNDViZmE3ODhmYjc0NWE1YjY5NjRmNSIsIm5iZiI6MTc1MDE1NDE4OC4wNjA5OTk5LCJzdWIiOiI2ODUxM2JjYzFiMTg1NDhkZWJiNmRmMWMiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.ybHOru13HTXFDzIDtFemZlOiXrFpzxrcVnKlb2R7kGo"
    })
    
    init(config: NetworkDefaults) {
        
        self._networkConfig = config
        NetworkManager.shared = self
        
        let headerPlugin = StaticHeaderPlugin(
            headers: [
                "Accept": "application/json"
            ])
        
        provider = MoyaProvider<MultiTarget>(plugins: [headerPlugin, accessTocken, NetworkLoggerPlugin()])
    }
}

public struct StaticHeaderPlugin: PluginType {
    
    var headers: [String: String] = [:]
    
    public init(headers: [String: String]) {
        self.headers = headers
    }
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        headers.forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
