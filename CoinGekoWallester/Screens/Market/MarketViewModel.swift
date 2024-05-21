//
//  MarketViewModel.swift
//  Wallester
//
//  Created by Denis Sinitsa on 20.05.2024.
//

import Combine
import Foundation

class MarketViewModel: ObservableObject {
  @Published var allCoins: [CoinModel] = []
  @Published var isLoading = false
  @Published var errorMessage: String? = nil

  private var cancellables = Set<AnyCancellable>()

  func fetchCrypto(forceUpdate: Bool = false) {
    isLoading = true
    CoinDataService.shared.fetchCryptoCurrencies(forceUpdate: forceUpdate)
      .receive(on: DispatchQueue.main)
      .sink { completion in
        self.isLoading = false
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
        case .finished:
          break
        }
      } receiveValue: { coin in
        self.allCoins = coin
      }
      .store(in: &cancellables)
  }
}
