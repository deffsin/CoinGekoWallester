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
    
    private var cancellables = Set<AnyCancellable>()
    private var currencyService = CurrencyService.shared
    
    func fetchCryptoDetails(id: String, currencyCode: String) {
        CoinDataService.shared.fetchCryptoCurrencyDetails(id: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { coin in
                self.coinDetailData = coin
            }
            .store(in: &cancellables)
    }
}
