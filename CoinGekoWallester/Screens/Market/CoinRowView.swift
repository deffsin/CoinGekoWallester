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
    NavigationView {
      List(viewModel.allCoins) { coin in
        HStack {
          AsyncImage(url: URL(string: coin.image)!)
            .frame(width: 50, height: 50)
          VStack(alignment: .leading) {
            Text(coin.name)
              .font(.headline)
            Text(coin.symbol.uppercased())
              .font(.subheadline)
              .foregroundColor(.gray)
          }
          Spacer()
          VStack(alignment: .trailing) {
            Text(String(format: "$%.2f", coin.currentPrice))
              .font(.headline)
            priceChangeView(timeFrame: "1h", change: coin.priceChangePercentage1H)
            priceChangeView(timeFrame: "24h", change: coin.priceChangePercentage24H)
            priceChangeView(timeFrame: "7d", change: coin.priceChangePercentage7D)
          }
        }
      }
      .navigationTitle("Cryptocurrencies")
      .navigationBarItems(
        trailing: Button(
          action: {
            viewModel.fetchCrypto(forceUpdate: true)
          },
          label: {
            Image(systemName: "arrow.clockwise")
          })
      )
      .onAppear {
        viewModel.fetchCrypto(forceUpdate: true)
      }
      .overlay(
        Group {
          if viewModel.isLoading {
            ProgressView("Loading...")
          } else if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
              .foregroundColor(.red)
              .padding()
          }
        }
      )
    }
  }

  private func priceChangeView(timeFrame: String, change: Double?) -> some View {
    let displayChange = String(format: "%.2f%%", change ?? 0)
    return Text("\(timeFrame): \(displayChange)")
      .foregroundColor(getColorForPercentage(change))
      .font(.subheadline)
  }

  private func getColorForPercentage(_ percentage: Double?) -> Color {
    guard let percentage = percentage else { return .black }
    return percentage >= 0 ? .green : .red
  }
}
