//
//  ConvertorFormView.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 15/01/2024.
//

import SwiftUI
import Combine

struct ConvertorFormView: View {
    @StateObject var viewModel: ConvertorFormViewModel

    var body: some View {
        HStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: Theme.Dimensions.marginSmallVertical) {
                FormTypeSection
                CurrencyButton
            }
            Spacer()
            TextFieldSection
        }
        .padding(.horizontal, Theme.Dimensions.marginSmallHorizontal)
        .padding(.bottom, Theme.Dimensions.marginSemiMedium)
        .padding(.top, viewModel.isReciver ? Theme.Dimensions.marginSemiExtraLarge : Theme.Dimensions.marginMediumVertical)
        .background(
            RoundedRectangle(cornerRadius: Theme.Constants.defaultCornerRadius)
                .fill(viewModel.isReciver ? Color(Theme.Colors.gray) : Color.white)
                .stroke(viewModel.isLimitExceeded ? Color(Theme.Colors.red) : Color(Theme.Colors.gray), lineWidth: Theme.Dimensions.marginSmall)
                .shadow(color: .black.opacity(viewModel.isReciver ? .zero : Theme.Constants.smallShadowOpacity), radius: Theme.Dimensions.defaultLayoutMargin, x: .zero, y: .zero)
        )
    }

    var FormTypeSection: some View {
        Text(viewModel.isReciver ? "Reciver gets" : "Sending from")
            .font(Theme.Fonts.normal14)
            .foregroundColor(Color(Theme.Colors.textGray))
    }

    var CurrencyButton: some View {
        Button {
            viewModel.onFlagAction?()
        } label: {
            HStack(spacing: Theme.Dimensions.marginExtraExtraSmall) {
                Image(viewModel.associatedCountry?.info.flag ?? "")
                    .resizable()
                    .frame(width: Theme.Constants.ConvertorView.smallFlagSize.width, height: Theme.Constants.ConvertorView.smallFlagSize.width)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .strokeBorder(Color.white.opacity(Theme.Constants.halfShadowOpacity), lineWidth: Theme.Dimensions.marginSmall)
                    )
                Text(viewModel.associatedCountry?.info.currency.rawValue ?? "")
                    .font(Theme.Fonts.boldl14)
                    .foregroundColor(.black)
                Image(systemName: "chevron.down")
                    .font(Theme.Fonts.light12)
                    .foregroundColor(Color(Theme.Colors.textGray))
            }
        }
    }

    var TextFieldSection: some View {
        TextField("........", text: $viewModel.amount)
            .font(Theme.Fonts.boldl32)
            .foregroundColor(viewModel.getColorForTextField)
            .multilineTextAlignment(.trailing)
            .keyboardType(.numberPad)
            .disabled(viewModel.isReciver)
            .onReceive(Just(viewModel.amount)) { newValue in
                if newValue.count > Theme.Constants.ConvertorForm.maxTextFieldCount && !viewModel.isReciver {
                    viewModel.amount = String(newValue.prefix(Theme.Constants.ConvertorForm.maxTextFieldCount))
                }
            }
            .onChange(of: viewModel.amount) {
                viewModel.onAmountAction?(viewModel.amount)
            }
    }
}

#Preview {
    ConvertorFormView(viewModel: ConvertorFormViewModel(amount: .constant(""), formType: .reciver(reciverCountry: .dk, senderCountry: .pl), isLimitExceeded: false))
}
