//
//  MovieStatisticsView.swift
//  TrendingMovies
//
//  Created by Marina on 19/06/2022.
//

import UIKit

class MovieStatisticsView: UIView {
    var viewModel: MovieDetailsViewModel!
    var stackView = UIStackView()
    var voteLabel = UILabel()
    var budgetLabel = UILabel()
    var genresLabel = UILabel()
    var boxOfficeLabel = UILabel()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        styleUIComponents()
        autoLayoutUIComponents()
    }
}

// Main UI Handling

extension MovieStatisticsView: UIHandling {
    func styleUIComponents() {
        styleStackView()
        styleVoteLabel()
        styleBoxOfficeLabel()
        styleBudgetLabel()
        styleGenresLabel()
        
    }
    
    func autoLayoutUIComponents() {
        layoutStackView()
    }
    
}

// Styling UI Components
extension MovieStatisticsView {
    func styleStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = CGFloat(Constants.verticalSpacing)
    }
    
    func styleVoteLabel() {
        let attachment = NSTextAttachment()
        let config = UIImage.SymbolConfiguration(hierarchicalColor: .orange)
        attachment.image = UIImage(systemName: Constants.Icons.star, withConfiguration: config)

        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = viewModel.getFormattedVote()
        imageString.append(textString)
        voteLabel.attributedText = imageString
        voteLabel.textAlignment = .center
        voteLabel.numberOfLines = 2
        voteLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleBoxOfficeLabel() {
        boxOfficeLabel.attributedText = viewModel.getFormattedRevenue()
        boxOfficeLabel.textAlignment = .center
        boxOfficeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleBudgetLabel() {
        budgetLabel.attributedText = viewModel.getFormattedBudget()
        budgetLabel.textAlignment = .center
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleGenresLabel() {
        genresLabel.attributedText = viewModel.getGenres()
        genresLabel.numberOfLines = 0
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

// Handling Auto Layout of UI Components
extension MovieStatisticsView {
    func layoutStackView() {
        self.addSubview(stackView)
        addViewsToStack()
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func addViewsToStack() {
        stackView.addArrangedSubview(voteLabel)
        stackView.addArrangedSubview(boxOfficeLabel)
        stackView.addArrangedSubview(budgetLabel)
        stackView.addArrangedSubview(genresLabel)
    }
}
