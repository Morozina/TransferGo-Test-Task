//
//  ConvertorFormType.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 15/01/2024.
//

import Foundation

enum ConvertorFormType {
    case sender(senderCountry: Country, reciverCountry: Country)
    case reciver(reciverCountry: Country, senderCountry: Country)
    case none
}
