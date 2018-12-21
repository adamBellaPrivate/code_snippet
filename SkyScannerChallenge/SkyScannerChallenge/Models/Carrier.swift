//
//  Carriers.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/12/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

struct Carrier: Codable {
    let identifier: Int
    let name: String

    private enum CodingKeys: String, CodingKey {
         case identifier = "Id"
         case name = "Name"
    }
}
