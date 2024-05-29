//
//  SegmentedView.swift
//  CoinGekoWallester
//
//  Created by Denis Sinitsa on 28.05.2024.
//

import SwiftUI

enum Segment: String, CaseIterable {
    case overview = "Overview"
    case info = "Info"
    case markets = "Markets"
    case similarCoins = "Similar Coins"
    case historicalData = "Historical Data"
}


struct SegmentedView: View {
    @Binding var selectedSegment: Segment
    @Namespace var name

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 30) {
                ForEach(Segment.allCases, id: \.self) { segment in
                    Button {
                        selectedSegment = segment
                    } label: {
                        VStack {
                            Text(segment.rawValue)
                                .font(.fontSemiBoldSmall)
                                .fontWeight(.medium)
                                .foregroundColor(selectedSegment.rawValue == segment.rawValue ? .green : Color(uiColor: .systemGray))
                            ZStack {
                                Capsule()
                                    .fill(Color.clear)
                                    .frame(height: 4)
                                if selectedSegment.rawValue == segment.rawValue {
                                    Capsule()
                                        .fill(Color.green)
                                        .frame(height: 2)
                                        .matchedGeometryEffect(id: "Tab", in: name)
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        .scrollIndicators(.never)
    }
}
