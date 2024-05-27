//
//  CoinListHelpers.swift
//  CoinGekoWallester
//
//  Created by Denis Sinitsa on 23.05.2024.
//

import SwiftUI

func customDivider() -> some View {
    ZStack {
        Divider()
            .frame(maxWidth: .infinity)
            .frame(height: 1)
    }
}

func priceChangeView(priceChange: Double?) -> some View {
    let absoluteChange = abs(priceChange ?? 0)
    let displayChange = String(format: "%.2f%%", absoluteChange)
    
    return Text(displayChange)
        .foregroundColor(getColorForPercentage(priceChange))
        .font(.fontRegularUltraSmall)
}

func getColorForPercentage(_ percentage: Double?) -> Color {
    guard let percentage = percentage else { return .black }
    return percentage >= 0 ? .green : .red
}

func getTriangle(_ percentage: Double?) -> some View {
    Group {
        if let percentage = percentage {
            if percentage >= 0 {
                Image(systemName: "arrowtriangle.up.fill")
            } else {
                Image(systemName: "arrowtriangle.down.fill")
            }
        } else {
            EmptyView()
        }
    }
    .foregroundColor(getColorForPercentage(percentage))
    .font(.system(size: 7))
}
