//
//  TextFieldView.swift
//  Text Fields
//
//  Created by Константин Канюка on 30.06.2022.
//

import UIKit
import SafariServices

final class TextFieldView {
    
    func openLink(_ stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        let safariVC = SFSafariViewController(url: url)
        let keywindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        if var viewController = keywindow?.rootViewController {
            while let presentedViewController = viewController.presentedViewController {
                viewController = presentedViewController
            }
            viewController.present(safariVC, animated: true, completion: nil)
        }
    }
}
