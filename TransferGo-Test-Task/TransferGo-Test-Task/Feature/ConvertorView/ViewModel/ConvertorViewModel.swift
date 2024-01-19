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
    @Published var fromAmount: String = ""
    @Published var toAmount: String = ""
    @Published var rate: Double = .zero
    @Published var isLimitExceeded: Bool = false
    @Published var isCountryPickerShown: Bool = false
    @Published var isLoading: Bool = true
    @Published var convertorFormType: ConvertorFormType = .none
    @Published var senderCountry: Country = .pl
    @Published var receiverCountry: Country = .ua

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

    func handleTextFieldAction(for amountString: String) {
        guard let amount = Double(amountString) else { return }

        isLimitExceeded = amount > senderCountry.info.currency.maxSendingAmount

        Task {
            await updateCalculator(amount: amount)
        }
    }

    func handleCountryPickerAction(for country: Country) {
        if case .sender = convertorFormType {
            senderCountry = country
        } else {
            receiverCountry = country
        }

        handleTextFieldAction(for: fromAmount)

        isCountryPickerShown = false
    }

    func reverseCurrency() {
        let temporaryCountry = senderCountry
        let temporaryAmount = fromAmount


        senderCountry = receiverCountry
        receiverCountry = temporaryCountry

        fromAmount = toAmount
        toAmount = temporaryAmount
    }

    // MARK: - Private methods
    private func updateCalculator(amount: Double = 300.00) async {
        let exchangeRate: ExchangeRate? = await exchangeService.getExchangeRate(for: senderCountry.info.currency.rawValue, to: receiverCountry.info.currency.rawValue, amount: amount)

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
