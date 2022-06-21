//
//  ViewModelDelegate.swift
//  TrendingMovies
//
//  Created by Marina on 18/06/2022.
//

import Foundation

protocol ViewModelDelegate {
    
    func viewModelDidUpdate()
    func viewModelHasError()
}
