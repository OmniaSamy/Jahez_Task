//
//  HomeView.swift
//  Jahez_Task
//
//  Created by Omnia Samy on 17/06/2025.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        
        let screenWidth = UIScreen.main.bounds.width
        let spacing: CGFloat = 16
        let padding: CGFloat = 16
        let cellWidth = (screenWidth - (padding * 2 + spacing)) / 2
        
        let gridColumns = [
            GridItem(.fixed(cellWidth), spacing: spacing),
            GridItem(.fixed(cellWidth))
        ]
        
        VStack(spacing: 0) {
            
            // search bar
            SearchBar(text: $viewModel.searchText,
                      placeholder: "Search movies",
                      onClear: {
                viewModel.searchText = ""
            })
            .padding(.horizontal, 16)
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 24) {
                    
                    // genre horizontal list
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.genresList) { genre in
                                GenreCell(genreModel: genre, isSelected: viewModel.selectedGenre?.id == genre.id)
                                    .onTapGesture {
                                        viewModel.selectGenre(genre)
                                    }
                            }
                        }
                        .padding(.horizontal, padding)
                    }
                    
                    // Movies vertical list
                    LazyVGrid(columns: gridColumns, spacing: spacing) {
                        ForEach(viewModel.trendingMoviesList) { movie in
                            MovieCell(movie: movie)
                                .frame(width: cellWidth)
                                .onAppear {
                                    viewModel.loadMoreIfNeeded(currentMovie: movie)
                                }.onTapGesture {
                                    print("testest")
                                    AppManager.shared.pushViewController(viewController: Container.Movie.getMovieDetailsScreen(movie: movie, genres: viewModel.genresList))
                                }
                        }
                        if viewModel.isLoadingMore {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .padding(.vertical, 20)
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal, padding)
                }
            } .padding(.top, 16)
                .loadingOverlay(isLoading: (viewModel.isLoading && !viewModel.isLoadingMore))
                .onAppear {
                    viewModel.getOfficialGenresList()
                    viewModel.getTrendingMovies()
                }
        }
    }
}


#Preview {
    HomeView(viewModel: HomeViewModel.mock())
}
