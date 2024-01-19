//
//  CountryPickerViewModelTests.swift
//  TransferGo-Test-Task
//
//  Created by Vladyslav Moroz on 19/01/2024.
//

import XCTest
@testable import TransferGo_Test_Task

final class CountryPickerViewModelTests: XCTestCase {
    func test_filteredCountries_configuredCurrectly() {
        let expectedCountries: [Country] = [.ua, .uk, .pl]
        let sut = makeSut(with: .sender(senderCountry: .uk, reciverCountry: .dk))

        XCTAssertEqual(sut.filteredCountries, expectedCountries)
    }

    func test_isSender_configuredCurrectly_shouldBeTrue() {
        let sut = makeSut(with: .sender(senderCountry: .uk, reciverCountry: .dk))

        XCTAssertTrue(sut.isSender)
    }

    func test_isSender_configuredCurrectly_shouldBeFalse() {
        let sut = makeSut(with: .reciver(reciverCountry: .uk, senderCountry: .dk))

        XCTAssertFalse(sut.isSender)
    }

    // MARK: - Helpers
    private func makeSut(with convertorFormType: ConvertorFormType) -> CountryPickerViewModel {
        CountryPickerViewModel(convertorFormType: convertorFormType)
    }
}
