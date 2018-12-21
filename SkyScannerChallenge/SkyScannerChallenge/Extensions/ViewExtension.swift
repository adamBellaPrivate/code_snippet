//
//  ViewExtension.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import UIKit

extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func viewFromNibForClass(index: Int = 0) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[index] as? UIView
    }

    func initViewFromNib() {
        guard let view = viewFromNibForClass() else { return }
        addSubview(view)
        view.frame = bounds
    }
}
