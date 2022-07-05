//
//  TextFieldDelegator.swift
//  Text Fields
//
//  Created by Константин Канюка on 24.06.2022.
//

import UIKit

extension TextFieldViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.isSelected = false
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.isSelected = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == linkTextField {
            guard let text = textField.text else { return }
            guard let url = model.checkUrlValidation(input: text) else { return }
            textFieldUisettings.openLink(url)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if textField == inputLimitTextField {
            textField.attributedText =  model.changeTextColor(text: text)
        } else if textField == onlyCharacterTextField {
            if !model.isSeparatorAdded, text.count == model.separatorIndex {
                onlyCharacterTextField.text?.append(model.separator)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { fatalError("No text field Initialization") }
        let textLength = text.count + string.count - range.length
        guard let textRange = Range(range, in: text) else { return false }
        let currentText = text.replacingCharacters(in: textRange, with: string)
        if noDidgitsTextField == textField {
            return model.isValidNoDigitsString(userInput: string)
        } else if inputLimitTextField == textField {
            scoreLabel.text = "\(model.limitInput(lengh: textLength))/10"
            textField.attributedText =  model.changeTextColor(text: text)
        } else if onlyCharacterTextField == textField {
            return model.isAllowedChar(text: text + string, replacementString: string)
        } else if  textField == linkTextField {
            linkTextField.autocapitalizationType = .none
            if linkTextField.text!.isEmpty {
                linkTextField.text!.append("https://")
            }
        } else if textField == validationRulesTextField {
            isMinOfCharRuleDone = model.hasRequiredQuantityOfCharacters(charCount: textLength)
            isMinOfDigitsRuleDone = model.isContainigDigits(text: currentText)
            isMinOfLowercaseCharRuleDone = model.isContainsLowercase(text: currentText)
            isMinOfUppercaseCharRuleDone = model.isContainsUppercase(text: currentText)
        }
        return true
    }
}
