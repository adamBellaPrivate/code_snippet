//
//  ActionButton.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import UIKit

@IBDesignable class ActionButton: UIButton {
    override var frame: CGRect {
        didSet {
            self.layer.cornerRadius = frame.size.height / 2
            self.clipsToBounds = true
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
}

private extension ActionButton {
    final func commonInit() {
        backgroundColor = AppTheme.ActionButton.backgroundColor
        setTitleColor(AppTheme.ActionButton.textColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
    }
}
