//
//  PricingOption.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/12/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

struct PricingOption: Codable {
    let agents: [Double]
    let quoteAgeInMinutes: Int
    let price: Double
    let deeplinkUrlString: String

    private enum CodingKeys: String, CodingKey {
        case agents = "Agents"
        case quoteAgeInMinutes = "QuoteAgeInMinutes"
        case price = "Price"
        case deeplinkUrlString = "DeeplinkUrl"
    }
}
