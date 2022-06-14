//
//  MoviesList.swift
//  TrendingMovies
//
//  Created by Marina on 14/06/2022.
//

import Foundation

struct MoviesList: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let originalTitle: String
    let englishTitle: String
    let language: String
    let imagePath: String
    
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case englishTitle = "title"
        case language = "original_language"
        case imagePath = "poster_path"
    }
}
