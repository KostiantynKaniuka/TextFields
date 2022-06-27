//
//  TextFieldDelegator.swift
//  Text Fields
//
//  Created by Константин Канюка on 24.06.2022.
//

import UIKit
extension TextFieldsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.isSelected = false
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.isSelected = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == linkTF {
            guard let text = textField.text else {return}
            if let url = model.checkUrlValidation(input: text) {
                model.openLink(url)
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {return}
        if textField == inputLimitTF{
            textField.attributedText =  model.changeTextColor(text: text)
        }else if textField == onlyCharacterTF {
            if !model.isSeparatorAdded, text.count == model.separatorIndex {
                onlyCharacterTF.text!.append(model.separator)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {fatalError()}
        let textLength = text.count + string.count - range.length
        guard let textRange = Range(range, in: text) else {return false}
        let currentText = text.replacingCharacters(in: textRange, with: string)
        if noDidgitsTF == textField {
            return model.noDigits(userInput: string)
        }else if inputLimitTF == textField {
            scoreLb.text = "\(model.limitInput(lengh: textLength))/10"
            textField.attributedText =  model.changeTextColor(text: text)
        }else if onlyCharacterTF == textField {
            return model.isAllowedChar(text: text + string, replacementString: string)
        }else if  textField == linkTF {
            linkTF.autocapitalizationType = .none
            if linkTF.text!.isEmpty {
                linkTF.text!.append("https://")
            }
        } else if textField == validationRulesTF {
            isMinOfCharRuleDone = model.hasRequiredQuantityOfCharacters(charCount: textLength)
            isMinOfDigitsRuleDone = model.isContainsDigit(text: currentText)
            isMinOfLowercaseCharRuleDone = model.isContainsLowercase(text: currentText)
            isMinOfUppercaseCharRuleDone = model.isContainsUppercase(text: currentText)
        }
        return true
    }
}

