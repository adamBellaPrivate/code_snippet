//
//  FlightsRequest.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

class FlightsRequest: BaseRequest {
    let cabinClass: String
    let country: String
    let currency: String
    let locale: String
    let locationSchema: String
    let originPlace: String
    let destinationPlace: String
    let outboundDate: Date
    let inboundDate: Date
    let adults: String

    init(cabinClass: String = "Economy", country: String = "UK", currency: String = "GBP", locale: String = "en-GB", locationSchema: String = "sky", originPlace: String, destinationPlace: String, outboundDate: Date, inboundDate: Date, adults: Int = 1) {
        self.cabinClass = cabinClass
        self.country = country
        self.currency = currency
        self.locale = locale
        self.locationSchema = locationSchema
        self.originPlace = originPlace
        self.destinationPlace = destinationPlace
        self.outboundDate = outboundDate
        self.inboundDate = inboundDate
        self.adults = String(adults)

        super.init(urlPath: .pricing, method: .post, headerParams: ApiUtils.contentType)
    }

    enum ChildCodingKeys: String, CodingKey {
        case cabinClass = "cabinclass"
        case country
        case currency
        case locale
        case locationSchema
        case originPlace = "originplace"
        case destinationPlace = "destinationplace"
        case outboundDate = "outbounddate"
        case inboundDate = "inbounddate"
        case adults
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ChildCodingKeys.self)
        try container.encode(cabinClass, forKey: .cabinClass)
        try container.encode(country, forKey: .country)
        try container.encode(currency, forKey: .currency)
        try container.encode(locale, forKey: .locale)
        try container.encode(locationSchema, forKey: .locationSchema)
        try container.encode(originPlace, forKey: .originPlace)
        try container.encode(destinationPlace, forKey: .destinationPlace)
        try container.encode(outboundDate, forKey: .outboundDate)
        try container.encode(inboundDate, forKey: .inboundDate)
        try container.encode(adults, forKey: .adults)
        try super.encode(to: encoder)
    }
}
