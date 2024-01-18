//
//  ConvertorFormView.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 15/01/2024.
//

import SwiftUI
import Combine

struct ConvertorFormView: View {
    //MARK: - Binding
    @Binding var amount: String

    // MARK: - Dependencies
    let associatedCountry: Country
    let formType: ConvertorFormType
    let isLimitExceeded: Bool
    let onAmountAction: ((String) -> Void)?
    let onFlagAction: ((Country) -> Void)?

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
        .padding(.top, isReciver ? Theme.Dimensions.marginSemiExtraLarge : Theme.Dimensions.marginMediumVertical)
        .background(
            RoundedRectangle(cornerRadius: Theme.Constants.defaultCornerRadius)
                .fill(isReciver ? Color(Theme.Colors.gray) : Color.white)
                .stroke(isLimitExceeded ? Color(Theme.Colors.red) : Color(Theme.Colors.gray), lineWidth: Theme.Dimensions.marginSmall)
                .shadow(color: .black.opacity(isReciver ? .zero : Theme.Constants.smallShadowOpacity), radius: Theme.Dimensions.defaultLayoutMargin, x: .zero, y: .zero)
        )
    }

    var FormTypeSection: some View {
        Text(isReciver ? "Reciver gets" : "Sending from")
            .font(Theme.Fonts.normal14)
            .foregroundColor(Color(Theme.Colors.textGray))
    }

    var CurrencyButton: some View {
        Button {

        } label: {
            HStack(spacing: Theme.Dimensions.marginExtraExtraSmall) {
                Image(associatedCountry.info.flag)
                    .resizable()
                    .frame(width: Theme.Constants.ConvertorView.smallFlagSize.width, height: Theme.Constants.ConvertorView.smallFlagSize.width)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .strokeBorder(Color.white.opacity(Theme.Constants.halfShadowOpacity), lineWidth: Theme.Dimensions.marginSmall)
                    )
                Text(associatedCountry.info.currency.rawValue)
                    .font(Theme.Fonts.boldl14)
                    .foregroundColor(.black)
                Image(systemName: "chevron.down")
                    .font(Theme.Fonts.light12)
                    .foregroundColor(Color(Theme.Colors.textGray))
            }
        }
    }

    var TextFieldSection: some View {
        TextField("........", text: $amount)
            .font(Theme.Fonts.boldl32)
            .foregroundColor(getColorForTextField)
            .multilineTextAlignment(.trailing)
            .keyboardType(.numberPad)
            .disabled(isReciver)
            .onReceive(Just(amount)) { newValue in
                if newValue.count > Theme.Constants.ConvertorForm.maxTextFieldCount && !isReciver {
                    amount = String(newValue.prefix(Theme.Constants.ConvertorForm.maxTextFieldCount))
                }
            }
            .onChange(of: amount) {
                onAmountAction?(amount)
            }
    }

    var isReciver: Bool {
        formType == .reciver
    }

    var getColorForTextField: Color {
        isReciver ? Color.black : isLimitExceeded ? Color(Theme.Colors.red) : Color(Theme.Colors.textBlue)
    }
}

#Preview {
    ConvertorFormView(amount: .constant(""), associatedCountry: .dk, formType: .reciver, isLimitExceeded: false, onAmountAction: nil, onFlagAction: nil)
}
