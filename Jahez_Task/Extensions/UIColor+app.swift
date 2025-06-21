//
//  UIColor+app.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 18/06/2025.
//

import Foundation
import UIKit

extension UIColor {
    
    class var primaryColor: UIColor {
        guard let color = UIColor(named: "Primary Color") else {
            return UIColor()
        }
        return color
    }
}
