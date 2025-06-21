//
//  ImageLoader.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 18/06/2025.
//

import Foundation
import SwiftUI

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    private let url: String
    private var task: URLSessionDataTask?
    
    init(url: String) {
        self.url = url
        loadImage()
    }
    
    private func loadImage() {
        
        // Check if image is already cached
        if let cachedImage = ImageCache.shared.object(forKey: url as NSString) {
            self.image = cachedImage
            return
        }
        
        // Download image
        guard let imageURL = URL(string: url) else { return }
        
        task = URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, error in
            guard
                let self = self,
                let data = data,
                let downloaded = UIImage(data: data)
            else {
                return
            }
            
            // Cache image
            ImageCache.shared.setObject(downloaded, forKey: self.url as NSString)
            
            DispatchQueue.main.async {
                self.image = downloaded
            }
        }
        
        task?.resume()
    }
    
    deinit {
        task?.cancel()
    }
}
