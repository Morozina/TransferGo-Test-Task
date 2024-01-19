//
//  ConvertorFormViewModel.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 19/01/2024.
//

import SwiftUI

final class ConvertorFormViewModel: ObservableObject {
    //MARK: - Binding
    @Binding var amount: String

    // MARK: - Action
    let onAmountAction: ((String) -> Void)?
    let onFlagAction: (() -> Void)?

    // MARK: - Dependencies
    let formType: ConvertorFormType
    let isLimitExceeded: Bool

    // MARK: - Inicialization
    internal init(amount: Binding<String>, formType: ConvertorFormType, isLimitExceeded: Bool, onAmountAction: ((String) -> Void)? = nil, onFlagAction: (() -> Void)? = nil) {
        self._amount = amount
        self.formType = formType
        self.isLimitExceeded = isLimitExceeded
        self.onAmountAction = onAmountAction
        self.onFlagAction = onFlagAction
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
