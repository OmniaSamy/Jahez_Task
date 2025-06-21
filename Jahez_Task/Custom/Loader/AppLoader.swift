//
//  Loader.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 18/06/2025.
//

import SwiftUI

extension View {
    
    func loadingOverlay(isLoading: Bool) -> some View {
        
        ZStack {
            self
                .disabled(isLoading)
                .blur(radius: isLoading ? 1 : 0)
            
            if isLoading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.white)
                    .scaleEffect(1.5)
            }
        }
    }
}
