//
//  SegmentedView.swift
//  CoinGekoWallester
//
//  Created by Denis Sinitsa on 28.05.2024.
//

import SwiftUI

struct SegmentedView: View {
    @State private var selected: String = "Overview"
    @Namespace var name
    let segments: [String] = ["Overview", "Info", "Markets", "Similar Coins", "Historical Data"] // enum??
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 30) {
                ForEach(segments, id: \.self) { segment in
                    Button {
                        selected = segment
                    } label: {
                        VStack {
                            Text(segment)
                                .font(.fontSemiBoldSmall)
                                .fontWeight(.medium)
                                .foregroundColor(selected == segment ? .green : Color(uiColor: .systemGray))
                            ZStack {
                                Capsule()
                                    .fill(Color.clear)
                                    .frame(height: 4)
                                if selected == segment {
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
