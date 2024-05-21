//
//  CoinRowView.swift
//  Wallester
//
//  Created by Denis Sinitsa on 20.05.2024.
//

import Foundation
import SwiftUI

struct CoinRowView: View {
    @ObservedObject var viewModel: MarketViewModel
    
    var body: some View {
        VStack {
            buildMainContent()
        }
    }
    
    @ViewBuilder
    func buildMainContent() -> some View {
        VStack(spacing: 5) {
            ForEach(viewModel.allCoins, id: \.id) { coin in
                Swipe(content: {
                    HStack {
                        leftSide(image: coin.image, symbol: coin.symbol, currentPrice: coin.currentPrice, priceChange: coin.priceChangePercentage1H ?? 0.0)
                        Spacer()
                        rightSide(marketCap: coin.marketCap ?? 0.0)
                    }
                    .padding()
                }, right1: {
                    Rectangle()
                        .fill(Color.red)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }, right2: {
                    Rectangle()
                        .fill(Color.green)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }, right3: {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }, itemHeight: 60)
            }
        }
        .onAppear {
            viewModel.fetchCrypto(forceUpdate: true)
        }
    }
    
    func leftSide(image: String, symbol: String, currentPrice: Double, priceChange: Double) -> some View {
        HStack {
            VStack(spacing: 2) {
                AsyncImage(url: URL(string: image)!)
                    .frame(width: 15, height: 15)
                
                Text(symbol.uppercased())
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .frame(width: 40)
            
            Text(currentPrice.customFormatted)
            
            priceChangeView(priceChange: priceChange)
        }
    }
    
    func rightSide(marketCap: Double?) -> some View {
        HStack(spacing: 5) {
            Text(marketCap?.customFormatted ?? "0")
                .font(.headline)
            
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 80, height: 40)
        }
    }
    
    func priceChangeView(priceChange: Double?) -> some View {
        let displayChange = String(format: "%.2f%%", priceChange ?? 0)
        return Text("\(displayChange)")
            .foregroundColor(getColorForPercentage(priceChange))
            .font(.subheadline)
    }
    
    func getColorForPercentage(_ percentage: Double?) -> Color {
        guard let percentage = percentage else { return .black }
        return percentage >= 0 ? .green : .red
    }
}
