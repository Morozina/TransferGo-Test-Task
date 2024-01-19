//
//  CountryPickerView.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 19/01/2024.
//

import SwiftUI

struct CountryPickerView: View {
    @State private var searchText = ""
    let convertorFormType: ConvertorFormType
    let onAction: ((Country) -> Void)?

    var body: some View {
        VStack(spacing: Theme.Dimensions.marginMediumPlus) {
            RoundedRectangle(cornerRadius: Theme.Constants.defaultCornerRadius)
                .fill(Color(Theme.Colors.gray))
                .frame(width: Theme.Constants.SerchView.handleSize.width, height: Theme.Constants.SerchView.handleSize.height)

            Text(isSender ? "Sending from" : "Sending to")
                .font(Theme.Fonts.boldl24)

            TextField("", text: $searchText)
                .overlay(alignment: .trailing) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(Theme.Colors.lightGray))
                }
                .padding(.all, Theme.Dimensions.marginSmallHorizontal)
                .background(
                    RoundedRectangle(cornerRadius: Theme.Constants.normalCornerRadius)
                        .stroke(Color(Theme.Colors.lightGray))
                )
                .overlay(alignment: .topLeading) {
                    Text("Search")
                        .font(Theme.Fonts.normal12)
                        .foregroundColor(Color(Theme.Colors.textGray))
                        .padding(.horizontal, Theme.Dimensions.marginExtraExtraSmall)
                        .background(.white)
                        .offset(y: -Theme.Dimensions.defaultLayoutMargin)
                        .offset(x: Theme.Dimensions.defaultLayoutMargin)

                }

            VStack(spacing: .zero) {
                HStack(spacing: .zero) {
                    ListTitle
                    Spacer()
                }
                List {
                    ForEach(filteredCountries, id: \.self) { country in
                        Button {
                            onAction?(country)
                        } label: {
                            HStack(spacing: Theme.Dimensions.marginMediumVertical) {
                                Image(country.info.flag)
                                    .resizable()
                                    .frame(width: Theme.Constants.SerchView.flagSize.width, height: Theme.Constants.SerchView.flagSize.height)
                                    .background(
                                        Circle()
                                            .fill(Color(Theme.Colors.gray))
                                            .frame(width: Theme.Constants.SerchView.flagBackgroundSize.width, height: Theme.Constants.SerchView.flagBackgroundSize.height)
                                    )
                                VStack(alignment: .leading, spacing: Theme.Dimensions.marginExtraExtraSmall) {
                                    Text(country.info.fullName)
                                        .font(Theme.Fonts.boldl14)
                                    Text("\(country.info.currency.fullCurrencyName) • \(country.info.currency.rawValue)")
                                        .font(Theme.Fonts.normal14)
                                        .foregroundColor(Color(Theme.Colors.textGray))
                                }
                            }
                            .padding(.vertical, Theme.Dimensions.marginSmallHorizontal)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            Spacer()
        }
        .padding(.top, Theme.Dimensions.marginSmallHorizontal)
        .padding(.horizontal, Theme.Dimensions.marginMediumVertical)
        .onTapGesture {
            hideKeyboard()
        }
    }

    var ListTitle: some View {
        Text("All countries")
            .font(Theme.Fonts.boldl16)
            .foregroundColor(Color.black)
            .padding(.bottom, Theme.Dimensions.marginSmallHorizontal)
    }

    // MARK: - Computed Properties
    var listOfCountries: [Country] {
        switch convertorFormType {
        case .reciver(let associatedCountry, let alredySelected), .sender(let associatedCountry, let alredySelected):
            return associatedCountry.getAllCountries(except: alredySelected)
        default:
            return []
        }
    }

    var filteredCountries: [Country] {
        guard !searchText.isEmpty else {
            return listOfCountries
        }

        return listOfCountries.filter { country in
            country.info.fullName.lowercased().contains(searchText.lowercased())
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

#Preview {
    CountryPickerView(convertorFormType: .none, onAction: nil)
}
