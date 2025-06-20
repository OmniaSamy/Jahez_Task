//
//  Untitled.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import UIKit
import SwiftUI

class Container {
    
    class func embedVCInNavController(_ viewController: UIViewController) -> UIViewController {
        let nav = AppNavigationController(rootViewController: viewController)
        return nav
    }
    
    class Movie {
        
        class func getMovieHomeScreen() -> UIViewController {
            
            let viewModel = HomeViewModel()
            let homeView = HomeView(viewModel: viewModel)
            let hostingController = UIHostingController(rootView: homeView)
            hostingController.title = "Movies"
            return hostingController
        }
    }
}
