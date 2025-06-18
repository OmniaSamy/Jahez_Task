//
//  AppAlertManager.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 18/06/2025.
//

import Foundation
import SwiftMessages

class AppAlertManager {
    
    static func showError(message: String) {
        
        DispatchQueue.main.async {
            let view = MessageView.viewFromNib(layout: .cardView)
            view.button?.isHidden = true
            view.configureTheme(.error)
            view.configureDropShadow()
            view.configureContent(title: "Error", body: message)
            view.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            (view.backgroundView as? CornerRoundingView)?.cornerRadius = 8
            
            var config = SwiftMessages.Config()
            config.presentationContext = .window(windowLevel: .statusBar)
            config.duration = .seconds(seconds: 3)
            
            SwiftMessages.show(config: config, view: view)
        }
    }
}
