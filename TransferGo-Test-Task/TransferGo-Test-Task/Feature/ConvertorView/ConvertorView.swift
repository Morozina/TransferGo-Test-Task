//
//  ConvertorView.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 15/01/2024.
//

import SwiftUI

struct ConvertorView: View {
    @StateObject var viewModel: ConvertorViewModel

    var body: some View {
        VStack(spacing: .zero) {
            if !viewModel.isLoading {
                MainSection
            }
        }
        .task {
            await viewModel.onAppear()
        }
        .onTapGesture {
            hideKeyboard()
        }
        .sheet(isPresented: $viewModel.isCountryPickerShown) {
            CountryPickerView(viewModel: CountryPickerViewModel(convertorFormType: viewModel.convertorFormType)) { country in
                viewModel.handleCountryPickerAction(for: country)
            }
        }
    }

    var MainSection: some View {
        VStack(spacing: .zero) {
            ConvertorTopItem
            ConvertorBottomItem
            AlertLimitSection
            Spacer()
        }
    }

    var ReverseButtonOverlay: some View {
        Button {
            viewModel.reverseCurrency()
        } label: {
            Image("reverse_ic")
        }
        .offset(y: Theme.Constants.ConvertorView.yOffsetForReverseButton)
        .padding(.leading, Theme.Dimensions.marginSuperLarge)
    }

    var CurrencySection: some View {
        Text("1 \(viewModel.from) ~ \(viewModel.rate) \(viewModel.to)")
            .font(Theme.Fonts.boldl10)
            .foregroundColor(.white)
            .padding(.horizontal, Theme.Dimensions.defaultLayoutMargin)
            .padding(.vertical, Theme.Dimensions.marginSmall)
            .background(
                RoundedRectangle(cornerRadius: Theme.Constants.defaultCornerRadius)
                    .fill(.black)
            )
            .offset(y: Theme.Constants.ConvertorView.yOffsetForCurrencyText)
    }

    var AlertLimitSection: some View {
        HStack(spacing: Theme.Dimensions.marginExtraExtraSmall) {
            if viewModel.isLimitExceeded {
                Spacer()
                Image("alert-circle")
                Text(viewModel.getMaxAmountText)
                    .font(Theme.Fonts.normal14)
                    .foregroundColor(Color(Theme.Colors.red))
                Spacer()
            }
        }
        .padding(.top, Theme.Dimensions.marginSemiMedium)
    }

    var ConvertorTopItem: some View {
        ConvertorFormView(viewModel: ConvertorFormViewModel(formType: .sender(senderCountry: viewModel.senderCountry, reciverCountry: viewModel.receiverCountry), isLimitExceeded: viewModel.isLimitExceeded), amount: $viewModel.fromAmount) { amount in
            viewModel.handleTextFieldAction(for: amount)
        } onFlagAction: {
            viewModel.isCountryPickerShown = true
            viewModel.convertorFormType = .sender(senderCountry: viewModel.senderCountry, reciverCountry: viewModel.receiverCountry)
        }
        .padding(.horizontal, Theme.Dimensions.marginMediumPlus)
        .offset(y: Theme.Constants.ConvertorView.yOffsetForTopRectangle)
        .zIndex(1)
        .overlay(alignment: .bottomLeading) {
            ReverseButtonOverlay
        }
        .overlay(alignment: .bottom) {
            CurrencySection
        }
    }

    var ConvertorBottomItem: some View {
        ConvertorFormView(viewModel: ConvertorFormViewModel(formType: .reciver(reciverCountry: viewModel.receiverCountry, senderCountry: viewModel.senderCountry), isLimitExceeded: false), amount: $viewModel.toAmount, onAmountAction: nil) {
            viewModel.isCountryPickerShown = true
            viewModel.convertorFormType = .reciver(reciverCountry: viewModel.receiverCountry, senderCountry: viewModel.senderCountry)
        }
        .padding(.horizontal, Theme.Dimensions.marginMediumPlus)
    }
}

#Preview {
    ConvertorView(viewModel: ConvertorViewModel())
}
