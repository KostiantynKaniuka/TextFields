//
//  Text_FieldsTests.swift
//  Text FieldsTests
//
//  Created by Константин Канюка on 21.06.2022.
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
    func testNodidgitsField_IgnoreDidgits() throws {
        //Given
        let inputWithNoDidgits = "aswe@#f"
        let inputWithDidgits = "123dddf"
        //Then
        XCTAssertTrue(sut.isValidNoDigitsString(userInput: inputWithNoDidgits))
        XCTAssertFalse(sut.isValidNoDigitsString(userInput: inputWithDidgits))
    }
    
    // MARK: - Letters-Numbers
    func testOnlyCharactersField_IsAllowedCharacters() throws {
        //Given
        let allowedInput = "ABCDE-12345"
        let notAllowedInput = "al420-ae228"
        //Then
        XCTAssertTrue(sut.isAllowedChar(text: allowedInput, replacementString: "0"))
        XCTAssertFalse(sut.isAllowedChar(text: notAllowedInput, replacementString: "0"))
    }
    
    // MARK: - Web Link
    func testLinkTextField_URLvalidation() throws {
        //Given
        let correctlink = "https://www.apple.com"
        let notCorrectLink = "apple"
        //Then
        XCTAssertEqual(sut.checkUrlValidation(input:notCorrectLink), "")
        XCTAssertNotNil(sut.checkUrlValidation(input:correctlink))
    }
    
    // MARK: - Password walidation
    func testValidationRulesTextField_IsMinOfCharacters() throws {
        //Given
        let input1 = "asdgasghasdfhgfdahdsfg"
        let input2 = "123"
        //Then
        XCTAssertTrue(sut.hasRequiredQuantityOfCharacters(charCount: input1.count))
        XCTAssertFalse(sut.hasRequiredQuantityOfCharacters(charCount: input2.count))
    }
    
    func testValidationRulesTextField_IsContainsDigit() throws {
        //Given
        let inputContainingDigit = "123abc"
        let inputWithoutDigits = "abc"
        //Then
        XCTAssertTrue(sut.isContainigDigits(text: inputContainingDigit))
        XCTAssertFalse(sut.isContainigDigits(text: inputWithoutDigits))
    }
    
    func testValidationRulesTextField_IsContainsLowercaseCharacters() throws {
        //Given
        let inputContainingLowercaseChar = "abcd"
        let inputWithoutLowercaseChar = "ABCD"
        //Then
        XCTAssertFalse(sut.isContainsLowercase(text: inputWithoutLowercaseChar))
        XCTAssertTrue(sut.isContainsLowercase(text: inputContainingLowercaseChar))
    }
    
    func testValidationRulesTextField_IsContainsUppercaseCharacters_Rule() throws {
        //Given
        let inputContainingUppercaseChar = "ABCD"
        let inputWithoutUppercaseChar = "abcd"
        //Then
        XCTAssertFalse(sut.isContainsUppercase(text: inputWithoutUppercaseChar))
        XCTAssertTrue(sut.isContainsUppercase(text: inputContainingUppercaseChar))
    }
}
