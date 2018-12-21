//
//  SearchPresenter.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

protocol SearchPresentationLogic: class {
    func showSelectedRoute(_ route: SearchFlightsQuery)
}

class SearchPresenter {
    private weak var view: SearchDisplayLogic?

    init(_ resourceView: SearchDisplayLogic) {
        view = resourceView
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension SearchPresenter: SearchPresentationLogic {
    final func showSelectedRoute(_ route: SearchFlightsQuery) {
        view?.showSelectedRoute(route)
    }
}
