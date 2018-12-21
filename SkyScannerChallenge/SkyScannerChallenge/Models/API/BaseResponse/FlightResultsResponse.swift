//
//  FlightResultsResponse.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/12/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

class FlightResultsResponse: BaseResponse {
    let status: String
    let itineraries: [Itineraries]
    let legs: [Legs]
    let segments: [Segments]
    let agents: [Agent]
    let carriers: [Carrier]
    let places: [Place]

    enum ChildCodingKeys: String, CodingKey {
        case status = "Status"
        case itineraries = "Itineraries"
        case legs = "Legs"
        case segments = "Segments"
        case agents = "Agents"
        case carriers = "Carriers"
        case places = "Places"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ChildCodingKeys.self)

        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        itineraries = try container.decodeIfPresent([Itineraries].self, forKey: .itineraries) ?? []
        legs = try container.decodeIfPresent([Legs].self, forKey: .legs) ?? []
        segments = try container.decodeIfPresent([Segments].self, forKey: .segments) ?? []
        agents = try container.decodeIfPresent([Agent].self, forKey: .agents) ?? []
        carriers = try container.decodeIfPresent([Carrier].self, forKey: .carriers) ?? []
        places = try container.decodeIfPresent([Place].self, forKey: .places) ?? []

        try super.init(from: decoder)
    }
}
