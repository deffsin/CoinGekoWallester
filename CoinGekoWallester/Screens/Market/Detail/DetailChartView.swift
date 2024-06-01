//
//  DetailChartView.swift
//  CoinGekoWallester
//
//  Created by Denis Sinitsa on 29.05.2024.
//

import SwiftUI

struct DetailChartView: View {
    @State private var selectedButton: String = "24h"
    
    var data: [Double]
    var priceHigher: Double {
        let maxPrice = data.max() ?? 0
        let range = (data.max() ?? 0) - (data.min() ?? 0)
        let step = range / 8
        
        return maxPrice + step
    }

    var priceLower: Double {
        let minPrice = data.min() ?? 0
        let range = (data.max() ?? 0) - (data.min() ?? 0)
        let step = range / 8
        
        return minPrice - step
    }
    
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
                chartView()
                    .padding(.vertical, 95)
                Spacer()
            }
        }
        .padding(.horizontal, 10)
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
    
    func chartView() -> some View {
        ZStack {
            HStack(spacing: 5) {
                if !data.isEmpty {
                    LineGraph(dataPoints: data)
                        .stroke(Color.green, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                } else {
                    Text("No historical chart data available")
                        .frame(width: 140)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 55) {
                    
                    Text("\(priceHigher.customFormatted)")
                    
                    ForEach(pricesToShow(), id: \.self) { price in
                        Text("\(price, specifier: "%.2f")")
                    }
                    
                    Text("\(priceLower.customFormatted)")
                }
                .font(.fontRegularUltraSmall)
                .opacity(0.8)
                .frame(minWidth: 50)
                .frame(height: 450)
            }
        }
        .frame(maxHeight: 350)
    }
    
    func pricesToShow() -> [Double] {
        let maxPrice = data.max() ?? 0
        let minPrice = data.min() ?? 0
        let range = maxPrice - minPrice
        let step = range / 5
        
        return stride(from: maxPrice, through: minPrice, by: -step).map { $0 }
    }
}
