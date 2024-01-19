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
    @Published var isLimitExceeded: Bool = false
    @Published var isCountryPickerShown: Bool = false
    @Published var isLoading: Bool = true
    @Published var convertorFormType: ConvertorFormType = .none
    @Published var senderCountry: Country = .pl
    @Published var reciverCountry: Country = .ua

    // MARK: - Dependencies
    private let exchangeService: GetExchangeRate

    // MARK: - Initialization
    init(exchangeService: GetExchangeRate = GetExchangeRateImpl()) {
        self.exchangeService = exchangeService
    }

    // MARK: - Computed properties
    var getMaxAmountText: String {
        "Maximum sending amount \(senderCountry.info.currency.maxAmountLabel) \(senderCountry.info.currency.rawValue)"
    }

    // MARK: - Not Private methods
    func onAppear() async {
        await updateCalculator()
    }

    func handleTextFieldAction(for amountString: String) async {
        guard let amount = Double(amountString) else { return }

        isLimitExceeded = amount > senderCountry.info.currency.maxSendingAmount

        await updateCalculator(ammount: amount)
    }

    func reverseCurrency() {
        
    }

    // MARK: - Private methods
    private func updateCalculator(ammount: Double = 300.00) async {
        let exchangeRate: ExchangeRate? = await exchangeService.getExchangeRate(for: senderCountry.info.currency.rawValue, to: reciverCountry.info.currency.rawValue, ammount: ammount)

        guard let exchangeRate else { return }

        if isLoading {
            fromAmount = "\(exchangeRate.fromAmount)"
        }

        from = exchangeRate.from
        to = exchangeRate.to
        rate = exchangeRate.rate
        toAmount = "\(exchangeRate.toAmount)"
        isLoading = false
    }
}
