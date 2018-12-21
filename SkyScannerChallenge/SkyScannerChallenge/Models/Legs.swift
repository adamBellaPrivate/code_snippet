//
//  Legs.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/12/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

struct Legs: Decodable {
    let identifier: String
    let segmentIds: [Int]
    let duration: Int
    let stops: [Double]
    let carrierIds: [Int]

    private enum CodingKeys: String, CodingKey {
        case identifier = "Id"
        case segmentIds = "SegmentIds"
        case duration = "Duration"
        case stops = "Stops"
        case carrierIds = "Carriers"
    }
}
