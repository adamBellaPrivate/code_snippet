//
//  ProfileRouter.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

protocol ProfileRoutingLogic {
    func navigateToLoginView()
}

private protocol ProfileDataPassing {
    var dataStore: ProfileDataStore? { get }
}

class ProfileRouter: ProfileDataPassing {
    private weak var viewController: ProfileViewController?
    fileprivate var dataStore: ProfileDataStore?

    init(resource: ProfileViewController, dataStore: ProfileDataStore?) {
        viewController = resource
        self.dataStore = dataStore
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ProfileRouter: ProfileRoutingLogic {
    final func navigateToLoginView() {
        // MARK: - No op. in this version
    }
}
