//
//  Country.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 16/01/2024.
//

import Foundation

enum Country: CaseIterable {
    case ua, dk, uk, pl

    var info: (fullName: String, flag: String, currency: Currency) {
        switch self {
        case .ua:
            return ("Ukraine", "UA", .uah)
        case .dk:
            return ("Germany", "DE", .eur)
        case .uk:
            return ("Great Britain", "GB", .gbp)
        case .pl:
            return ("Poland", "PL", .pln)
        }
    }

    func getAllCountries(except selected: Country) -> [Country] {
        Country.allCases.filter { $0 != selected }
    }
}
