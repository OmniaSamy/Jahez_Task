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
        VStack {
            List(viewModel.trendingMoviesList, id: \.movieID) { movie in
                Text(movie.title ?? "")
            }
            
           
        }.onAppear {
            viewModel.getTrendingMovies()
        }.loadingOverlay(isLoading: viewModel.isLoading) // ✅ Use it here
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel.mock())
}
