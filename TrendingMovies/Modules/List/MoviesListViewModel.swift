//
//  MoviesListViewModel.swift
//  TrendingMovies
//
//  Created by Marina on 18/06/2022.
//

import Foundation

class MoviesListViewModel: ViewModelType {
    private var currentPage = -1
    private var requestHandler = RequestHandler()
    var moviesCount: Int {
        self.movies.count
    }
    private(set) var movies = [Movie]() {
        didSet {
            delegate?.viewModelDidUpdate()
        }
    }
    var delegate: ViewModelDelegate?
    
    func loadMovies() {
        self.goToNextPage()
        Task { [weak self] in
            let movies: MoviesList = try await requestHandler.request(route: APIRoute.getMoviesList(page: currentPage))
            self?.movies = movies.results
        
        }
        
    }
    
    private func goToNextPage() {
        currentPage += 1
    }
}
