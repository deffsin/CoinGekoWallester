//
//  MarketView.swift
//  Wallester
//
//  Created by Denis Sinitsa on 20.05.2024.
//

import SwiftUI

struct MarketView: View {
  @StateObject var viewModel = MarketViewModel()

  var body: some View {
      ZStack {
          ScrollView {
              CoinRowView(viewModel: viewModel)
          }
          //.padding([.leading, .trailing], 11)
      }
  }
}

#Preview {
  MarketView()
}
