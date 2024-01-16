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
                ConvertorFormView(ammout: $viewModel.fromAmount, currency: viewModel.from, formType: .sending) { ammout in
                    Task {
                        await viewModel.updateCalculator(ammount: Double(ammout) ?? 1)
                    }
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
                ConvertorFormView(ammout: $viewModel.toAmount, currency: viewModel.to, formType: .reciver, onAction: nil)
                    .padding(.horizontal, Theme.Dimensions.marginMediumPlus)
                Spacer()
            }
        }
        .onAppear {
            Task {
                await viewModel.updateCalculator()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }

    var ReverseButtonOverlay: some View {
        Button {

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
