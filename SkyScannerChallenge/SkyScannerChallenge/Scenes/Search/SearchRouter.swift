//
//  SearchRouter.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

protocol SearchRoutingLogic {
    func navigateToFlightResults()
}

private protocol SearchDataPassing {
    var dataStore: SearchDataStore? { get }
}

class SearchRouter: SearchDataPassing {
    private weak var viewController: SearchViewController?
    fileprivate var dataStore: SearchDataStore?

    init(resource: SearchViewController, dataStore: SearchDataStore?) {
        viewController = resource
        self.dataStore = dataStore
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension SearchRouter: SearchRoutingLogic {
    final func navigateToFlightResults() {
        let arrivalVC = FlightsResultViewController()
        var arrivalDS = arrivalVC.router.dataStore
        passDataToListOrders(source: dataStore, destination: &arrivalDS)
        navigateTo(destination: arrivalVC)
    }
}

private extension SearchRouter {
    final func passDataToListOrders(source: SearchDataStore?, destination: inout FlightsResultDataStore?) {
        destination?.routeQuery = source?.routeQuery
    }

    final func navigateTo(destination: FlightsResultViewController) {
        viewController?.show(destination, sender: .none)
    }
}
