//
//  AppNavigationController.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 18/06/2025.
//

import UIKit

class AppNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearBackBarButtonTitle()
    }
}

extension AppNavigationController {
    
    func clearBackBarButtonTitle() {
        
        self.navigationBar.tintColor = .primaryColor
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
        
    }
}
