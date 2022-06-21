//
//  MovieDetailsViewModel.swift
//  TrendingMovies
//
//  Created by Marina on 19/06/2022.
//

import Foundation

class MovieDetailsViewModel: ViewModelType {
    var delegate: ViewModelDelegate?
    private(set) var movieDetails: MovieDetails {
        didSet {
            delegate?.viewModelDidUpdate()
        }
    }
    
    init(_ details: MovieDetails) {
        self.movieDetails = details
    }
}

// Logic of formatting values to prepare it for view
extension MovieDetailsViewModel {
    
    func getFormattedVote() -> NSAttributedString {
        let formattedVoteString = NSMutableAttributedString()
        let voteScoreString = " \(movieDetails.vote)/" +
                              "\(String(localizedKey: Constants.tenNumberText))"
        let voteScoreAttributedString = NSAttributedString(string: voteScoreString, attributes: [NSAttributedString.Key.font: Constants.Fonts.subTitleBoldFont])
        formattedVoteString.append(voteScoreAttributedString)
        
        let voteCountString = "\n(\(movieDetails.votesCount) " +
                        "\(String(localizedKey: Constants.votesText)))"
        let voteCountAttributedString = NSAttributedString(string: voteCountString, attributes: [NSAttributedString.Key.font: Constants.Fonts.smallFont])
        formattedVoteString.append(voteCountAttributedString)
        
        return formattedVoteString
    }
    
    func getFormattedRevenue() -> NSAttributedString {
        let formattedRevenueString = NSMutableAttributedString(string: "\(String(localizedKey: Constants.boxOfficeText)): ", attributes: [NSAttributedString.Key.font: Constants.Fonts.bodyFontBold])
        let revenueString = "\(movieDetails.revenue.toMoney)"
        let revenueAttributedString = NSAttributedString(string: revenueString, attributes: [NSAttributedString.Key.font: Constants.Fonts.smallFont])
        formattedRevenueString.append(revenueAttributedString)
        return formattedRevenueString
    }
    
    func getFormattedBudget() -> NSAttributedString {
        let formattedBudgetString = NSMutableAttributedString(string: "\(String(localizedKey: Constants.budgetText)): ", attributes: [NSAttributedString.Key.font: Constants.Fonts.bodyFontBold])
        
        let budgetString = "\(movieDetails.budget.toMoney)"
        let budgetAttributedString = NSAttributedString(string: budgetString, attributes: [NSAttributedString.Key.font: Constants.Fonts.smallFont])
        
        formattedBudgetString.append(budgetAttributedString)
        return formattedBudgetString
    }
    
    func getGenres() -> NSAttributedString {
        let formattedGenreString = NSMutableAttributedString(string: "\(String(localizedKey: Constants.genresText)): ", attributes: [NSAttributedString.Key.font: Constants.Fonts.bodyFontBold])
        
        let genresString = getGenresString()
        let genresAttributedString = NSAttributedString(string: genresString, attributes: [NSAttributedString.Key.font: Constants.Fonts.smallFont])
        
        formattedGenreString.append(genresAttributedString)
        return formattedGenreString
    }
    
    private func getGenresString() -> String {
        var genresString = ""
        var index = 0
        let lastIndex = movieDetails.genres.count - 1
        for genre in movieDetails.genres {
            genresString.append(genre.name)
            if index < lastIndex {
                genresString.append(", ")
            }
            index += 1
        }
        return genresString
    }
}
