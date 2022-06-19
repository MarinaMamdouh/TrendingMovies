//
//  MoneyFormatting.swift
//  TrendingMovies
//
//  Created by Marina on 19/06/2022.
//

import Foundation

extension Int {
    var toMoney: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        if let formattedAmount = formatter.string(from: self as NSNumber) {
            return formattedAmount
        }
        return ""
    }
}
