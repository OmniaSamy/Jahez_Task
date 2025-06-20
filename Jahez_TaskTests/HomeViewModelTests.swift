//
//  Jahez_TaskTests.swift
//  Jahez_TaskTests
//
//  Created by Omnia Samy on 17/06/2025.
//

import XCTest
@testable import Jahez_Task

final class HomeViewModelTests: XCTestCase  {
    
    func testSearchMoviesSuccess() {
        
        let homeViewModel = HomeViewModel.mock()
        homeViewModel.searchText = "Inception"
        
        homeViewModel.applyFilters()
        
        XCTAssertEqual(homeViewModel.trendingMoviesList.count , 1)
    }
    
    func testSearchMoviesFailure() {
        
        let homeViewModel = HomeViewModel.mock()
        homeViewModel.searchText = "no-match"
        
        homeViewModel.applyFilters()
        
        XCTAssertEqual(homeViewModel.trendingMoviesList.count , 1)
    }
}
