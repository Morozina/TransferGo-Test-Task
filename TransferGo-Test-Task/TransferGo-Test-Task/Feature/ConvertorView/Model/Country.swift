//
//  Country.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 16/01/2024.
//

import Foundation

enum Country {
    case ua, dk, uk, pl

    var info: (flag: String, currency: Currency) {
        switch self {
        case .ua:
            return ("UA", .uah)
        case .dk:
            return ("DK", .eur)
        case .uk:
            return ("UK", .gbp)
        case .pl:
            return ("PL", .pln)
        }
    }
}
