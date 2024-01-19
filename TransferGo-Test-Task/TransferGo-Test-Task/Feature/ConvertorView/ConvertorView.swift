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
                ConvertorFormView(amount: $viewModel.fromAmount, formType: .sender(senderCountry: viewModel.senderCountry, reciverCountry: viewModel.reciverCountry), isLimitExceeded: viewModel.isLimitExceeded) { amount in
                    Task {
                        await viewModel.handleTextFieldAction(for: amount)
                    }
                } onFlagAction: {
                    viewModel.isCountryPickerShown = true
                    viewModel.convertorFormType = .sender(senderCountry: viewModel.senderCountry, reciverCountry: viewModel.reciverCountry)
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
                ConvertorFormView(amount: $viewModel.toAmount, formType: .reciver(reciverCountry: viewModel.reciverCountry, senderCountry: viewModel.senderCountry), isLimitExceeded: false, onAmountAction: nil) {
                    viewModel.isCountryPickerShown = true
                    viewModel.convertorFormType = .reciver(reciverCountry: viewModel.reciverCountry, senderCountry: viewModel.senderCountry)
                }
                .padding(.horizontal, Theme.Dimensions.marginMediumPlus)
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
                Spacer()
            }
        }
        .task {
            await viewModel.onAppear()
        }
        .onTapGesture {
            hideKeyboard()
        }
        .sheet(isPresented: $viewModel.isCountryPickerShown) {
            CountryPickerView(convertorFormType: viewModel.convertorFormType) { country in
                if case .sender = viewModel.convertorFormType {
                    viewModel.senderCountry = country
                } else {
                    viewModel.reciverCountry = country
                }

                Task {
                    await viewModel.handleTextFieldAction(for: viewModel.fromAmount)
                }
                
                viewModel.isCountryPickerShown = false
            }
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
}

#Preview {
    ConvertorView(viewModel: ConvertorViewModel())
}
