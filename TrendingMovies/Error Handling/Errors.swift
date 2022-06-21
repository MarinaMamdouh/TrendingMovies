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
    // for debugging mode
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
}

extension RequestError: LocalizedError {
    var errorDescription: String? {
           switch self {
           case .networkError(_):
               return NSLocalizedString(
                String(localizedKey: Constants.ErrorMessages.networkError),
                   comment: ""
               )
           case .parsingError:
               return NSLocalizedString(
                String(localizedKey: Constants.ErrorMessages.parsingDataError),
                   comment: ""
               )
           case .noData:
               return NSLocalizedString(
                String(localizedKey: Constants.ErrorMessages.noData),
                   comment: ""
               )

           }
       }
}
