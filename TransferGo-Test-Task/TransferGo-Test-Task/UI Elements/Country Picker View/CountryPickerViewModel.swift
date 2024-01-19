//
//  CountryPickerViewModel.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 19/01/2024.
//

import Foundation

final class CountryPickerViewModel: ObservableObject {
    // MARK: Published
    @Published var searchText = ""

    // MARK: - Dependencies
    private let convertorFormType: ConvertorFormType

    // MARK: - Inicialization
    init(convertorFormType: ConvertorFormType) {
        self.convertorFormType = convertorFormType
    }

    // MARK: - Computed Properties
    var filteredCountries: [Country] {
        switch convertorFormType {
        case .reciver(let associatedCountry, let alredySelected), .sender(let associatedCountry, let alredySelected):
            let allCountries = associatedCountry.getAllCountries(except: alredySelected)

            guard !searchText.isEmpty else {
                return allCountries
            }

            return allCountries.filter { country in
                country.info.fullName.lowercased().contains(searchText.lowercased())
            }
        default:
            return []
        }
    }

    var isSender: Bool {
        if case .sender = convertorFormType {
            return true
        } else {
            return false
        }
    }
}
