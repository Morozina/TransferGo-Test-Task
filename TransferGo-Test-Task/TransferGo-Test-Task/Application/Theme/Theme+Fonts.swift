//
//  Theme+Fonts.swift
//  Promova-TestTask
//
//  Created by Vladyslav Moroz on 12/01/2024.
//

import SwiftUI

extension Theme {
    enum Fonts {
        // MARK: - Bold
        static let boldl32: Font = .custom("Inter", size: 32).weight(.bold)

        static let boldl24: Font = .custom("Inter", size: 24).weight(.bold)

        static let boldl16: Font = .custom("Inter", size: 16).weight(.bold)

        static let boldl14: Font = .custom("Inter", size: 14).weight(.bold)

        static let boldl10: Font = .custom("Inter", size: 10).weight(.bold)

        // MARK: - Medium
        static let medium18: Font = .system(size: 18, weight: .medium)

        static let medium17: Font = .system(size: 17, weight: .medium)

        static let medium16: Font = .system(size: 16, weight: .medium)

        static let medium12: Font = .system(size: 12, weight: .medium)

        // MARK: - Normal
        static let normal14: Font = .custom("Inter", size: 14)

        static let normal12: Font = .custom("Inter", size: 12)

        // MARK: - Light
        static let light12: Font = .custom("Inter", size: 12).weight(.light)
    }
}
