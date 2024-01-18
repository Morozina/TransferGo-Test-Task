//
//  CountryPickerView.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 19/01/2024.
//

import SwiftUI

struct CountryPickerView: View {
    let convertorFormType: ConvertorFormType
    let onAction: ((Country) -> Void)?

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CountryPickerView(convertorFormType: .none, onAction: nil)
}
