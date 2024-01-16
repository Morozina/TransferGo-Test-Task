//
//  ConvertorViewModel.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 16/01/2024.
//

import Foundation

@MainActor
final class ConvertorViewModel: ObservableObject {
    // MARK: - Published
    @Published var from: String = ""
    @Published var to: String = ""
    @Published var rate: Double = .zero
    @Published var fromAmount: String = ""
    @Published var toAmount: String = ""
    @Published var isLoading: Bool = true

    // MARK: - Dependencies
    private let exchangeService: GetExchangeRate

    // MARK: - Initialization
    init(exchangeService: GetExchangeRate = GetExchangeRateImpl()) {
        self.exchangeService = exchangeService
    }

    // MARK: - Not Private methods
    func updateCalculator(for sender: Currency = .pln, to reciver: Currency = .uah, ammount: Double = 300.00) async {
        let exchangeRate: ExchangeRate? = await exchangeService.getExchangeRate(for: sender, to: reciver, ammount: ammount)

        guard let exchangeRate else { return }

        if isLoading {
            fromAmount = "\(exchangeRate.fromAmount)"
        }
        
        from = exchangeRate.from
        to = exchangeRate.to
        rate = exchangeRate.rate
        toAmount = "\(exchangeRate.toAmount)"
        isLoading = false

        print(from)
        print(to)
        print(rate)
        print(fromAmount)
        print(toAmount)
        print(isLoading)
    }
}
