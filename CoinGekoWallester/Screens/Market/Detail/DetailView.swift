//
//  DetailView.swift
//  CoinGekoWallester
//
//  Created by Denis Sinitsa on 28.05.2024.
//

import SwiftUI
import Combine

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    /// eto perenesti vo viewmodel?
    @State var id: String = "ethereum"
    @State var name: String = "Ethereum"
    @State var currencyCode: String = "usd"
    @State var currencySymbol: String = "$" // ex. $, €
    ///
    @State private var selectedSegment: Segment = .overview
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        ZStack {
            buildMainContent()
        }
        .task {
            viewModel.fetchCryptoDetails(id: id, currencyCode: currencyCode)
        }
    }
    
    @ViewBuilder
    func buildMainContent() -> some View {
        ScrollView {
            VStack(spacing: 20) {
                SegmentedView(selectedSegment: $selectedSegment)
                if let viewModel = viewModel.coinDetailData {
                    currencyInfoHeader(image: viewModel.image!.thumb, symbol: viewModel.symbol, price: viewModel.marketData.currentPrice[currencyCode] ?? 0.0, rank: viewModel.rank ?? 0, priceChangeIn24h: viewModel.marketData.priceChangePercentage24HInCurrency[currencyCode] ?? 0.0)
                }
                
                ForEach(1...20, id: \.self) { val in
                    Text("\(val)")
                }
            }
            .background(GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self, value: $0.frame(in: .global).minY)
            })
            .padding(.horizontal, 10)
        }
        .overlay(alignment: .top) {
            if scrollOffset < -25 {
                if let viewModel = viewModel.coinDetailData {
                    customNavBar(image: viewModel.image!.thumb, name: name, price: viewModel.marketData.currentPrice[currencyCode] ?? 0.0, priceChangeIn24h: viewModel.marketData.priceChangePercentage24HInCurrency[currencyCode] ?? 0.0)
                }
            }
        }
        .onPreferenceChange(ViewOffsetKey.self) { offset in
            self.scrollOffset = offset
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func currencyInfoHeader(image: String, symbol: String, price: Double, rank: Int, priceChangeIn24h: Double) -> some View {
        VStack(spacing: 7) {
            HStack(spacing: 5) {
                AsyncImage(url: URL(string: image)!)
                    .frame(width: 20, height: 20)
                
                VStack(alignment: .leading) {
                    Text(symbol.uppercased())
                        .font(.fontSemiBoldSmall)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                }
                
                HStack(spacing: 10) {
                    Text("\(symbol.uppercased()) Price")
                        .font(.fontRegularUltraSmall)
                        .frame(minWidth: 45, alignment: .leading)
                        .opacity(0.7)
                    
                    Text("\(rank)")
                        .font(.fontRegularUltraSmall)
                        .padding(5)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(5)
                }
                .padding(.leading, 3)
                
                Spacer()
            }
            
            HStack {
                Text("\(currencySymbol)\(price.customFormatted)")
                    .frame(minWidth: 25, alignment: .leading)
                    .font(.fontSemiBoldLarge)
                
                HStack(spacing: 2) {
                    getTriangle(priceChangeIn24h)
                    priceChangeView(priceChange: priceChangeIn24h)
                }
                .frame(maxWidth: 100, alignment: .leading)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
    }
    
    func customNavBar(image: String, name: String, price: Double, priceChangeIn24h: Double) -> some View {
        VStack {
            HStack {
                currencyInfoInNavBar(image: image, name: name, price: price, priceChangeIn24h: priceChangeIn24h)
                
                Spacer()
            }
            .foregroundColor(.black)
            
            SegmentedView(selectedSegment: $selectedSegment)
        }
        .background(.white)
        .frame(height: 10)
        .padding(.top, 25)
        .padding(.horizontal, 10)
    }
    
    func currencyInfoInNavBar(image: String, name: String, price: Double, priceChangeIn24h: Double) -> some View {
        HStack(spacing: 4) {
            HStack(spacing: 2) {
                AsyncImage(url: URL(string: image)!)
                    .frame(width: 20, height: 20)
                
                Text(name)
                    .font(.fontSemiBoldSmall)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
            }
            .padding(.vertical, 5)
            
            HStack {
                Text("\(currencySymbol)\(price.customFormatted)")
                    .frame(minWidth: 25, alignment: .leading)
                    .font(.fontSemiBoldSmall)
                
                HStack(spacing: 2) {
                    getTriangle(priceChangeIn24h)
                    priceChangeView(priceChange: priceChangeIn24h)
                }
                .frame(minWidth: 50, alignment: .leading)
                
                Spacer()
            }
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel())
}
