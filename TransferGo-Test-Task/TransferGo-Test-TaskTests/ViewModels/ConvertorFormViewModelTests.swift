//
//  ConvertorFormViewModelTests.swift
//  TransferGo-Test-TaskTests
//
//  Created by Vladyslav Moroz on 19/01/2024.
//

import XCTest
@testable import TransferGo_Test_Task

final class ConvertorFormViewModelTests: XCTestCase {
    func test_isReciver_configuredCurrectly_shouldBeFalse() {
        let sut = makeSut(with: .sender(senderCountry: .uk, reciverCountry: .dk))

        XCTAssertFalse(sut.isReciver)
    }

    func test_isReciver_configuredCurrectly_shouldBeTrue() {
        let sut = makeSut(with: .reciver(reciverCountry: .uk, senderCountry: .dk))

        XCTAssertTrue(sut.isReciver)
    }

    func test_associatedCountry_configuredCurrectly() {
        let expectedCountry: Country = .uk
        let sut = makeSut(with: .sender(senderCountry: .uk, reciverCountry: .dk))

        XCTAssertEqual(sut.associatedCountry, expectedCountry)
    }
    
    // MARK: - Helpers
    private func makeSut(with formType: ConvertorFormType) -> ConvertorFormViewModel {
        ConvertorFormViewModel(amount: .constant("200"), formType: formType, isLimitExceeded: false)
    }
}
