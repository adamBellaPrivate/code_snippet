//
//  ExploreRouter.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

protocol ExploreRoutingLogic {

}

private protocol ExploreDataPassing {
    var dataStore: ExploreDataStore? { get }
}

class ExploreRouter: ExploreDataPassing {
    private weak var viewController: ExploreViewController?
    fileprivate var dataStore: ExploreDataStore?

    init(resource: ExploreViewController, dataStore: ExploreDataStore?) {
        viewController = resource
        self.dataStore = dataStore
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ExploreRouter: ExploreRoutingLogic {

}
