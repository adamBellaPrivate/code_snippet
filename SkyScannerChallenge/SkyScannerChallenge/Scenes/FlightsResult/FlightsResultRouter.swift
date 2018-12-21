//
//  FlightsResultRouter.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import UIKit

protocol FlightsResultRoutingLogic {
    func popViewController()
    func shareSkyScannerURL()
}

protocol FlightsResultDataPassing {
    var dataStore: FlightsResultDataStore? { get }
}

class FlightsResultRouter: FlightsResultDataPassing {
    private weak var viewController: FlightsResultViewController?
    var dataStore: FlightsResultDataStore?

    init(resource: FlightsResultViewController, dataStore: FlightsResultDataStore?) {
        viewController = resource
        self.dataStore = dataStore
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension FlightsResultRouter: FlightsResultRoutingLogic {
    final func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    final func shareSkyScannerURL() {
        let targetVC = UIActivityViewController(activityItems: [Constant.ApplicationURLs.initialExploreURL], applicationActivities: .none)
        viewController?.present(targetVC, animated: true, completion: .none)
    }
}
