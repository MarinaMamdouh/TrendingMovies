//
//  Errors.swift
//  TrendingMovies
//
//  Created by Marina on 21/06/2022.
//

import Foundation

/// This Enum represents request error types
enum RequestError: Error {
    case networkError(description: String)
    case parsingError
    case noData

    var description: String {
        switch self {
        case .networkError(let description):
            return description
        case .parsingError:
            return "Error while parsing json to data model"
        case .noData:
            return "No Data is returned from request"
        }
    }
    
    var localizedMessage: String {
        switch self {
        case .networkError(_):
            return String(localizedKey: Constants.ErrorMessages.networkError)
        case .parsingError:
            return String(localizedKey: Constants.ErrorMessages.parsingDataError)
        case .noData:
            return String(localizedKey: Constants.ErrorMessages.noData)
        }
    }

}
