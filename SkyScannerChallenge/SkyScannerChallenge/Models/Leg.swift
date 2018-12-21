//
//  CompleteLeg.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/12/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

struct Leg {
     let identifier: String
     let segments: [Segment]
     let carrier: Carrier?
     let stopCount: Int
     let fullDuration: Int
     let fullDurationText: String

    static func initLeg(_ allLegs: [Legs], originalSegments: [Segments], places: [Place], carriers: [Carrier], wantedLegId: String) -> Leg? {
        guard let originalBoundLeg = allLegs.first(where: { $0.identifier == wantedLegId}) else { return .none }

        let segments = originalSegments.filter({ originalBoundLeg.segmentIds.contains($0.identifier) }).sorted(by: { $0.departureDateTime < $1.departureDateTime }).compactMap({ (segment) -> Segment in

            let destinationPlace = places.first(where: { $0.identifier == segment.destinationStation})
            let originalPlace = places.first(where: { $0.identifier == segment.originStation})

            return Segment(identifier: segment.identifier, originStation: originalPlace, destinationStation: destinationPlace, departureDateTime: Formatter.formatterTime.string(from: segment.departureDateTime), arrivalDateTime: Formatter.formatterTime.string(from: segment.arrivalDateTime), carrier: segment.carrier, duration: segment.duration)
        })

        var carrier: Carrier?
        if let firstCarrierId = originalBoundLeg.carrierIds.first {
            carrier = carriers.first(where: {$0.identifier == firstCarrierId})
        }

        let fullDuration = segments.reduce(0, { $0 + $1.duration})
        return Leg(identifier: originalBoundLeg.identifier, segments: segments, carrier: carrier, stopCount: originalBoundLeg.stops.count, fullDuration: fullDuration, fullDurationText: Formatter.formatterTimeComponents.string(from: Double(fullDuration) * 60) ?? "")
    }
}
