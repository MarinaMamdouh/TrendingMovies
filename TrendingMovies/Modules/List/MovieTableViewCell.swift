//
//  MovieTableViewCell.swift
//  TrendingMovies
//
//  Created by Marina on 18/06/2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let identifier = Constants.TableCellsIdentifiers.movieCell
    private var configuration: UIListContentConfiguration?
    
    func configure(with movie: Movie) {
        // choose default cell configuration( image and text components)
        self.configuration = self.defaultContentConfiguration()
        self.configuration?.text = movie.englishTitle
        self.configuration?.textProperties.font =  Constants.Fonts.subTitleFont
        self.setupImageConfiguartion(with: movie.imagePath)
    }
    
    private func setupImageConfiguartion(with path: String) {
        // add maximum size to the image
        configuration?.imageProperties.maximumSize =  Constants.ImagesSizes.movieCellImage
        
        // load image of given movie (poster path)
        Task {
            configuration?.image = try await ImageLoader().getImage(of: path)
            
            self.contentConfiguration = configuration
        }
    }
}
