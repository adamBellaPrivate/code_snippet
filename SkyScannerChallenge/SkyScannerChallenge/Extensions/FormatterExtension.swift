//
//  FormatterExtension.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

extension Formatter {
    static let formatterFlightResult: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d., E"
        return dateFormatter
    }()

    static let formatterApiRequest: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

    static let formatterJSONDecoder: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }()

    static let formatterServiceDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter
    }()

    static let formatterTime: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()

    static let formatterTimeComponents: DateComponentsFormatter = {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.hour, .minute]
        dateComponentsFormatter.unitsStyle = .abbreviated
        return dateComponentsFormatter
    }()

    static let formatterAmount: NumberFormatter = {
        let numberFormetter = NumberFormatter()
        numberFormetter.numberStyle = .decimal
        numberFormetter.maximumFractionDigits = 2
        numberFormetter.minimumFractionDigits = 0
        return numberFormetter
    }()
}
