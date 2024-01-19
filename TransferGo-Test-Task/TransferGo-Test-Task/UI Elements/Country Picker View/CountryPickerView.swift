//
//  CountryPickerView.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 19/01/2024.
//

import SwiftUI

struct CountryPickerView: View {
    @StateObject var viewModel: CountryPickerViewModel

    var body: some View {
        VStack(spacing: Theme.Dimensions.marginMediumPlus) {
            RectangleHandleSection
            TitleTextSection
            SearchSection
            CountriesSection
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

    var RectangleHandleSection: some View {
        RoundedRectangle(cornerRadius: Theme.Constants.defaultCornerRadius)
            .fill(Color(Theme.Colors.gray))
            .frame(width: Theme.Constants.CountryPickerView.handleSize.width, height: Theme.Constants.CountryPickerView.handleSize.height)
    }

    var TitleTextSection: some View {
        Text(viewModel.isSender ? "Sending from" : "Sending to")
            .font(Theme.Fonts.boldl24)
    }

    var SearchSection: some View {
        TextField("", text: $viewModel.searchText)
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
    }

    var CountriesSection: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                ListTitle
                Spacer()
            }
            ListOfCountries
        }
    }

    var ListOfCountries: some View {
        List {
            ForEach(viewModel.filteredCountries, id: \.self) { country in
                HStack(spacing: Theme.Dimensions.marginMediumVertical) {
                    Image(country.info.flag)
                        .resizable()
                        .frame(width: Theme.Constants.CountryPickerView.flagSize.width, height: Theme.Constants.CountryPickerView.flagSize.height)
                        .background(
                            Circle()
                                .fill(Color(Theme.Colors.gray))
                                .frame(width: Theme.Constants.CountryPickerView.flagBackgroundSize.width, height: Theme.Constants.CountryPickerView.flagBackgroundSize.height)
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
                .onTapGesture {
                    viewModel.onAction?(country)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    CountryPickerView(viewModel: CountryPickerViewModel(convertorFormType: .none))
}
