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

        /// Small shadow opacity 20%
        static let smallShadowOpacity: Double = 0.2

        /// Medium shadow opacity 30%
        static let mediumShadowOpacity: Double = 0.3

        /// Half shadow opacity 50%
        static let halfShadowOpacity: Double = 0.5

        /// Default border height: 3 px
        static let defaultBorderHeight: CGFloat = 3.0

        /// Medium icon size: 30 px
        static let mediumIconSize: CGSize = CGSize(width: 30, height: 30)

        /// Large icon size: 45 px
        static let largeIconSize: CGSize = CGSize(width: 45, height: 45)

        /// Loading animation Time Interval 0.3 sec
        static let loadingAnimationTimeInterval: TimeInterval = 0.3

        enum ConvertorView {
            static let smallFlagSize: CGSize = CGSize(width: 24, height: 24)
            static let maxCardHeight: CGFloat = 92
            static let yOffsetForTopRectangle: CGFloat = 25
            static let yOffsetForReverseButton: CGFloat = 35
            static let yOffsetForCurrencyText: CGFloat = 32
        }

        enum SerchView {
            static let maxCardHeight: CGFloat = 500
            static let imageHeight: CGFloat = 234
        }
    }
}
