//
//  AppManager.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 18/06/2025.
//

import Foundation
import UIKit

class AppManager {
    
    static var shared: AppManager = AppManager()
    var window: UIWindow?
    
    func setRootView(viewController: UIViewController) {
        window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
}
