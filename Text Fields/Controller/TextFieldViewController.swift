//
//  ViewController.swift
//  Text Fields
//
//  Created by Константин Канюка on 21.06.2022.
//

import UIKit
import SafariServices

final class TextFieldViewController: UIViewController {
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var noDidgitsTextField: UITextField!
    @IBOutlet var inputLimitTextField: UITextField!
    @IBOutlet var onlyCharacterTextField: UITextField!
    @IBOutlet var linkTextField: UITextField!
    @IBOutlet var validationRulesTextField: UITextField!
    @IBOutlet var min8CharactersLabel: UILabel!
    @IBOutlet var min1DidgitLabel: UILabel!
    @IBOutlet var min1LowerCaseLabel: UILabel!
    @IBOutlet var min1CapitalLetterLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noDidgitsTextField.delegate = self
        inputLimitTextField.delegate = self
        onlyCharacterTextField.delegate = self
        linkTextField.delegate = self
        validationRulesTextField.delegate = self
        self.inputLimitTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.onlyCharacterTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        progressView.progress = 0
    }
    
    let model = TextFieldValidator()
    let textFieldUisettings = TextFieldView()
    private let stepInPercentageTerms: Float = 0.25
    private var progress: Float = 0 {
        didSet {
            let rules = [isMinOfCharRuleDone, isMinOfDigitsRuleDone, isMinOfLowercaseCharRuleDone, isMinOfUppercaseCharRuleDone]
            let completedRules = rules.filter { $0 == true }.count
            progress = Float(completedRules) * stepInPercentageTerms
            
            UIView.animate(withDuration: 0.9) {
                self.progressView.setProgress(self.progress, animated: true)
                self.updateProgressViewTintColor()
            }
        }
    }
    
    enum labelText {
        case minLenght8Characters
        case min1Digit
        case min1LowerCase
        case min1CapitalRequired
    }
    
    var inputText: labelText = .min1CapitalRequired
    
    private func getText() -> String {
        switch inputText {
        case .minLenght8Characters:
            return "Min lengh 8 characters"
        case .min1Digit:
            return "Min 1 digit"
        case .min1LowerCase:
            return "Min 1 lowercase"
        case .min1CapitalRequired:
            return  "Min 1 capital required"
        }
    }
    
    var isMinOfCharRuleDone: Bool = false {
        didSet {
            inputText = .minLenght8Characters
            if isMinOfCharRuleDone {
                getLabel(number: 0).textColor = UIColor.green
                getLabel(number: 0).text = "✓ \(getText())"
                progress += 1
            } else {
                getLabel(number: 0).textColor = UIColor.black
                getLabel(number: 0).text = "- \(getText())"
                progress -= 1
            }
        }
    }
    var isMinOfDigitsRuleDone: Bool = false {
        didSet {
            inputText = .min1Digit
            if isMinOfDigitsRuleDone {
                getLabel(number: 1).textColor = UIColor.green
                getLabel(number: 1).text = "✓ \(getText())"
                progress += 1
            } else {
                getLabel(number: 1).textColor = UIColor.black
                getLabel(number: 1).text = "- \(getText())"
                progress -= 1
            }
        }
    }
    var isMinOfLowercaseCharRuleDone: Bool = false {
        didSet {
            inputText = .min1LowerCase
            if isMinOfLowercaseCharRuleDone {
                getLabel(number: 2).textColor = UIColor.green
                getLabel(number: 2).text = "✓ \(getText())"
                progress += 1
            } else {
                getLabel(number: 2).textColor = UIColor.black
                getLabel(number: 2).text = "- \(getText())"
                progress -= 1
            }
        }
    }
    var isMinOfUppercaseCharRuleDone: Bool = false {
        didSet {
            inputText = .min1CapitalRequired
            if isMinOfUppercaseCharRuleDone {
                getLabel(number: 3).textColor = UIColor.green
                getLabel(number: 3).text = "✓ \(getText())"
                progress += 1
            } else {
                getLabel(number: 3).textColor = UIColor.black
                getLabel(number: 3).text = "- \(getText())"
                progress -= 1
            }
        }
    }
    
    private func getLabel(number: Int) -> UILabel {
        switch number {
        case 0:
            return min8CharactersLabel
        case 1:
            return min1DidgitLabel
        case 2:
            return min1LowerCaseLabel
        case 3:
            return min1CapitalLetterLabel
        default:
            return getLabel(number: 0)
        }
    }
    
    private func updateProgressViewTintColor() {
        switch progressView.progress {
        case 0...0.25:
            progressView.progressTintColor = UIColor.red
        case 0.25...0.75:
            progressView.progressTintColor = UIColor.orange
        case 0.75...1:
            progressView.progressTintColor = UIColor.green
        default:
            break
        }
    }
}
