//
//  BaseResponse.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

class BaseResponse {
    let queryDate: Date?

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .serviceQuery)
        let dateString = try nestedContainer.decodeIfPresent(String.self, forKey: .dateTime) ?? ""
        queryDate = Formatter.formatterServiceDate.date(from: dateString)
    }
}

extension BaseResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case serviceQuery = "ServiceQuery"
        case dateTime = "DateTime"
    }
}
