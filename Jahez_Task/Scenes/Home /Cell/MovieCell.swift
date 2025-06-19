//
//  MovieCell.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 18/06/2025.
//

import SwiftUI

struct MovieCell: View {
    
    let movieModel: MovieModel?
    
    @StateObject private var imageLoader: ImageLoader
    
    init(movie: MovieModel) {
        
        self.movieModel = movie
        
        let imageURL = Environment.imageBaseURL + (movie.posterPath ?? "")
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: imageURL))
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()
                    .cornerRadius(12)
            } else {
                Color.gray.opacity(0.2)
                    .frame(height: 180)
                    .cornerRadius(12)
            }
            
            Text(movieModel?.title ?? "")
                .font(.system(size: 14, weight: .semibold))
                .lineLimit(2)
            
            Text(movieModel?.releaseDate ?? "")
                .font(.system(size: 12))
                .lineLimit(1)
                .foregroundColor(.secondary)
        }
    }
    
    
}

#Preview {
    
    MovieCell(
        movie: MovieModel(
            id: 1,
            posterPath: "https://images.unsplash.com/photo-1517602302552-471fe67acf66",
            title: "Interstellar",
            releaseDate: "2014"
        )
    )
    .padding()
    .previewLayout(.sizeThatFits)
}
