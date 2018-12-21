//
//  Itineraries.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/12/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

struct Itineraries: Codable {
    let outboundLegId: String
    let inboundLegId: String
    let pricingOptions: [PricingOption]

    private enum CodingKeys: String, CodingKey {
        case outboundLegId = "OutboundLegId"
        case inboundLegId = "InboundLegId"
        case pricingOptions = "PricingOptions"
    }
}
