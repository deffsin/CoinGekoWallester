//
//  DetailView.swift
//  CoinGekoWallester
//
//  Created by Denis Sinitsa on 28.05.2024.
//

import SwiftUI

struct DetailView: View {
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        ZStack {
            buildMainContent()
        }
    }
    
    @ViewBuilder
    func buildMainContent() -> some View {
        ScrollView {
            VStack(spacing: 20) {
                SegmentedView()
                currencyInfoHeader()
            }
            .background(GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self, value: $0.frame(in: .global).minY)
            })
            .padding(.horizontal, 10)
        }
        .overlay(alignment: .top) {
            if scrollOffset < -25 {
                customNavBar()
            }
        }
        .onPreferenceChange(ViewOffsetKey.self) { offset in
            self.scrollOffset = offset
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func currencyInfoHeader() -> some View {
        VStack(spacing: 7) {
            HStack(spacing: 4) {
                //AsyncImage(url: URL(string: image)!)
                Image(systemName: "soccerball")
                    .frame(width: 20, height: 20)
                
                VStack(alignment: .leading) {
                    Text("Bitcoin")
                        .font(.fontSemiBoldSmall)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 5)
                }
                
                Text("BTC Price")
                    .font(.fontRegularSmall)
                    .frame(minWidth: 75, alignment: .leading)
                
                Text("#2")
                    .font(.fontRegularSmall)
                    .padding(5)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(5)
                
                Spacer()
            }
            
            HStack {
                Text("DKK 26,707.64")
                    .frame(minWidth: 25, alignment: .leading)
                    .font(.fontSemiBoldLarge)
                
                HStack(spacing: 2) {
                    getTriangle(1.0)
                    priceChangeView(priceChange: 1.0)
                }
                .frame(maxWidth: 100, alignment: .leading)
                // font drugoj???
                
                Spacer()
            }
            
            //raznica s bitkom?
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
    
    func customNavBar() -> some View {
        VStack {
            HStack {
                currencyInfoInNavBar()
                
                Spacer()
            }
            .padding()
            .foregroundColor(.black)
            
            SegmentedView()
        }
        .background(.white)
        .frame(height: 40)
        .padding(.top, 5)
    }
    
    func currencyInfoInNavBar() -> some View {
        HStack(spacing: 4) {
            //AsyncImage(url: URL(string: image)!)
            HStack {
                Image(systemName: "soccerball")
                    .frame(width: 20, height: 20)
                
                Text("Bitcoin")
                    .font(.fontSemiBoldSmall)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 5)
            }
            .padding(.vertical, 5)
            
            HStack {
                Text("DKK 26,707.64")
                    .frame(minWidth: 25, alignment: .leading)
                    .font(.fontSemiBoldSmall)
                
                HStack(spacing: 2) {
                    getTriangle(1.0)
                    priceChangeView(priceChange: 1.0)
                }
                .frame(minWidth: 50, alignment: .leading)
                // font drugoj???
                
                Spacer()
            }
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    DetailView()
}
