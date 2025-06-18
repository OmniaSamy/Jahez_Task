//
//  SceneDelegate+Extension.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 18/06/2025.
//

import Foundation

extension SceneDelegate {
    
    func disableDarkMode() {
        AppManager.shared.window?.overrideUserInterfaceStyle = .light
    }
}
