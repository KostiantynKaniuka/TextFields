//
//  Text_FieldsTests.swift
//  Text FieldsTests
//
//  Created by Константин Канюка on 12.07.2022.
//

import XCTest

@testable import Text_Fields

class Text_FieldsTests: XCTestCase {
    var sut: TextFieldValidator!
    
    override func setUpWithError() throws {
        sut = TextFieldValidator()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: -  No Digits Input
    func testNoDigitsField_IgnoreDidgits() {
        XCTAssertTrue(sut.isValidNoDigitsString(userInput: "abcd"))
        XCTAssertFalse(sut.isValidNoDigitsString(userInput: "123asd"))
    }
    
    // MARK: - Letters-Numbers
    func testOnlyCharactersField_IsAllowedCharacters() {
        XCTAssertTrue(sut.isAllowedChar(text: "ABCDE-12345", replacementString: "0"))
        XCTAssertFalse(sut.isAllowedChar(text: "al420-ae228", replacementString: "0"))
        XCTAssertFalse(sut.isAllowedChar(text: "ABCde-ABCDE", replacementString: "0"))
        XCTAssertFalse(sut.isAllowedChar(text: "12345-54321", replacementString: "0"))
        XCTAssertFalse(sut.isAllowedChar(text: "12345-ABCDE", replacementString: "0"))
    }
    
    // MARK: - Web Link
    func testLinkTextField_URLValidation() {
        XCTAssertEqual(sut.checkUrlValidation(input: "apple"), "")
        XCTAssertNotNil(sut.checkUrlValidation(input: "https://www.apple.com"))
    }
    
    // MARK: - Password walidation
    func testValidationRulesTextField_IsMinOfCharacters() {
        XCTAssertTrue(sut.hasRequiredQuantityOfCharacters(charCount: "asdgasghasdfhgfdahdsfg".count))
        XCTAssertFalse(sut.hasRequiredQuantityOfCharacters(charCount: "123".count))
        XCTAssertTrue(sut.hasRequiredQuantityOfCharacters(charCount: "12345678".count))
        XCTAssertFalse(sut.hasRequiredQuantityOfCharacters(charCount: "1234567".count))
    }
    
    func testValidationRulesTextField_IsContainsDigit() {
        XCTAssertTrue(sut.isContainingDigits(text: "123abc"))
        XCTAssertFalse(sut.isContainingDigits(text: "abc"))
        XCTAssertFalse(sut.isContainingDigits(text: "abcO"))
        XCTAssertTrue(sut.isContainingDigits(text: "abc0"))
    }
    
    func testValidationRulesTextField_IsContainsLowercaseCharacters() {
        XCTAssertFalse(sut.isContainsLowercase(text: "ABCD"))
        XCTAssertTrue(sut.isContainsLowercase(text: "abcd"))
    }
    
    func testValidationRulesTextField_IsContainsUppercaseCharacters_Rule() {
        XCTAssertFalse(sut.isContainsUppercase(text: "abcd"))
        XCTAssertTrue(sut.isContainsUppercase(text: "ABCD"))
    }
}
