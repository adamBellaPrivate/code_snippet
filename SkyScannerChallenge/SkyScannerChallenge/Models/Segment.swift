//
//  Segment.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/12/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

struct Segment {
    let identifier: Int
    let originStation: Place?
    let destinationStation: Place?
    let departureDateTime: String
    let arrivalDateTime: String
    let carrier: Int
    let duration: Int
}
