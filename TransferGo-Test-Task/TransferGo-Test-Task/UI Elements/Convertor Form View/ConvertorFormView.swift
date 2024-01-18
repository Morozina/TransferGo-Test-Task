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
    @Binding var ammout: String

    // MARK: - Dependencies
    let associatedCountry: Countries
    let formType: ConvertorFormType
    let onAmmoutAction: ((String) -> Void)?
    let onFlagAction: ((Countries) -> Void)?

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
                Image(associatedCountry.countryFlag)
                    .resizable()
                    .frame(width: Theme.Constants.ConvertorView.smallFlagSize.width, height: Theme.Constants.ConvertorView.smallFlagSize.width)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .strokeBorder(Color.white.opacity(Theme.Constants.halfShadowOpacity), lineWidth: Theme.Dimensions.marginSmall)
                    )
                Text(associatedCountry.countryСurrency)
                    .font(Theme.Fonts.boldl14)
                    .foregroundColor(.black)
                Image(systemName: "chevron.down")
                    .font(Theme.Fonts.light12)
                    .foregroundColor(Color(Theme.Colors.textGray))
            }
        }
    }

    var TextFieldSection: some View {
        TextField("........", text: $ammout)
            .font(Theme.Fonts.boldl32)
            .foregroundColor(isReciver ? Color.black : Color(Theme.Colors.textBlue))
            .multilineTextAlignment(.trailing)
            .keyboardType(.numberPad)
            .disabled(isReciver)
            .onReceive(Just(ammout)) { newValue in
                if newValue.count > Theme.Constants.ConvertorForm.maxTextFieldCount && !isReciver {
                    ammout = String(newValue.prefix(Theme.Constants.ConvertorForm.maxTextFieldCount))
                }
            }
            .onChange(of: ammout) { oldValue, newValue in
                if oldValue.count < newValue.count {
                    onAmmoutAction?(ammout)
                }
            }
    }

    var isReciver: Bool {
        formType == .reciver
    }
}

#Preview {
    ConvertorFormView(ammout: .constant(""), associatedCountry: .dk, formType: .reciver, onAmmoutAction: nil, onFlagAction: nil)
}
