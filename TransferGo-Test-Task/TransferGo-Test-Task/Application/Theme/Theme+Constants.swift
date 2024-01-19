//
//  Theme+Constants.swift
//  Promova-TestTask
//
//  Created by Vladyslav Moroz on 12/01/2024.
//

import Foundation

extension Theme {
    enum Constants {
        /// Default corner radius size
        static let defaultCornerRadius: CGFloat = 16

        /// Normal corner radius size
        static let normalCornerRadius: CGFloat = 8

        /// Small shadow opacity 20%
        static let smallShadowOpacity: Double = 0.2

        /// Half shadow opacity 50%
        static let halfShadowOpacity: Double = 0.5

        enum ConvertorView {
            static let smallFlagSize: CGSize = CGSize(width: 24, height: 24)
            static let yOffsetForTopRectangle: CGFloat = 25
            static let yOffsetForReverseButton: CGFloat = 35
            static let yOffsetForCurrencyText: CGFloat = 32
        }

        enum ConvertorForm {
            static let maxTextFieldCount: Int = 6
        }

        enum CountryPickerView {
            static let handleSize: CGSize = CGSize(width: 32, height: 4)
            static let flagSize: CGSize = CGSize(width: 34, height: 24)
            static let flagBackgroundSize: CGSize = CGSize(width: 48, height: 48)
            static let imageHeight: CGFloat = 234
        }
    }
}
