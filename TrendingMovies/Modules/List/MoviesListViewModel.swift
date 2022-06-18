//
//  MoviesListViewModel.swift
//  TrendingMovies
//
//  Created by Marina on 18/06/2022.
//

import Foundation

class MoviesListViewModel {
    private var currentPage = -1
    private var requestHandler = RequestHandler()
    
    func getListOfMovies() async throws -> [Movie] {
        self.goToNextPage()
        
        let movies: MoviesList = try await requestHandler.request(route: APIRoute.getMoviesList(page: currentPage))
        
        return movies.results
        
    }
    
    private func goToNextPage() {
        currentPage += 1
    }
}
