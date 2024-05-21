//
//  Double+customFormatted.swift
//  CoinGekoWallester
//
//  Created by Denis Sinitsa on 21.05.2024.
//

import SwiftUI

extension Double {
    var customFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "," // razdelitel dlja thousands
        formatter.locale = Locale(identifier: "en_US") // poka wto en_US

        if self < 100_000 {
            formatter.maximumFractionDigits = 2
            
            formatter.minimumFractionDigits = 2
            
        } else {
            formatter.maximumFractionDigits = 0
        }

        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
