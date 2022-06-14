//
//  APIRoute.swift
//  TrendingMovies
//
//  Created by Marina on 14/06/2022.
//

import Foundation

/// Enum that encodes the endpoints of the Movies-api. Injected to the RequestHandler.
enum APIRoute {
    case getMoviesList(page:Int)
    case getMovieDetails(id:Int)
    case getImage(name:String)

    private var api_key:String { "c9856d0cb57c3f14bf75bdc6c063b8f3" }
    private var baseListURLString: String { "https://api.themoviedb.org/3/discover/movie" }
    private var baseDetailsURLString: String {"https://api.themoviedb.org/3/movie/"}
    private var baseImageURLString: String { "https://image.tmdb.org/t/p/w500/" }

    private var url: URL? {
        switch self {
        case .getMoviesList(_):
            return URL(string: baseListURLString)
        case.getMovieDetails(let id):
            let baseURL = "\(baseDetailsURLString)" + "\(id)"
            return URL(string: baseURL)
        case .getImage(let name):
            let baseURL = "\(baseImageURLString)" + "\(name)"
            return URL(string: baseURL)
        }
    }

    private var parameters: [URLQueryItem] {
        var apiParameters = [URLQueryItem]()
        let apiKeyParameter = URLQueryItem(name: "api_key", value: self.api_key)
        apiParameters.append(apiKeyParameter)
        
        switch self {
        case .getMoviesList(let page):
            // if the given page is less than 1 so ignore the page parameter the API was designed to retrieve first page by default
            if page < 1{
                return apiParameters
            }
            let pageParamter = URLQueryItem(name: "page", value: String(page))
            apiParameters.append(pageParamter)
        default:
            apiParameters.append(contentsOf: [])
        }
        return apiParameters
    }
    
    func asURL() -> URL{
        guard let url = url else {
            preconditionFailure("Missing URL for route: \(self)")
        }
        return url
    }

    func asRequest() -> URLRequest {
        guard let url = url else {
            preconditionFailure("Missing URL for route: \(self)")
        }
        if !parameters.isEmpty{
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = parameters

            guard let parametrizedURL = components?.url else {
                preconditionFailure("Missing URL with parameters for url: \(url)")
            }
            return URLRequest(url: parametrizedURL)
        }
        
        return URLRequest(url: url)
        
    }
}
