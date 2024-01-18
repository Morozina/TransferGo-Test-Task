//
//  CountryPickerView.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 19/01/2024.
//

import SwiftUI

struct CountryPickerView: View {
    @State private var searchText = ""
    let convertorFormType: ConvertorFormType
    let onAction: ((Country) -> Void)?

    var body: some View {
        VStack(spacing: Theme.Dimensions.marginMediumPlus) {
            RoundedRectangle(cornerRadius: Theme.Constants.defaultCornerRadius)
                .fill(Color(Theme.Colors.gray))
                .frame(width: Theme.Constants.SerchView.handleSize.width, height: Theme.Constants.SerchView.handleSize.height)

            Text(convertorFormType == .sender ? "Sending from" : "Sending to")
                .font(Theme.Fonts.boldl24)

            TextField("", text: $searchText)
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

            VStack(spacing: .zero) {
                HStack(spacing: .zero) {
                    ListTitle
                    Spacer()
                }
                List {
                    ForEach(0...3, id: \.self) { _ in
                        Text("HHello world")
                    }
                }
                .listStyle(PlainListStyle())
            }
            Spacer()
        }
        .padding(.top, Theme.Dimensions.marginSmallHorizontal)
        .padding(.horizontal, Theme.Dimensions.marginMediumVertical)
    }

    var ListTitle: some View {
        Text("All countries")
            .font(Theme.Fonts.boldl16)
            .foregroundColor(Color.black)
            .padding(.bottom, Theme.Dimensions.marginSmallHorizontal)
    }
}

#Preview {
    CountryPickerView(convertorFormType: .none, onAction: nil)
}
