//
//  SearchInteractor.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

protocol SearchBusinessLogic {
    func startMockRoute()
}

protocol SearchDataStore: class {
    var routeQuery: SearchFlightsQuery { get }
}

class SearchInteractor: SearchDataStore {
    private var presenter: SearchPresentationLogic?
    internal var routeQuery: SearchFlightsQuery = SearchFlightsQuery(departingCity: City(displayName: "Edinburgh", skyCode: "EDI-sky"), arrivalCity: City(displayName: "London", skyCode: "LOND-sky"), departingDate: Date.searchNextMonday(), arrivalDate: Date.searchNextMonday().nextDayDate())

    init(_ resourceView: SearchDisplayLogic) {
        presenter = SearchPresenter(resourceView)
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension SearchInteractor: SearchBusinessLogic {
    final func startMockRoute() {
        presenter?.showSelectedRoute(routeQuery)
    }
}
