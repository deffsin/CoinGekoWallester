//
//  CoinList.swift
//  CoinGekoWallester
//
//  Created by Denis Sinitsa on 22.05.2024.
//

import SwiftUI

struct CoinList: View {
    @ObservedObject var viewModel: MarketViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            HStack {
                Button(action: { }) {
                    Image(systemName: "star")
                }
                
                Text("1")
                
                HStack {
                    Image(systemName: "car")
                    
                    VStack{
                        Text("Bitcoin")
                        
                        Text("BTC")
                    }
                }
                .padding(10)
                
                Spacer()
            }
            .frame(width: 160)
            .padding(.horizontal, 10)
            .background(.gray.opacity(0.4))
            
            ScrollView(.horizontal) {
                HStack {
                    Button(action: { }) {
                        Image(systemName: "star")
                    }
                    
                    Text("1")
                    
                    HStack {
                        Image(systemName: "car")
                        
                        VStack{
                            Text("Bitcoin")
                            
                            Text("BTC")
                        }
                    }
                    .padding(10)
                    
                    Spacer()
                }
                .frame(width: 250)
                .padding(.horizontal, 10)
                .background(.green.opacity(0.4))
            }
            .scrollIndicators(.never)
        }
        .padding(.horizontal, 5)
    }
}

#Preview {
    CoinList(viewModel: MarketViewModel())
}
