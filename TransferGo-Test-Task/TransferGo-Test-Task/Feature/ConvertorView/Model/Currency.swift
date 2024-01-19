//
//  Currency.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 18/01/2024.
//

import Foundation

enum Currency: String {
    case uah = "UAH"
    case eur = "EUR"
    case gbp = "GBP"
    case pln = "PLN"

    // MARK: - Computed properties
    var maxSendingAmount: Double {
        switch self {
        case .uah:
            return 50000
        case .eur:
            return 5000
        case .gbp:
            return 1000
        case .pln:
            return 20000
        }
    }

    var maxAmountLabel: String {
        switch self {
        case .uah:
            return "50 000"
        case .eur:
            return "5 000"
        case .gbp:
            return "1 000"
        case .pln:
            return "20 000"
        }
    }

    var fullCurrencyName: String {
        switch self {
        case .uah:
            return "Hrivna"
        case .eur:
            return "Euro"
        case .gbp:
            return "British Pound"
        case .pln:
            return "Polski Zloty"
        }
    }
}
