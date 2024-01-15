//
//  ConvertorFormView.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 15/01/2024.
//

import SwiftUI

struct ConvertorFormView: View {
    let formType: ConvertorFormType

    var body: some View {
        HStack(spacing: .zero) {
            VStack(spacing: Theme.Dimensions.marginSmallVertical) {
                FormTypeSection
                CurrencyButton
            }
            Spacer()
        }
        .padding(.horizontal, Theme.Dimensions.marginSmallHorizontal)
        .padding(.vertical, Theme.Dimensions.marginMediumVertical)
        .padding(.top, formType == .reciver ? Theme.Dimensions.marginSemiMedium : .zero)
        .background(
            RoundedRectangle(cornerRadius: Theme.Constants.defaultCornerRadius)
                .fill(formType == .reciver ? Color(Theme.Colors.gray) : Color.white)
                .shadow(color: .black.opacity(formType == .reciver ? .zero : Theme.Constants.smallShadowOpacity), radius: Theme.Dimensions.defaultLayoutMargin, x: .zero, y: .zero)
        )
    }

    var FormTypeSection: some View {
        Text(formType == .reciver ? "Reciver gets" : "Sending from")
            .font(Theme.Fonts.normal14)
            .foregroundColor(Color(Theme.Colors.textGray))
    }

    var CurrencyButton: some View {
        Button {

        } label: {
            HStack(spacing: Theme.Dimensions.marginExtraExtraSmall) {
                Image("UA")
                    .resizable()
                    .frame(width: Theme.Constants.ConvertorView.smallFlagSize.width, height: Theme.Constants.ConvertorView.smallFlagSize.width)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .strokeBorder(Color.white.opacity(Theme.Constants.halfShadowOpacity), lineWidth: Theme.Dimensions.marginSmall)
                    )
                Text("PLN")
                    .font(Theme.Fonts.boldl14)
                    .foregroundColor(.black)
                Image(systemName: "chevron.down")
                    .font(Theme.Fonts.light12)
                    .foregroundColor(Color(Theme.Colors.textGray))
            }
        }
    }
}

#Preview {
    ConvertorFormView(formType: .reciver)
}
