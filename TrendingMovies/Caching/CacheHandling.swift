//
//  CacheHandling.swift
//  TrendingMovies
//
//  Created by Marina on 19/06/2022.
//

import Foundation

protocol CacheHandling {
    associatedtype DataType
    associatedtype KeyType

    func getData(ofKey key: KeyType) -> DataType?
    func save(data: DataType, withKey key: KeyType)
}
