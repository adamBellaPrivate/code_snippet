//
//  ExplorePresenter.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

protocol ExplorePresentationLogic: class {
    func showExploreInitialURL(_ url: URL)
}

class ExplorePresenter {
    private weak var view: ExploreDisplayLogic?

    init(_ resourceView: ExploreDisplayLogic) {
        view = resourceView
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ExplorePresenter: ExplorePresentationLogic {
    final func showExploreInitialURL(_ url: URL) {
        view?.loadContent(by: url)
    }
}
