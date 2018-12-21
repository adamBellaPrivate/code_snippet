//
//  UIViewControllerExtension.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/12/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import UIKit

extension UIViewController {
    func showGeneralFailAlert(_ title: String = "", message: String, closeTitle: String = "global.ok".localized) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: closeTitle, style: .cancel))
        present(alertView, animated: true, completion: .none)
    }
}
