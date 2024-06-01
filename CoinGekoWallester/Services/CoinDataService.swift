//
//  CoinDataService.swift
//  Wallester
//
//  Created by Denis Sinitsa on 20.05.2024.
//

import Combine
import Foundation

class CoinDataService {
    static let shared = CoinDataService()
    
    private init() { }
    
    // fetch all crypto currencies
    func fetchCryptoCurrencies(currency: String, forceUpdate: Bool = false) -> AnyPublisher<[CoinModel], Error> {
        let urlWithCurrency = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=\(currency)&order=market_cap_desc&per_page=30&page=1&sparkline=true&price_change_percentage=1h,24h,7d"
        
        guard let url = URL(string: urlWithCurrency) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return NetworkingManager.download(url: url, forceUpdate: forceUpdate)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchCryptoCurrencyDetails(id: String, forceUpdate: Bool = false) -> AnyPublisher<CoinDetailModel, Error> {
        let urlWithID = "https://api.coingecko.com/api/v3/coins/\(id)?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false"

        guard let url = URL(string: urlWithID) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return NetworkingManager.download(url: url, forceUpdate: forceUpdate)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
