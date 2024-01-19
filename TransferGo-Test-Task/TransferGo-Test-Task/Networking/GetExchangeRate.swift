//
//  GetExchangeRate.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 16/01/2024.
//

import Foundation

protocol GetExchangeRate {
    func getExchangeRate(for senderCurrency: String, to reciverCurrency: String, amount: Double) async -> ExchangeRate?
}

final class GetExchangeRateImpl: GetExchangeRate {
    func getExchangeRate(for senderCurrency: String, to reciverCurrency: String, amount: Double) async -> ExchangeRate? {
        let baseURL: URL = URL(string: "https://my.transfergo.com/api/fx-rates?from=\(senderCurrency)&to=\(reciverCurrency)&amount=\(amount)")!

        do {
            let (data, _) = try await URLSession.shared.data(from: baseURL)
            let exchangeRate = try JSONDecoder().decode(ExchangeRate.self, from: data)

            return exchangeRate
        } catch {
            print(error)
            return nil
        }
    }
}
