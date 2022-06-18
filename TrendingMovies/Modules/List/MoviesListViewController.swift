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
    
    func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
}
