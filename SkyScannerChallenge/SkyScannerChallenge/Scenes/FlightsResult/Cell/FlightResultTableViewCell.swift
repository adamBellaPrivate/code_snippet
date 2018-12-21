//
//  FlightResultTableViewCell.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import UIKit
import Kingfisher

class FlightResultTableViewCell: UITableViewCell {
    static let cellHeight: CGFloat = 204

    @IBOutlet private weak var imgOutboundAirlineLogo: UIImageView! {
        didSet {
            imgOutboundAirlineLogo.layer.cornerRadius = 4
            imgOutboundAirlineLogo.clipsToBounds = true
        }
    }
    @IBOutlet private weak var lblOutboundTime: UILabel!
    @IBOutlet private weak var lblOutboundStop: UILabel!
    @IBOutlet private weak var lblOutboundAirlineDesc: UILabel!
    @IBOutlet private weak var lblOutboundDuration: UILabel!

    @IBOutlet private weak var imgInboundAirlineLogo: UIImageView! {
        didSet {
            imgInboundAirlineLogo.layer.cornerRadius = 4
            imgInboundAirlineLogo.clipsToBounds = true
        }
    }
    @IBOutlet private weak var lblInboundTime: UILabel!
    @IBOutlet private weak var lblInboundStop: UILabel!
    @IBOutlet private weak var lblInboundAirlineDesc: UILabel!
    @IBOutlet private weak var lblInboundDuration: UILabel!

    @IBOutlet private weak var imgScore: UIImageView!
    @IBOutlet private weak var lblScoreValue: UILabel!

    @IBOutlet private weak var lblPrice: UILabel!
    @IBOutlet private weak var lblAgent: UILabel!

    @IBOutlet private weak var lblLeftTag: UILabel!
    @IBOutlet private weak var lblRightTag: UILabel!

    final func setupCell(by itinerary: Itinerary) {
        fillAirlineLogo(airlineLogo: imgOutboundAirlineLogo)
        fillAirlineLogo(airlineLogo: imgInboundAirlineLogo)

        fillCell(by: itinerary.outboundLeg, lblAirlineDesc: lblOutboundAirlineDesc, lblDuration: lblOutboundDuration, lblTime: lblOutboundTime)
        fillCell(by: itinerary.inboundLeg, lblAirlineDesc: lblInboundAirlineDesc, lblDuration: lblInboundDuration, lblTime: lblInboundTime)

        fillStopCount(lblOutboundStop, stopCount: itinerary.outboundLeg?.stopCount)
        fillStopCount(lblInboundStop, stopCount: itinerary.inboundLeg?.stopCount)

        if let price = itinerary.price, let priceString = Formatter.formatterAmount.string(from: NSNumber(value: price)) {
            lblPrice.text = "£\(priceString)"
        } else {
            lblPrice.text = .none
        }

        if let agentName = itinerary.agent?.name, !agentName.isEmpty {
            lblAgent.text = "Via \(agentName)"
        } else {
            lblAgent.text = .none
        }
    }
}

private extension FlightResultTableViewCell {

    final func fillCell(by leg: Leg?, lblAirlineDesc: UILabel, lblDuration: UILabel, lblTime: UILabel) {
        let firstSegment = leg?.segments.first
        let lastSegment = leg?.segments.last

        lblAirlineDesc.text = fillAirlineDesc(leg: leg, firstSegment: firstSegment, lastSegment: lastSegment)

        if let departureDateTime = firstSegment?.departureDateTime, let arrivalDateTime = lastSegment?.arrivalDateTime {
            lblTime.text = "\(departureDateTime) - \(arrivalDateTime)"
        } else {
           lblTime.text = .none
        }

        lblDuration.text = leg?.fullDurationText
    }

    final func fillAirlineLogo(airlineLogo: UIImageView) {
        airlineLogo.kf.setImage(with: Constant.ApplicationURLs.airlineLogoURL)
    }

    final func fillStopCount(_ lblStop: UILabel, stopCount: Int?) {
        guard let count = stopCount else {
            lblStop.text = .none
            return
        }

        switch count {
        case 0:
            lblStop.text = "itinerary.no_stop.title".localized
        case 1:
            lblStop.text = "itinerary.stop.title".localized
        default:
            lblStop.text = String(format: "itinerary.more_stops.title".localized, count)
        }
    }

    final func fillAirlineDesc(leg: Leg?, firstSegment: Segment?, lastSegment: Segment?) -> String? {
        var airlineDesc = [firstSegment?.originStation?.code ?? ""]

        if let destinationCode = lastSegment?.destinationStation?.code {
            airlineDesc.append(destinationCode)
            airlineDesc = [airlineDesc.joined(separator: "-")]
        }

        if let carrierName = leg?.carrier?.name {
            airlineDesc.append(carrierName)
            airlineDesc = [airlineDesc.joined(separator: ", ")]
        }

        return airlineDesc.first
    }

}
