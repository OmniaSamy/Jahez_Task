//
//  AppDelegate+Extension.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import Foundation

extension AppDelegate {
    
    func initNetwork() {
        let defaults = NetworkDefaults(baseUrl: Environment.baseURL,
                                       apiKey: Environment.apiKey)
        NetworkManager.shared = NetworkManager(config: defaults)
    }
}
