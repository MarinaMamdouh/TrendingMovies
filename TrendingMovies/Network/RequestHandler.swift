//
//  RequestHandler.swift
//  TrendingMovies
//
//  Created by Marina on 14/06/2022.
//

import Foundation

/// This is RequestHandling implementation returns any Codable Data Model.
class RequestHandler: RequestHandling {

    func request<T>(route: APIRoute) async throws -> T where T: Codable {
        let request = route.asRequest()
        let session = URLSession.shared
        return try await withCheckedThrowingContinuation { continuation in
            let task = session.dataTask(with: request, completionHandler: { data, _, error -> Void in
                // Request Error
                if let error = error {
                    let networkError = RequestError.networkError(description: error.localizedDescription)
                    continuation.resume(with: .failure(networkError))
                    return
                }
                // check if data is not empty
                if let data = data {
                    // Try Parsing data
                    if let responseResults = self.parse(data: data, to: T.self) {
                        continuation.resume(with: .success(responseResults))
                    } else {
                        // Parsing Error
                        continuation.resume(with: .failure(RequestError.parsingError))
                    }
                } else {
                    // No Data Error
                    continuation.resume(with: .failure(RequestError.noData))
                }
            })

            task.resume()
        }
    }

    // Parse any Json data to the given Data Model Type
    private func parse<T>(data: Data, to type: T.Type ) -> T? where T: Codable {
        do {
            let dataObject = try JSONDecoder().decode(type, from: data)
            return dataObject
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
