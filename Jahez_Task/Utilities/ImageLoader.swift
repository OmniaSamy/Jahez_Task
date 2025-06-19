//
//  ImageLoader.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 18/06/2025.
//

import Foundation
import SwiftUI

final class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?

    private static let cache = NSCache<NSURL, UIImage>()
    private var url: URL?
    private var task: URLSessionDataTask?

    init(url: String) {
        self.url = URL(string: url)
        loadImage()
    }

    deinit {
        task?.cancel()
    }

    func loadImage() {
        
        guard let url else { return }

        // Return from cache if available
        if let cached = Self.cache.object(forKey: url as NSURL) {
            self.image = cached
            return
        }

        // Otherwise, fetch from network
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let self,
                let data,
                let downloaded = UIImage(data: data)
            else {
                return
            }

            // Cache the image
            Self.cache.setObject(downloaded, forKey: url as NSURL)

            // Publish on main thread
            DispatchQueue.main.async {
                self.image = downloaded
            }
        }
        task?.resume()
    }
}
