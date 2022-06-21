//
//  MovieDetailsViewController.swift
//  TrendingMovies
//
//  Created by Marina on 19/06/2022.
//

import UIKit

class MovieDetailsViewController: BaseViewController {
    var viewModel: MovieDetailsViewModel!
    // UIComponents
    var moviePosterImageView = UIImageView()
    var movieDescTextView = UITextView()
    var movieTitleLabel = UILabel()
    var movieStatsView = MovieStatisticsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func styleUIComponents() {
        super.styleUIComponents()
        self.view.backgroundColor = .systemBackground
        styleMovieImage()
        styleMovieStatsView()
        styleMovieDescTextView()
    }
    
    override func autoLayoutUIComponents() {
        super.autoLayoutUIComponents()
        layoutImage()
        layoutStatsView()
        layoutDescription()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

// Styling UIComponents
extension MovieDetailsViewController {
    
    func styleMovieTitleLabel(){
        
    }
    
    func styleMovieStatsView() {
        movieStatsView.viewModel = self.viewModel
        movieStatsView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleMovieImage() {
        moviePosterImageView.contentMode = .scaleAspectFill
        moviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        let movieImagePath = viewModel.movieDetails.imagePath
        Task { [weak self] in
            let movieImage = try await ImageLoader().getImage(of: movieImagePath)
            self?.moviePosterImageView.image = movieImage
        }
    }
    
    func styleMovieDescTextView() {
        
        movieDescTextView.text = viewModel.movieDetails.overview
        movieDescTextView.font = Constants.Fonts.bodyFont
        movieDescTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

// Handling Layout of UIComponents
extension MovieDetailsViewController {
    func layoutStatsView() {
        self.view.addSubview(movieStatsView)
        NSLayoutConstraint.activate([
            movieStatsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            movieStatsView.leadingAnchor.constraint(equalToSystemSpacingAfter: moviePosterImageView.trailingAnchor, multiplier: 1),
            self.view.trailingAnchor.constraint(equalToSystemSpacingAfter: movieStatsView.trailingAnchor, multiplier: 2),
            movieStatsView.bottomAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor)
        ])
    }
    func layoutImage() {
        self.view.addSubview(moviePosterImageView)
        NSLayoutConstraint.activate([
            moviePosterImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            moviePosterImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 2),
            moviePosterImageView.heightAnchor.constraint(equalToConstant: 300),
            moviePosterImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
        ])
    }
    
    func layoutDescription() {
        
        self.view.addSubview(movieDescTextView)
        NSLayoutConstraint.activate([
            movieDescTextView.topAnchor.constraint(equalToSystemSpacingBelow: moviePosterImageView.bottomAnchor, multiplier: 2),
            movieDescTextView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 2),
            self.view.trailingAnchor.constraint(equalToSystemSpacingAfter: movieDescTextView.trailingAnchor, multiplier: 2),
            self.view.bottomAnchor.constraint(equalToSystemSpacingBelow: movieDescTextView.bottomAnchor, multiplier: 1)
        ])
    }
    
}
