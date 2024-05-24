//
//  CoinList.swift
//  CoinGekoWallester
//
//  Created by Denis Sinitsa on 22.05.2024.
//

import SwiftUI

struct CoinList: View {
    @ObservedObject var viewModel: MarketViewModel
    @State private var rowHeights: [String: CGFloat] = [:]
    
    var body: some View {
        ScrollView {
            VStack {
                buildMainContent()
            }
            .padding(.horizontal, 10)
            .onAppear {
                viewModel.fetchCrypto(forceUpdate: true)
            }
        }
    }
    
    @ViewBuilder
    func buildMainContent() -> some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                leftListHeader()
                ForEach(viewModel.allCoins, id: \.id) { coin in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            leftSide(image: coin.image, name: coin.name, symbol: coin.symbol)
                                .background(GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            rowHeights[coin.id] = geo.size.height
                                        }
                                        .onChange(of: geo.size.height) { newHeight in
                                            rowHeights[coin.id] = newHeight
                                        }
                                })
                        }
                        .frame(maxHeight: 95)
                        
                        customDivider()
                    }
                }
            }
            
            ScrollView(.horizontal) {
                VStack(spacing: 0) {
                    rightListHeader()
                    ForEach(viewModel.allCoins, id: \.id) { coin in
                        rightSide(currentPrice: coin.currentPrice, priceChange1H: coin.priceChangePercentage1H ?? 0.0, priceChange24H: coin.priceChangePercentage24H ?? 0.0, priceChange7D: coin.priceChangePercentage7D ?? 0.0, volume24h: coin.volume24h ?? 0.0, marketCap: coin.marketCap ?? 0.0, id: coin.id)
                            .frame(height: rowHeights[coin.id] ?? 0)
                        
                        customDivider()
                    }
                }
            }
        }
    }
    
    private func leftListHeader() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 5) {
                Button(action: {
                    
                }) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.system(size: 7))
                }
                
                Text("#")
                    .font(.system(size: 9))
                
                Text("Coin")
                    .font(.fontSemiBoldUltraSmall)
                
                Spacer()
            }
            .padding(.leading, 23)
            .frame(width: 175)
            .padding(.leading, 10)
            
            customDivider()
        }
        .padding(.vertical, 5) // ostavit???
    }
    
    private func rightListHeader() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 5) {
                Button(action: {
                    
                }) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.system(size: 7))
                }
                
                Text("Price")
                    .font(.fontSemiBoldUltraSmall)
                
                Spacer()
            }
            .padding(.leading, 75)
            .frame(width: 175)
            .padding(.leading, 10)
            
            customDivider()
        }
        .padding(.vertical, 5) // ostavit???
    }
    
    private func leftSide(image: String, name: String, symbol: String) -> some View {
        HStack(spacing: 5) {
            Button(action: { }) {
                Image(systemName: "star")
                    .font(.system(size: 14))
            }
            
            Text("1")
                .font(.fontRegularSmall)
            
            HStack {
                AsyncImage(url: URL(string: image)!)
                    .frame(width: 20, height: 20)
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.fontSemiBoldSmall)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                    
                    Text(symbol.uppercased())
                        .font(.fontSemiBoldSmall)
                        .foregroundColor(.gray)
                }
            }
            .padding(10)
            
            Spacer()
        }
        .frame(width: 175)
        .padding(.leading, 10)
    }
    
    private func rightSide(currentPrice: Double, priceChange1H: Double, priceChange24H: Double, priceChange7D: Double, volume24h: Double, marketCap: Double, id: String) -> some View {
        ZStack {
            Color.green.opacity(0.4)
            
            HStack(spacing: 5) {
                Button(action: { }) {
                    Text("Buy")
                        .font(.fontSemiBoldUltraSmall)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.green, lineWidth: 2)
                        )
                }
                
                VStack {
                    Text("$\(currentPrice.customFormatted)")
                        .font(.fontRegularSmall)
                }
                .frame(maxWidth: 100, alignment: .trailing)
                
                HStack(spacing: 25) {
                    /// 1h
                    HStack(spacing: 2) {
                        getTriangle(priceChange1H)
                        priceChangeView(priceChange: priceChange1H)
                    }
                    .frame(maxWidth: 100, alignment: .trailing)
                    
                    /// 24h
                    HStack(spacing: 2) {
                        getTriangle(priceChange24H)
                        priceChangeView(priceChange: priceChange24H)
                    }
                    .frame(maxWidth: 100, alignment: .trailing)
                    
                    /// 7d
                    HStack(spacing: 2) {
                        getTriangle(priceChange7D)
                        priceChangeView(priceChange: priceChange7D)
                    }
                    .frame(maxWidth: 100, alignment: .trailing)
                }
                .frame(width: 255, alignment: .trailing)
                .padding(.leading, 10)
                
                HStack {
                    Text("$\(volume24h.customFormatted)")
                }
                .frame(maxWidth: 160, alignment: .trailing)
                
                HStack {
                    Text("$\(marketCap.customFormatted)")
                }
                .frame(maxWidth: 180, alignment: .trailing)
                
                Spacer()
            }
            .padding(.horizontal, 10)
        }
        .frame(width: 800)
    }
}

#Preview {
    CoinList(viewModel: MarketViewModel())
}
