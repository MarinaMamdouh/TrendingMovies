//
//  MoviesListViewModel.swift
//  TrendingMovies
//
//  Created by Marina on 18/06/2022.
//

import Foundation

class MoviesListViewModel: ViewModelType {
    private var currentPage = 0
    private var requestHandler = RequestHandler()
    public var isLoading = false
    var moviesCount: Int {
        self.movies.count
    }
    var errorMessage: RequestError? {
        didSet {
            guard errorMessage != nil else {
                return
            }
            changeLoadingStatus()
            delegate?.viewModelHasError()
        }
    }
    private(set) var movies = [Movie]() {
        didSet {
            changeLoadingStatus()
            delegate?.viewModelDidUpdate()
        }
    }
    var delegate: ViewModelDelegate?
    
    func loadMovies() {
        self.goToNextPage()
        changeLoadingStatus()
        Task { [weak self] in
            do {
                let movies: MoviesList = try await requestHandler.request(route: APIRoute.getMoviesList(page: currentPage))
                self?.movies.append(contentsOf: movies.results)
            } catch {
                guard error is RequestError else {
                    return
                }
                errorMessage = error as? RequestError
            }
        
        }
        
    }
    
    func getDetails(of movie: Movie) async throws -> MovieDetails {
        let details: MovieDetails = try await requestHandler.request(route: APIRoute.getMovieDetails(id: movie.id))
        return details
        
    }
    
    private func goToNextPage() {
        currentPage += 1
    }
    
    private func changeLoadingStatus() {
        self.isLoading.toggle()
    }
}
