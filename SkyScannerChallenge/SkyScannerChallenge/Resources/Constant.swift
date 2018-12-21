//
//  Constant.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

struct Constant {
    struct Application {
        static let apiKey = "NOT PUBLIC"
    }

    struct ApplicationURLs {
        static let initialExploreURL = URL(string: "https://www.skyscanner.hu")!
        static let apiBaseURL = URL(string: "http://www.api.hu")!
        static let airlineLogoURL = URL(string: "https://logos.skyscnr.com/images/airlines/favicon/EZ.png")!
    }

    enum UserDefaultsKey: String {
        case userLoggedStateKey = "UserLoggedState"
    }
}
