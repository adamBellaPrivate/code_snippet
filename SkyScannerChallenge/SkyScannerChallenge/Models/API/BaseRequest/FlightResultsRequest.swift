//
//  FlightResultsRequest.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/12/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

class FlightResultsRequest: BaseRequest {
    init(sessionId: String, pageIndex: Int = 0) {
        super.init(urlPath: .pricingDetails(sessionId, pageIndex), method: .get, headerParams: [:])
    }

    override func ignoredKeys() -> [String] {
        return super.ignoredKeys() + ["apikey"]
    }
}
