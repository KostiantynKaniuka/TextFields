//
//  ViewController.swift
//  Text Fields
//
//  Created by Константин Канюка on 21.06.2022.
//

import UIKit
import SafariServices

class TextFieldsViewController: UIViewController {
    @IBOutlet var scoreLb: UILabel!
    @IBOutlet var noDidgitsTF: UITextField!
    @IBOutlet var inputLimitTF: UITextField!
    @IBOutlet var onlyCharacterTF: UITextField!
    @IBOutlet var linkTF: UITextField!
    @IBOutlet var validationRulesTF: UITextField!
    @IBOutlet var min8CharactersLb: UILabel!
    @IBOutlet var min1DidgitLb: UILabel!
    @IBOutlet var min1LowerCase: UILabel!
    @IBOutlet var min1CapitalLetterLb: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noDidgitsTF.delegate = self
        inputLimitTF.delegate = self
        onlyCharacterTF.delegate = self
        linkTF.delegate = self
        validationRulesTF.delegate = self
        self.inputLimitTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.onlyCharacterTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        progressView.progress = 0
    }
    
    let model = TextFieldLogicManager()
    private var stepInPercentageTerms: Float = 0.25
    private var progress: Float = 0 {
        didSet {
            let rules = [isMinOfCharRuleDone, isMinOfDigitsRuleDone, isMinOfLowercaseCharRuleDone, isMinOfUppercaseCharRuleDone]
            let completedRules = rules.filter { $0 == true } .count
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
                min8CharactersLb.textColor = UIColor.green
                min8CharactersLb.text = "✓ Min length 8 characters."
                progress += 1
            } else {
                min8CharactersLb.textColor = UIColor.black
                min8CharactersLb.text = "- Min length 8 characters."
                progress -= 1
            }
        }
    }
    var isMinOfDigitsRuleDone: Bool = false {
        didSet {
            if isMinOfDigitsRuleDone {
                min1DidgitLb.textColor = UIColor.green
                min1DidgitLb.text = "✓ Min 1 digit,"
                progress += 1
            } else {
                min1DidgitLb.textColor = UIColor.black
                min1DidgitLb.text = "- Min 1 digit,"
                progress -= 1
            }
        }
    }
    var isMinOfLowercaseCharRuleDone: Bool = false {
        didSet {
            if isMinOfLowercaseCharRuleDone {
                min1LowerCase.textColor = UIColor.green
                min1LowerCase.text = "✓ Min 1 lowercase,"
                progress += 1
            } else {
                min1LowerCase.textColor = UIColor.black
                min1LowerCase.text = "- Min 1 lowercase,"
                progress -= 1
            }
        }
    }
    var isMinOfUppercaseCharRuleDone: Bool = false {
        didSet {
            if isMinOfUppercaseCharRuleDone {
                min1CapitalLetterLb.textColor = UIColor.green
                min1CapitalLetterLb.text = "✓ Min 1 capital required."
                progress += 1
            } else {
                min1CapitalLetterLb.textColor = UIColor.black
                min1CapitalLetterLb.text = "- Min 1 capital required."
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







