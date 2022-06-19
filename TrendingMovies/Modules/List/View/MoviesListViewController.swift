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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
        setupTable()
        viewModel.loadMovies()
    }
    
    override func styleUIComponents() {
        super.styleUIComponents()
        // Style NavigationBar
        let titleLocalizedKey =  Constants.NavigationBarTitles.moviesList
        title = String(localizedKey: titleLocalizedKey)
        // Style tableView
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

// UItableView Delegates and Datasource

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellContentHeight = Constants.ImagesSizes.movieCellImage.height
        let heightPadding = CGFloat(Constants.heightPadding)
        return cellContentHeight + heightPadding
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell
        guard let cell = cell else {
            return UITableViewCell()
        }
        let movieToBeDisplayed = viewModel.movies[indexPath.row]
        cell.configure(with: movieToBeDisplayed)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movies[indexPath.row]
        Task {
            do {
                let details = try await viewModel.getDetails(of: selectedMovie)
                launchMovieDetailsViewController(with: details)
                
            } catch {
                // show alert of the error or something
            }
            
        }
    }
    
    func launchMovieDetailsViewController(with details: MovieDetails) {
        // create the MovieDetails Module
        let movieDetailsViewController = MovieDetailsViewController()
        movieDetailsViewController.viewModel = MovieDetailsViewModel(details)
        // push it to the app navigationController
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
}

// Scrolling Handling Methods

extension MoviesListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if didReachBottom(scrollView) && !viewModel.isLoading {
            self.tableView.tableFooterView = createSpinner()
            viewModel.loadMovies()
        }
    }
    
    func didReachBottom(_ scrollView: UIScrollView) -> Bool {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let remaingHeight = maximumOffset - currentOffset
        
        if remaingHeight <= CGFloat(Constants.spinnerViewHeight) {
            return true
        }
        
        return false
    }
    
    func createSpinner() -> UIView {
        let spinnerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: CGFloat(Constants.spinnerViewHeight))))
        let spinnerActivity =  UIActivityIndicatorView()
        spinnerActivity.center = spinnerView.center
        spinnerView.addSubview(spinnerActivity)
        spinnerActivity.startAnimating()
        return spinnerView
    }
}

// ViewModel Updating Handling

extension MoviesListViewController: ViewModelDelegate {
    func viewModelDidUpdate() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    func setupViewModel() {
        viewModel.delegate = self
    }
    
}
