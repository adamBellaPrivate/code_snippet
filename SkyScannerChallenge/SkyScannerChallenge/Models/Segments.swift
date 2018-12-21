//
//  Segments.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/12/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

struct Segments: Codable {
    let identifier: Int
    let originStation: Int
    let destinationStation: Int
    let departureDateTime: Date
    let arrivalDateTime: Date
    let carrier: Int
    let operatingCarrier: Int
    let duration: Int
    let flightNumber: String
    let journeyMode: String
    let directionality: String

    private enum CodingKeys: String, CodingKey {
        case identifier = "Id"
        case originStation = "OriginStation"
        case destinationStation = "DestinationStation"
        case departureDateTime = "DepartureDateTime"
        case arrivalDateTime = "ArrivalDateTime"
        case carrier = "Carrier"
        case operatingCarrier = "OperatingCarrier"
        case duration = "Duration"
        case flightNumber = "FlightNumber"
        case journeyMode = "JourneyMode"
        case directionality = "Directionality"
    }
}
