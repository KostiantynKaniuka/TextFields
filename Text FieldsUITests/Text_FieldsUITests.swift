//
//  Text_FieldsUITests.swift
//  Text FieldsUITests
//
//  Created by Константин Канюка on 12.07.2022.
//

import XCTest
@testable import Text_Fields

class Text_FieldsUITests: XCTestCase {
    // MARK: -  No Digits Input
    func testNoDigitsTextField_Action() throws {
        let input = "Alloha1 12b"
        let expectedOutput = "Alloha b"
        let app = XCUIApplication()
        let noDidgitsTextField = app.textFields.element(boundBy: 0)
        app.launch()
        noDidgitsTextField.tap()
        noDidgitsTextField.typeText(input)
        XCTAssertEqual((noDidgitsTextField.value as? String), expectedOutput)
    }
    
    // MARK: - Letters-Numbers
    func testInputLimitFieldCounterAction() throws {
        let app = XCUIApplication()
        let inputLimitTextField = app.textFields.element(boundBy: 1)
        app.launch()
        inputLimitTextField.tap()
        inputLimitTextField.typeText("Check input limit")
        XCTAssertTrue(app.staticTexts["-7/10"].exists)
    }
    
    // MARK: - Letters-Numbers
    func testOnlyCharactersFieldInteraction() throws {
        let app = XCUIApplication()
        let onlyCharactersTextField = app.textFields.element(boundBy: 2)
        let input = "A334sse3t-1k3ll4nj5l9"
        let expectedOutput = "Asset-13459"
        app.launch()
        onlyCharactersTextField.tap()
        onlyCharactersTextField.typeText(input)
        XCTAssertEqual((onlyCharactersTextField.value as? String), expectedOutput)
    }
    
    // MARK: - Web Link
    func testWebLinkTextFieldInterAction() throws{
        let app = XCUIApplication()
        let linkTextField = app.textFields.element(boundBy: 3)
        let input = "www.apple.com"
        let expectedOutput = "https://www.apple.com"
        app.launch()
        linkTextField.tap()
        linkTextField.typeText(input)
        XCTAssertEqual((linkTextField.value as? String), expectedOutput)
    }
    
    // MARK: - Password walidation
    
    func testValidationRulesFieldInteraction() throws {
        let app = XCUIApplication()
        let validationRulesTextField = app.textFields.element(boundBy: 4)
        app.launch()
        validationRulesTextField.tap()
        // Check labels with validation rules.
        validationRulesTextField.typeText("1")
        XCTAssertTrue(app.staticTexts["✓ Min 1 digit"].exists)
        validationRulesTextField.typeText("a")
        XCTAssertTrue(app.staticTexts["✓ Min 1 lowercase"].exists)
        validationRulesTextField.typeText("A")
        XCTAssertTrue(app.staticTexts["✓ Min 1 capital required"].exists)
        validationRulesTextField.typeText("abcde")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.staticTexts["✓ Min lengh 8 characters"].exists)
    }
}

