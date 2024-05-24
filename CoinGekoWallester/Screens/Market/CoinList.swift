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
                ForEach(viewModel.sortedCoins, id: \.id) { coin in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            leftSide(rank: coin.rank, image: coin.image, name: coin.name, symbol: coin.symbol)
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
                    ForEach(viewModel.sortedCoins, id: \.id) { coin in
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
            HStack(spacing: 8) {
                Image(systemName: "arrowtriangle.up.fill")
                    .font(.system(size: 7))
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
                    .onTapGesture {
                        viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                    }
                
                Text("#")
                    .font(.system(size: 9))
                
                Text("Coin")
                    .font(.fontSemiBoldUltraSmall)
                
                Spacer()
            }
            .padding(.leading, 19)
            .frame(width: 175)
            .padding(.leading, 1)
            
            customDivider()
        }
    }
    
    private func rightListHeader() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 5) {
                
                /// Price
                HStack(spacing: 5) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.system(size: 7))
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
                        .onTapGesture {
                            viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                        }
                    
                    Text("Price")
                        .font(.fontSemiBoldUltraSmall)
                }
                .frame(maxWidth: 150, alignment: .trailing)
                
                /// 1h
                HStack(spacing: 5) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.system(size: 7))
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .pricePercentage1h ? 0 : 180))
                        .onTapGesture {
                            viewModel.sortOption = viewModel.sortOption == .pricePercentage1h ? .pricePercentage1hReversed : .pricePercentage1h
                        }
                    
                    
                    Text("1h")
                        .font(.fontSemiBoldUltraSmall)
                }
                .frame(maxWidth: 75, alignment: .trailing)
                
                /// 24h
                HStack(spacing: 5) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.system(size: 7))
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .pricePercentage24h ? 0 : 180))
                        .onTapGesture {
                            viewModel.sortOption = viewModel.sortOption == .pricePercentage24h ? .pricePercentage24hReversed : .pricePercentage24h
                        }
                    
                    Text("24h")
                        .font(.fontSemiBoldUltraSmall)
                }
                .frame(maxWidth: 90, alignment: .trailing)
                
                /// 7d
                HStack(spacing: 5) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.system(size: 7))
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .pricePercentage7d ? 0 : 180))
                        .onTapGesture {
                            viewModel.sortOption = viewModel.sortOption == .pricePercentage7d ? .pricePercentage7dReversed : .pricePercentage7d
                        }
                    
                    Text("7d")
                        .font(.fontSemiBoldUltraSmall)
                }
                .frame(maxWidth: 88, alignment: .trailing)
                
                /// 24h Volume
                HStack(spacing: 5) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.system(size: 7))
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .volume24h ? 0 : 180))
                        .onTapGesture {
                            viewModel.sortOption = viewModel.sortOption == .volume24h ? .volume24hReversed : .volume24h
                        }
                    
                    Text("24h Volume")
                        .font(.fontSemiBoldUltraSmall)
                }
                .frame(maxWidth: 160, alignment: .trailing)

                /// Market Cap
                HStack(spacing: 5) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.system(size: 7))
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .marketCap ? 0 : 180))
                        .onTapGesture {
                            viewModel.sortOption = viewModel.sortOption == .marketCap ? .marketCapReversed : .marketCap
                        }
                    
                    Text("Market Cap")
                        .font(.fontSemiBoldUltraSmall)
                }
                .frame(maxWidth: 167, alignment: .trailing)
                
                /// Chart 7d
                HStack(spacing: 5) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "arrowtriangle.up.fill")
                            .font(.system(size: 7))
                    }
                    
                    Text("Last 7 Days")
                        .font(.fontSemiBoldUltraSmall)
                }
                .frame(maxWidth: 163, alignment: .trailing)
                
                Spacer()
            }
            .padding(.leading, 10)
            .frame(width: 940)
            
            customDivider()
        }
    }
    
    private func leftSide(rank: Int, image: String, name: String, symbol: String) -> some View {
        HStack(spacing: 1) {
            HStack(spacing: 5) {
                Button(action: { }) {
                    Image(systemName: "star")
                        .font(.system(size: 14))
                }
                
                Text("\(rank)")
                    .font(.fontRegularSmall)
                    .frame(maxWidth: 20, alignment: .leading)
            }
            
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
            .padding(.vertical, 20)
            .padding(.leading, 10)
            
            Spacer()
        }
        .frame(width: 185)
    }
    
    private func rightSide(currentPrice: Double, priceChange1H: Double, priceChange24H: Double, priceChange7D: Double, volume24h: Double, marketCap: Double, id: String) -> some View {
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
            .frame(maxWidth: 105, alignment: .trailing)
            
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
            
            chartView()
                .padding(.leading, 25)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 3)
        .frame(width: 940)
    }
    
    private func chartView() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 140)
            .frame(maxHeight: .infinity)
            .padding(.vertical, 3)
    }
}

#Preview {
    CoinList(viewModel: MarketViewModel())
}
