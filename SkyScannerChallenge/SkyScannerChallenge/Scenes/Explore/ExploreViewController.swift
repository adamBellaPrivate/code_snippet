//
//  ExploreViewController.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import UIKit
import WebKit

protocol ExploreDisplayLogic: class {
    func loadContent(by url: URL)
}

class ExploreViewController: UIViewController, CustomTabBarItemProtocol {
    var customTabBarItem: UITabBarItem {
        let item = UITabBarItem(title: .none, image: #imageLiteral(resourceName: "exploreInactive"), selectedImage: #imageLiteral(resourceName: "exploreActive"))
        item.tag = 0
        return item
    }

    var shouldUseNavigationController: Bool {
        return true
    }

    @IBOutlet private weak var exploreWebView: WKWebView!

    private lazy var interactor: ExploreBusinessLogic & ExploreDataStore = ExploreInteractor(self)
    private lazy var router: ExploreRoutingLogic = ExploreRouter(resource: self, dataStore: interactor)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenAppearance()
        interactor.searchForExploreInitialURL()
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ExploreViewController: ExploreDisplayLogic {
    final func loadContent(by url: URL) {
        exploreWebView.load(URLRequest(url: url))
    }
}

private extension ExploreViewController {
    final func setupScreenAppearance() {
        navigationItem.title = "screen.explore.title".localized
    }
}
