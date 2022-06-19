//
//  ImageCaching.swift
//  TrendingMovies
//
//  Created by Marina on 19/06/2022.
//

import UIKit

class ImageCaching: CacheHandling {
    typealias DataType = UIImage
    typealias KeyType = NSURL
    static let reference = ImageCaching()
    // Using NScache to handle RAM
    private let imageCache = NSCache<KeyType, DataType>()
    
    func getData(ofKey key: NSURL) -> UIImage? {
        return imageCache.object(forKey: key)
    }
    
    func save(data: UIImage, withKey key: NSURL) {
        imageCache.setObject(data, forKey: key)
    }
    
}
