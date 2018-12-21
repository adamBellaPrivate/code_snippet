//
//  StringExtension.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func equalsIgnoreCase(to param: String) -> Bool {
        return self.lowercased() == param.lowercased()
    }
}
