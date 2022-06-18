//
//  ImageLoader.swift
//  TrendingMovies
//
//  Created by Marina on 18/06/2022.
//

import UIKit

class ImageLoader {
    func getImage(of name: String) async throws -> UIImage {
        let imageRequest = ImageRequest()
        let api = APIRoute.getImage(name: name)
        return try await imageRequest.request(route: api)
    }
}
