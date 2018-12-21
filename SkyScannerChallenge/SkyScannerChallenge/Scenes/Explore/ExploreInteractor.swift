//
//  ExploreInteractor.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

protocol ExploreBusinessLogic {
    func searchForExploreInitialURL()
}

protocol ExploreDataStore: class {

}

class ExploreInteractor: ExploreDataStore {
    private var presenter: ExplorePresentationLogic?

    init(_ resourceView: ExploreDisplayLogic) {
        presenter = ExplorePresenter(resourceView)
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ExploreInteractor: ExploreBusinessLogic {
    final func searchForExploreInitialURL() {
        presenter?.showExploreInitialURL(Constant.ApplicationURLs.initialExploreURL)
    }
}
