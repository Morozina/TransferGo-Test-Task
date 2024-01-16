//
//  ExchangeRate.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 16/01/2024.
//

import Foundation

struct ExchangeRate: Codable {
    let from: String
    let to: String
    let rate: Double
    let fromAmount: Double
    let toAmount: Double
}
