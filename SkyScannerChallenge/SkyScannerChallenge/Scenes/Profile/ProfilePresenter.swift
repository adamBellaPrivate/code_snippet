//
//  ProfilePresenter.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

protocol ProfilePresentationLogic: class {
    func manageNotLoggedInUser()
    func manageLoggedInUser()
}

class ProfilePresenter {
    private weak var view: ProfileDisplayLogic?

    init(_ resourceView: ProfileDisplayLogic) {
        view = resourceView
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ProfilePresenter: ProfilePresentationLogic {
    final func manageNotLoggedInUser() {
        view?.showNotLoggedInView()
    }

    final func manageLoggedInUser() {
        view?.showLoggedInView()
    }
}
