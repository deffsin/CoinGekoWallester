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
    @Published var sortedCoins: [CoinModel] = []
    
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var sortOption: SortOption = .rank

    private var cancellables = Set<AnyCancellable>()

    init() {
        subscribers()
    }
    
    func subscribers() {
        sortedCoinsSubscriber()
    }
    
    func sortedCoinsSubscriber() {
        Publishers.CombineLatest($allCoins, $sortOption)
            .map { coins, sortOption in
                let sorted = self.sortCoins(sort: sortOption, coins: coins)
                return sorted
            }
            .assign(to: \.sortedCoins, on: self)
            .store(in: &cancellables)
    }

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
            } receiveValue: { coins in
                self.allCoins = coins
            }
            .store(in: &cancellables)
    }
}
