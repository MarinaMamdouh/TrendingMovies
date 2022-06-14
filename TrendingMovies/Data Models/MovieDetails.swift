//
//  MovieDetails.swift
//  TrendingMovies
//
//  Created by Marina on 14/06/2022.
//

import Foundation

struct MovieDetails: Codable {
    let overview: String
    let genres: [Genre]
    let vote: Double
    let votesCount: Int
    let budget: Int
    let revenue: Int
}

extension MovieDetails {
    enum CodingKeys: String, CodingKey {
        case overview
        case revenue
        case budget
        case genres
        case vote = "vote_average"
        case votesCount = "vote_count"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}
