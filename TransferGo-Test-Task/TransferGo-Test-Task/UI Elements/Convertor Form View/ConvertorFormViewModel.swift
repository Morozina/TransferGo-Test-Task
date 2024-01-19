//
//  ConvertorFormViewModel.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 19/01/2024.
//

import SwiftUI

final class ConvertorFormViewModel: ObservableObject {
    // MARK: - Dependencies
    let formType: ConvertorFormType
    let isLimitExceeded: Bool

    // MARK: - Inicialization
    internal init(formType: ConvertorFormType, isLimitExceeded: Bool) {
        self.formType = formType
        self.isLimitExceeded = isLimitExceeded
    }

    // MARK: - Computed properties
    var isReciver: Bool {
        if case .reciver = formType {
            return true
        } else {
            return false
        }
    }

    var getColorForTextField: Color {
        isReciver ? Color.black : isLimitExceeded ? Color(Theme.Colors.red) : Color(Theme.Colors.textBlue)
    }

    var associatedCountry: Country? {
        switch formType {
        case .reciver(let associatedCountry, _), .sender(let associatedCountry, _):
            return associatedCountry
        default:
            return nil
        }
    }
}
