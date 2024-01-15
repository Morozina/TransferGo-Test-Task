//
//  ConvertorView.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 15/01/2024.
//

import SwiftUI

struct ConvertorView: View {
    var body: some View {
        VStack(spacing: .zero) {
            ConvertorFormView(formType: .sending)
                .padding(.horizontal, Theme.Dimensions.marginMediumPlus)
                .offset(y: Theme.Constants.ConvertorView.yOffsetForTopRectangle)
                .zIndex(1)
                .overlay(alignment: .bottomLeading) {
                    ReverseButtonOverlay
                }
                .overlay(alignment: .bottom) {
                    CurrencySection
                }
            ConvertorFormView(formType: .reciver)
                .padding(.horizontal, Theme.Dimensions.marginMediumPlus)
            Spacer()
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
        Text("1 PLN ~ 7.23384 UAH")
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
    ConvertorView()
}
