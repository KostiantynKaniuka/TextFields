//
//  Text_FieldsUITests.swift
//  Text FieldsUITests
//
//  Created by Константин Канюка on 12.07.2022.
//

import XCTest
@testable import Text_Fields

class Text_FieldsUITests: XCTestCase {
    var app: XCUIApplication!
    lazy var noDidgitsTextField = app.textFields.element(boundBy: 0)
    lazy var inputLimitTextField = app.textFields.element(boundBy: 1)
    lazy var onlyCharactersTextField = app.textFields.element(boundBy: 2)
    lazy var linkTextField = app.textFields.element(boundBy: 3)
    lazy var validationRulesTextField = app.textFields.element(boundBy: 4)
    
    override func setUpWithError() throws {
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    // MARK: -  No Digits Input
    func testNoDigitsTextField_Action() {
        //Given
        let input = "Alloha1 12b"
        let expectedOutput = "Alloha b"
        //When
        noDidgitsTextField.tap()
        noDidgitsTextField.typeText(input)
        //Then
        XCTAssertEqual((noDidgitsTextField.value as? String), expectedOutput)
    }
    
    // MARK: - Letters-Numbers
    func testInputLimitFieldCounterAction() {
        //Given
        let input = "Check input limit"
        //When
        inputLimitTextField.tap()
        inputLimitTextField.typeText(input)
        //Then
        XCTAssertTrue(app.staticTexts["-7/10"].exists)
    }
    
    // MARK: - Letters-Numbers
    func testOnlyCharactersFieldInteraction() {
        //Given
        let input = "A334sse3t-1k3ll4nj5l9"
        let expectedOutput = "Asset-13459"
        //When
        onlyCharactersTextField.tap()
        onlyCharactersTextField.typeText(input)
        //Then
        XCTAssertEqual((onlyCharactersTextField.value as? String), expectedOutput)
    }
    
    // MARK: - Web Link
    func testWebLinkTextFieldInterAction() {
        //Given
        let input = "www.apple.com"
        let expectedOutput = "https://www.apple.com"
        //When
        linkTextField.tap()
        linkTextField.typeText(input)
        //Then
        XCTAssertEqual((linkTextField.value as? String), expectedOutput)
    }
    
    // MARK: - Password walidation
    func testValidationRulesFieldInteraction() {
        let input = "1aA45678"
        validationRulesTextField.tap()
        validationRulesTextField.typeText(input)
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.staticTexts["✓ Min 1 digit"].exists)
        XCTAssertTrue(app.staticTexts["✓ Min 1 lowercase"].exists)
        XCTAssertTrue(app.staticTexts["✓ Min 1 capital required"].exists)
        XCTAssertTrue(app.staticTexts["✓ Min lengh 8 characters"].exists)
    }
}
