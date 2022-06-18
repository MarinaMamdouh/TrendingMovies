//
//  LocalizedString.swift
//  TrendingMovies
//
//  Created by Marina on 18/06/2022.
//

import Foundation

extension String {
    
    init(localizedKey key: String) {
        self.init()
        let localizedString = NSLocalizedString(key, comment: "")
        self = localizedString
    }
}
