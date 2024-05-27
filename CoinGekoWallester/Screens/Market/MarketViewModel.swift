//
//  MarketViewModel.swift
//  Wallester
//
//  Created by Denis Sinitsa on 20.05.2024.
//

import Combine
import Foundation
import SwiftUI

class MarketViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var sortedCoins: [CoinModel] = []
    @Published var sparklineIn7D: [Double] = []
    
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var sortOption: SortOption = .rank
    @Published var currencySymbol: String? = ""

    private var cancellables = Set<AnyCancellable>()
    
    private var locationManager = LocationManager()
    private var currencyService = CurrencyService.shared
    
    init() {
        setupLocationManager()
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

    func fetchCrypto(currency: String, forceUpdate: Bool = false) {
        isLoading = true
        CoinDataService.shared.fetchCryptoCurrencies(currency: currency, forceUpdate: forceUpdate)
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
                self.sparklineIn7D = coins.flatMap { $0.sparklineIn7D?.price ?? [] }
            }
            .store(in: &cancellables)
    }

    
    func setupLocationManager() {
        locationManager.currency = { [weak self] currencyCode in
            self?.fetchCrypto(currency: currencyCode, forceUpdate: true)
            if let symbol = self?.currencyService.getCurrencySymbol(for: currencyCode) {
                self?.currencySymbol = symbol
            } else {
                self?.currencySymbol = "$"
            }
        }
        locationManager.requestLocationAccess()
        locationManager.startUpdatingLocation()
        
        // esli net dannqh o location, vse ravno vqzavaem
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            if self?.currencySymbol == "" {
                self?.fetchCrypto(currency: "usd", forceUpdate: true)
                self?.currencySymbol = "$"
            }
        }
    }
}
