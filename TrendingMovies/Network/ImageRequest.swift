//
//  ImageRequest.swift
//  TrendingMovies
//
//  Created by Marina on 18/06/2022.
//

import UIKit

class ImageRequest {
    
    func request(route: APIRoute) async throws -> UIImage {
        // check if it is in caching
        let request = route.asRequest()
        let urlOfImage = route.asURL() as NSURL
        if let imageFromCache = ImageCaching.reference.getData(ofKey: urlOfImage) {
            return imageFromCache
        }
        let session = URLSession.shared
        return try await withCheckedThrowingContinuation { continuation in
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                DispatchQueue.main.async {
                    guard
                        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                        let data = data,
                        error == nil,
                        let image = UIImage(data: data)
                    else {
                        continuation.resume(with: .failure(RequestError.noData))
                        return
                        
                    }
                    // Cache the image
                    ImageCaching.reference.save(data: image, withKey: urlOfImage)
                    continuation.resume(with: .success(image))
                }
            })
            
            task.resume()
        }
    }
}
