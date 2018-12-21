//
//  FlightsResultPresenter.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

protocol FlightsResultPresentationLogic: class {
    func manageLiveFlightSearchResult(newData: [Itinerary], complete: Bool)
    func manageLiveFlightSearchFailResult(_ message: String)
}

class FlightsResultPresenter {
    private weak var view: FlightsResultDisplayLogic?

    init(_ resourceView: FlightsResultDisplayLogic) {
        view = resourceView
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension FlightsResultPresenter: FlightsResultPresentationLogic {
    final func manageLiveFlightSearchResult(newData: [Itinerary], complete: Bool) {
        view?.showLiveFlightSearchResult(newData: newData, complete: complete)
    }

    final func manageLiveFlightSearchFailResult(_ message: String) {
        view?.showLiveFlightSearchFailResult(message)
    }
}
