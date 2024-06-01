//
//  DetailViewModel.swift
//  CoinGekoWallester
//
//  Created by Denis Sinitsa on 29.05.2024.
//

import Combine
import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var coinDetailData: CoinDetailModel?
    @Published var coinHistoricalChartData: CoinHistoricalChartDataModel?
    
    private var cancellables = Set<AnyCancellable>()
    private var currencyService = CurrencyService.shared
    
    func fetchCryptoDetails(id: String, currencyCode: String) { // pomenjat na data, dobavit' foceUpdate?
        CoinDataService.shared.fetchCryptoCurrencyDetails(id: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching details: \(error)")
                    
                case .finished:
                    print("Finished fetching crypto details")
                }
            } receiveValue: { coin in
                self.coinDetailData = coin
            }
            .store(in: &cancellables)
    }
    
    func fetchCryptoHistoricalChartData(id: String, currencyCode: String, timeframe: String, forceUpdate: Bool = false) {
        CoinDataService.shared.fetchCryptoCurrencyHistoricalChartData(id: id, currency: currencyCode, timeframe: timeframe, forceUpdate: forceUpdate)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching data: \(error)")
                    
                case .finished:
                    print("Finished fetching crypto historical chart data")
                }
            }, receiveValue: { [weak self] data in
                let prices = data.prices.map { $0[1] }
                self?.coinHistoricalChartData = CoinHistoricalChartDataModel(prices: prices.map { [$0] })
            })
            .store(in: &cancellables)
    }
}
