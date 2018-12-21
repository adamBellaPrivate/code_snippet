//
//  Place.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/12/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

struct Place: Codable {
    let identifier: Int
    let parentId: Int?
    let code: String
    let type: String
    let name: String

    private enum CodingKeys: String, CodingKey {
        case identifier = "Id"
        case name = "Name"
        case type = "Type"
        case code = "Code"
        case parentId = "ParentId"
    }
}
