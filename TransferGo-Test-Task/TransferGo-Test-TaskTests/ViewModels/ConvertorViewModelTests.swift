//
//  ConvertorViewModelTests.swift
//  TransferGo-Test-TaskTests
//
//  Created by Vladyslav Moroz on 19/01/2024.
//

import XCTest
@testable import TransferGo_Test_Task

@MainActor
final class ConvertorViewModelTests: XCTestCase {
    func test_getMaxAmountText_configuredCurrectly() {
        let sut = makeSut()

        XCTAssertEqual(sut.getMaxAmountText, "Maximum sending amount 20 000 PLN")
    }

    func test_handleTextFieldAction_worksAsExpected_isLimitedShouldBeTrue() {
        let sut = makeSut()

        XCTAssertFalse(sut.isLimitExceeded)

        sut.handleTextFieldAction(for: "60000")

        XCTAssertTrue(sut.isLimitExceeded)
    }

    func test_handleTextFieldAction_worksAsExpected_isLimitedShouldBeFalse() {
        let sut = makeSut()

        XCTAssertFalse(sut.isLimitExceeded)

        sut.handleTextFieldAction(for: "6")

        XCTAssertFalse(sut.isLimitExceeded)
    }

    func test_handleCountryPickerAction_shouldHandleCountryPicker_shouldBeFalse() {
        let sut = makeSut()

        sut.isCountryPickerShown = true

        sut.handleCountryPickerAction(for: .dk)

        XCTAssertFalse(sut.isCountryPickerShown)
    }

    // MARK: - Helpers
    private func makeSut(from: String = "DK", to: String = "PL", rate: Double = 2.00, fromAmmount: Double = 300, toAmmount: Double = 600) -> ConvertorViewModel {
        let getExchangeRateMock = GetExchangeRateMock(from: from, to: to, rate: rate, fromAmmount: fromAmmount, toAmmount: toAmmount)

        return ConvertorViewModel(exchangeService: getExchangeRateMock)
    }
}
