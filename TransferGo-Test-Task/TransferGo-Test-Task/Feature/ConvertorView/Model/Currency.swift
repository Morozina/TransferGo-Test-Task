//
//  Countries.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 16/01/2024.
//

import Foundation

enum Countries {
    case ua
    case dk
    case gb
    case pl

    var countryСurrency: String {
        switch self {
        case .ua:
            return "UAH"
        case .dk:
            return "EUR"
        case .gb:
            return "GBP"
        case .pl:
            return "PLN"
        }
    }

    var countryFlag: String {
        switch self {
        case .ua:
            return "UA"
        case .dk:
            return "DK"
        case .gb:
            return "UK"
        case .pl:
            return "PL"
        }
    }
}
