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
    var isMinOfCharRuleDone: Bool = false {
        didSet {
            if isMinOfCharRuleDone {
                min8CharactersLabel.textColor = UIColor.green
                min8CharactersLabel.text = "✓ Min length 8 characters"
                progress += 1
            } else {
                min8CharactersLabel.textColor = UIColor.black
                min8CharactersLabel.text = "- Min length 8 characters"
                progress -= 1
            }
        }
    }
    var isMinOfDigitsRuleDone: Bool = false {
        didSet {
            if isMinOfDigitsRuleDone {
                min1DidgitLabel.textColor = UIColor.green
                min1DidgitLabel.text = "✓ Min 1 digit"
                progress += 1
            } else {
                min1DidgitLabel.textColor = UIColor.black
                min1DidgitLabel.text = "- Min 1 digit"
                progress -= 1
            }
        }
    }
    var isMinOfLowercaseCharRuleDone: Bool = false {
        didSet {
            if isMinOfLowercaseCharRuleDone {
                min1LowerCaseLabel.textColor = UIColor.green
                min1LowerCaseLabel.text = "✓ Min 1 lowercase"
                progress += 1
            } else {
                min1LowerCaseLabel.textColor = UIColor.black
                min1LowerCaseLabel.text = "- Min 1 lowercase"
                progress -= 1
            }
        }
    }
    var isMinOfUppercaseCharRuleDone: Bool = false {
        didSet {
            if isMinOfUppercaseCharRuleDone {
                min1CapitalLetterLabel.textColor = UIColor.green
                min1CapitalLetterLabel.text = "✓ Min 1 capital required"
                progress += 1
            } else {
                min1CapitalLetterLabel.textColor = UIColor.black
                min1CapitalLetterLabel.text = "- Min 1 capital required"
                progress -= 1
            }
        }
    }
    
    func updateProgressViewTintColor() {
        if progressView.progress <= 0.25 {
            progressView.progressTintColor = UIColor.red
        } else if progressView.progress <= 0.75 {
            progressView.progressTintColor = UIColor.orange
        } else {
            progressView.progressTintColor = UIColor.green
        }
    }
}
