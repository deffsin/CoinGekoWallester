//
//  TabBar.swift
//  CoinGekoWallester
//
//  Created by Denis Sinitsa on 21.05.2024.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            MarketView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
        }
    }
}
