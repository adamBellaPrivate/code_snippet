//
//  DateExtension.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

extension Date {
    static func searchNextMonday() -> Date {
        let today = Date()

        let weekdaysName = today.getWeekDaysInEnglish().map { $0.lowercased() }
        let searchWeekdayIndex = weekdaysName.index(of: "monday")! + 1

        let calendar = Calendar(identifier: .gregorian)

        var nextDateComponent = DateComponents()
        nextDateComponent.weekday = searchWeekdayIndex

        let date = calendar.nextDate(after: today,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: .forward)

        return date!
    }

    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale.usa
        return calendar.weekdaySymbols
    }

    func nextDayDate() -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
}
