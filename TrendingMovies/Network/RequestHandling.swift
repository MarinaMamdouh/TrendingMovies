//
//  RequestHandling.swift
//  TrendingMovies
//
//  Created by Marina on 14/06/2022.
//

import Foundation

/// Protocol for the `RequestHandler`.
protocol RequestHandling {
    
    func request<T>(route: APIRoute) async throws -> T where T: Codable
}
