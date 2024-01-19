//
//  GetExchangeRateMock.swift
//  TransferGo-Test-TaskTests
//
//  Created by Vladyslav Moroz on 19/01/2024.
//

import Foundation
@testable import TransferGo_Test_Task

final class GetExchangeRateMock: GetExchangeRate {
    let from: String
    let to: String
    let rate: Double
    let fromAmmount: Double
    let toAmmount: Double

    func getExchangeRate(for senderCurrency: String, to reciverCurrency: String, amount: Double) async -> ExchangeRate? {
        ExchangeRate(from: from, to: to, rate: rate, fromAmount: fromAmmount, toAmount: toAmmount)
    }

    init(from: String, to: String, rate: Double, fromAmmount: Double, toAmmount: Double) {
        self.from = from
        self.to = to
        self.rate = rate
        self.fromAmmount = fromAmmount
        self.toAmmount = toAmmount
    }
}
