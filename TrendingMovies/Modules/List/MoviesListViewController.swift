//
//  ViewController.swift
//  TrendingMovies
//
//  Created by Marina on 14/06/2022.
//

import UIKit

class MoviesListViewController: BaseViewController {
    var tableView: UITableView?
    var currentMovie: Movie? {
        didSet {
            fetchCurrentMovieDetails()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = Constants.NavigationBarTitles.moviesList.rawValue
        fetchFirstPageOfMovies()
        
    }
    
    override func styleUIComponents() {
        super.styleUIComponents()
        // Style tableView
        
    }
    
    override func autoLayoutUIComponents() {
        super.autoLayoutUIComponents()
        // Auto Layout TableView
    }

}

// testing data to be removed

extension MoviesListViewController {
    func fetchFirstPageOfMovies() {
        let requestHandler = RequestHandler()
        Task {
            do {
                let moviesList: MoviesList =  try await requestHandler.request(route: APIRoute.getMoviesList(page: 1))
                print("---------- Movies List -----------")
                for movie in moviesList.results {
                    DispatchQueue.main.async {
                        print(movie)
                        self.currentMovie = movie
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCurrentMovieDetails() {
        if let currentMovie = currentMovie {
            let requestHandler = RequestHandler()
            Task {
                let details: MovieDetails = try await requestHandler.request(route: APIRoute.getMovieDetails(id: currentMovie.id))
                DispatchQueue.main.async {
                    print("---------- Current Movie ------")
                    print(currentMovie)
                    print("----- Movie Details -------")
                    print(details)
                }
            }
        }
    }
}
