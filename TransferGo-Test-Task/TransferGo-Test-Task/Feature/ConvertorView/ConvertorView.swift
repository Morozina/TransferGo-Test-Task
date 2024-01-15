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
            ConvertorFormView(formType: .reciver)
                .padding(.horizontal, Theme.Dimensions.marginMediumPlus)
            Spacer()
        }
    }
}

#Preview {
    ConvertorView()
}
