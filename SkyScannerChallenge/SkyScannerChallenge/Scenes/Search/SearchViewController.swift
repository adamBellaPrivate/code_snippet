//
//  SearchViewController.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: class {
    func showSelectedRoute(_ route: SearchFlightsQuery)
}

class SearchViewController: UIViewController, CustomTabBarItemProtocol {
    var customTabBarItem: UITabBarItem {
        let item = UITabBarItem(title: .none, image: #imageLiteral(resourceName: "searchInactive"), selectedImage: #imageLiteral(resourceName: "searchActive"))
        item.tag = 1
        return item
    }

    var shouldUseNavigationController: Bool {
        return true
    }

    private lazy var interactor: SearchBusinessLogic & SearchDataStore = SearchInteractor(self)
    private lazy var router: SearchRoutingLogic = SearchRouter(resource: self, dataStore: interactor)

    @IBOutlet private weak var lblDepartingCityDesc: UILabel! {
        didSet {
            lblDepartingCityDesc.text = "screen.search.departing_city.title".localized
        }
    }
    @IBOutlet private weak var lblArrivalCityDesc: UILabel! {
        didSet {
            lblArrivalCityDesc.text = "screen.search.arrival_city.title".localized
        }
    }
    @IBOutlet private weak var inputDepartingCity: UITextField! {
        didSet {
            inputDepartingCity.text = ""
        }
    }
    @IBOutlet private weak var inputArrivalCity: UITextField! {
        didSet {
            inputArrivalCity.text = ""
        }
    }
    @IBOutlet private weak var btnSearch: UIButton! {
        didSet {
            btnSearch.setTitle("screen.search.button.search.title".localized.uppercased(), for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenAppearance()
        interactor.startMockRoute()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }

}

extension SearchViewController: SearchDisplayLogic {
    final func showSelectedRoute(_ route: SearchFlightsQuery) {
        inputDepartingCity?.text = route.departingCity.displayName
        inputArrivalCity?.text = route.arrivalCity.displayName
    }
}

private extension SearchViewController {
    final func setupScreenAppearance() {
        navigationItem.title = "screen.search.title".localized
    }

    @IBAction final func actionStartSearch(_ sender: Any) {
        router.navigateToFlightResults()
    }
}
