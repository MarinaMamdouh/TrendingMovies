//
//  ViewController.swift
//  TrendingMovies
//
//  Created by Marina on 14/06/2022.
//

import UIKit

class MoviesListViewController: BaseViewController {
    var tableView = UITableView()
    var moviesList = [Movie]()
    var viewModel = MoviesListViewModel()
    var currentMovie: Movie? {
        didSet {
            fetchCurrentMovieDetails()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupTable()
        requestMovies()
    }
    
    override func styleUIComponents() {
        super.styleUIComponents()
        // Style tableView
        let titleLocalizedKey =  Constants.NavigationBarTitles.moviesList
        title = String(localizedKey: titleLocalizedKey)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func autoLayoutUIComponents() {
        super.autoLayoutUIComponents()
        
        // Auto Layout TableView
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            // top Constraint
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            // Leading Constraint
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            // Trailing Constraint
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            // Bottom Constraint
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }

}

// Request Data from ViewModel

extension MoviesListViewController {
    
    func requestMovies() {
        Task {
            do {
                self.moviesList = try await viewModel.getListOfMovies()
            } catch {
                
            }
        }
    }
}

// UItableView Delegates and Datasource

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
    func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
