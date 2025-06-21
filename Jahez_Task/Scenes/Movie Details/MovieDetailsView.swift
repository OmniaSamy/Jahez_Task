//
//  MovieDetailsView.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 20/06/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    @StateObject private var imageLoader: ImageLoader
    
    init(viewModel: MovieDetailsViewModel) {
        
        self.viewModel = viewModel
        
        let imageURL = Environment.imageBaseURL + (viewModel.movie?.posterPath ?? "")
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: imageURL))
    }
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 16) {
                
                // image
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                } else {
                    Color.gray.opacity(0.2)
                        .frame(height: 200)
                }
                
                // geners stack
                HStack(spacing: 10) {
                    ForEach(viewModel.genreNames, id: \.self) { name in
                        Text(name)
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .foregroundColor(.red)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                    }
                }.padding(.horizontal)
                
                
                // Overview
                if let overview = viewModel.movie?.overview, !overview.isEmpty {
                    Text(overview)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                }
                
                // release data - popularity
                HStack(spacing: 40) {
                    if let releaseDate = viewModel.movie?.releaseDate {
                        Text("release Date :" + releaseDate)
                    }

                    if let popularity = viewModel.movie?.popularity {
                        Text("popularity :" + (String(format: "%.1f", popularity)) )
                    }
                }
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    
    let movie = MovieModel(
        id: 1,
        posterPath: "https://images.unsplash.com/photo-1517602302552-471fe67acf66",
        title: "Inception",
        releaseDate: "2010-07-16",
        overview: "A skilled thief who uses dream-sharing technology to steal secrets is offered a chance to erase his criminal history by planting an idea."
    )
    
    let vm = MovieDetailsViewModel(movie: movie,
                                   genres: [GenreModel(id: 1, name: "genre 1"),
                                            GenreModel(id: 2, name: "genre 2")])
    MovieDetailsView(viewModel: vm)
}
