//
//  TextFieldsModel.swift
//  Text Fields
//
//  Created by Константин Канюка on 21.06.2022.
//

import UIKit
import SafariServices

final class TextFieldValidator {
    // MARK: -  No Digits Input
    func isValidNoDigitsString(userInput: String) -> Bool {
        let input = userInput.contains(where: {!$0.isNumber})
        return input
    }
    
    // MARK: - Input limited
    var input = 10
    
    func limitInput(lengh: Int) -> Int {
        input = 10 - lengh
        return input
    }
    
    func changeTextColor(text: String) -> NSMutableAttributedString {
        let rangeOfExtraText = NSRange(location: 10, length: text.utf16.count - 10)
        let string = NSAttributedString(string: text)
        let attributedString = NSMutableAttributedString(attributedString: string)
        if input < 0 {
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: rangeOfExtraText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location:0 , length: 10))
        }
        return attributedString
    }
    
    
    // MARK: - Letters-Numbers
    let separator = "-"
    let separatorIndex = 5
    var isSeparatorAdded = false
    private let maxOfCharacters = 11
    
    func isAllowedChar(text: String, replacementString string: String) -> Bool {
        var regex = String()
        let format = "SELF MATCHES %@"
        if text.count <= separatorIndex {
            regex = "[a-zA-Z]{1,5}"
            isSeparatorAdded = false
        } else if text.count <= maxOfCharacters {
            regex = "[a-zA-Z]{5}-[0-9]{0,5}"
            isSeparatorAdded = true
        }
        return string.isEmpty || NSPredicate(format: format, regex).evaluate(with: text)
    }
    
    // MARK: - Web Link
    func checkUrlValidation(input: String) -> String? {
        var url = String()
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        guard let detector = dataDetector else { fatalError("Data detector does not exist") }
        let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
        for match in matches {
            guard let range = Range(match.range, in: input) else {continue}
            url = String(input[range])
        }
        return url
    }
    
    // MARK: - Password walidation
    private let requiredQuantity = 8
    
    func hasRequiredQuantityOfCharacters(charCount: Int) -> Bool {
        return charCount >= requiredQuantity
    }
    
    func isContainigDigits(text: String) -> Bool {
        return text.contains { $0.isNumber }
    }
    
    func isContainsLowercase(text: String) -> Bool {
        return text.contains(where: { $0.isLowercase })
    }
    
    func isContainsUppercase(text: String) -> Bool {
        return text.contains(where: { $0.isUppercase })
    }
}
