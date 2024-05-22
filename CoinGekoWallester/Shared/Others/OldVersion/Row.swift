//
//  CoinRowView.swift
//  Wallester
//
//  Created by Denis Sinitsa on 20.05.2024.
//

// import Foundation
// import SwiftUI
// 
// 
// struct CoinRowView: View {
//     @ObservedObject var viewModel: MarketViewModel
// 
//     var body: some View {
//         VStack {
//             buildMainContent()
//         }
//     }
// 
//     @ViewBuilder
//     func buildMainContent() -> some View {
//         VStack(spacing: 5) {
//             ForEach(viewModel.allCoins, id: \.id) { coin in
//                 Swipe(content: {
//                     HStack {
//                         leftSide(image: coin.image, symbol: // coin.symbol, currentPrice: // coin.currentPrice, priceChange: // coin.priceChangePercentage1H // ?? 0.0)
//                         rightSide(marketCap: coin.marketCap ?? // 0.0)
//                     }
//                     .padding()
//                 }, right1: {
//                     rowButtonView(text: "Share", systemName: // "arrow.uturn.right", color: // .blue.opacity(0.7), action: { // print("Share") })
//                 }, right2: {
//                     rowButtonView(text: "Price alert", systemName: // "bell", color: .green.opacity(0.7), // action: { print("Price alert") })
//                 }, right3: {
//                     rowButtonView(text: "Portfolio", systemName: // "star", color: .yellow.opacity(0.7), // action: { print("Portfolio") })
//                 }, chart: {
//                     Rectangle()
//                         .fill(Color.gray)
//                         .frame(width: 110, height: 60)
//                 }, itemHeight: 60)
// 
//                 Divider()
//                     .frame(maxWidth: .infinity)
//                     .frame(height: 2)
//             }
//         }
//         .onAppear {
//             viewModel.fetchCrypto(forceUpdate: true)
//         }
//     }
// 
//     func leftSide(image: String, symbol: String, currentPrice: Double, // priceChange: Double) -> some View {
//         HStack {
//             VStack(spacing: 2) {
//                 AsyncImage(url: URL(string: image)!)
//                     .frame(width: 15, height: 15)
// 
//                 Text(symbol.uppercased())
//                     .font(.fontSemiBoldSmall)
//                     .foregroundColor(.gray)
//                     .fixedSize()
//             }
//             .frame(width: 40)
// 
//             Text(currentPrice.customFormatted)
//                 .font(.fontSemiBoldSmall)
//                 .frame(minWidth: 0, maxWidth: .infinity, alignment: // .trailing)
// 
//             priceChangeView(priceChange: priceChange)
//         }
//     }
// 
//     func rightSide(marketCap: Double?) -> some View {
//         Text("$\(marketCap?.customFormatted ?? "0")")
//             .font(.fontSemiBoldSmall)
//             .frame(width: 150, alignment: .trailing)
//     }
// 
//     func priceChangeView(priceChange: Double?) -> some View {
//         let absoluteChange = abs(priceChange ?? 0)
//         let displayChange = String(format: "%.2f%%", // absoluteChange)
// 
//         return Text(displayChange)
//             .foregroundColor(getColorForPercentage(priceChange))
//             .font(.fontSemiBoldSmall)
//             .frame(minWidth: 0, maxWidth: 50, alignment: .trailing)
//             .layoutPriority(1)
//     }
// 
//     func getColorForPercentage(_ percentage: Double?) -> Color {
//         guard let percentage = percentage else { return .black }
//         return percentage >= 0 ? .green : .red
//     }
// 
//     func rowButtonView(text: String, systemName: String, color: Color, // action: @escaping () -> Void) -> some View {
//         Button(action: action) {
//             VStack(spacing: 2) {
//                 Image(systemName: systemName)
// 
//                 Text(text)
//                     .font(.fontRegularUltraSmall)
//             }
//             .frame(maxWidth: .infinity, maxHeight: .infinity)
//             .foregroundStyle(.white)
//             .background(color)
//         }
//     }
// }
// 
// #Preview {
//   CoinRowView(viewModel: MarketViewModel())
// }
// 
