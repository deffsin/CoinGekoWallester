//
//  DetailChartView.swift
//  CoinGekoWallester
//
//  Created by Denis Sinitsa on 29.05.2024.
//

import SwiftUI

struct DetailChartView: View {
    @State private var selectedButton: String = "24h"

    var body: some View {
        ZStack {
            buildMainContent()
        }
    }
    
    @ViewBuilder
    func buildMainContent() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                textHeader()
                chartSegmentedView()
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(.horizontal, 15)
    }
    
    func textHeader() -> some View {
        VStack {
            Text("Bitcoin Price Chart (BTC)")
                .font(.fontSemiBoldUltraSmall)
        }
    }
    
    func chartSegmentedView() -> some View {
        ZStack {
            HStack(spacing: 5) {
                Button(action: {
                    withAnimation(.bouncy(duration: 1.0)) {
                        selectedButton = "24h"
                    }
                }) {
                    Text("24h")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(selectedButton == "24h" ? Color.white : Color.clear)
                        .foregroundColor(.black)
                        .cornerRadius(5)
                }
                
                Button(action: {
                    withAnimation(.bouncy(duration: 1.0)) {
                        selectedButton = "7d"
                    }
                }) {
                    Text("7d")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(selectedButton == "7d" ? Color.white : Color.clear)
                        .foregroundColor(.black)
                        .cornerRadius(5)
                }
                
                Button(action: {
                    withAnimation(.bouncy(duration: 1.0)) {
                        selectedButton = "1m"
                    }
                }) {
                    Text("1m")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(selectedButton == "1m" ? Color.white : Color.clear)
                        .foregroundColor(.black)
                        .cornerRadius(5)
                }
                
                Button(action: {
                    withAnimation(.bouncy(duration: 1.0)) {
                        selectedButton = "3m"
                    }
                }) {
                    Text("3m")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(selectedButton == "3m" ? Color.white : Color.clear)
                        .foregroundColor(.black)
                        .cornerRadius(5)
                }
                
                Button(action: {
                    withAnimation(.bouncy(duration: 1.0)) {
                        selectedButton = "Max"
                    }
                }) {
                    Text("Max")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(selectedButton == "Max" ? Color.white : Color.clear)
                        .foregroundColor(.black)
                        .cornerRadius(5)
                }
            }
        }
        .frame(width: 275, height: 50)
        .foregroundStyle(.black)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    DetailChartView()
}


#Preview {
    DetailChartView()
}
