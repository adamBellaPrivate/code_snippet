//
//  FlightsResultViewController.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol FlightsResultDisplayLogic: class {
    func showLiveFlightSearchResult(newData: [Itinerary], complete: Bool)
    func showLiveFlightSearchFailResult(_ message: String)
}

class FlightsResultViewController: UIViewController {
    private lazy var interactor: FlightsResultBusinessLogic & FlightsResultDataStore = FlightsResultInteractor(self)
    private(set) lazy var router: FlightsResultRoutingLogic & FlightsResultDataPassing = FlightsResultRouter(resource: self, dataStore: interactor)
    private let headerView = FlightsResultHeaderView()
    private var dataSource = BehaviorRelay<[Itinerary]>(value: [])
    private var disposeBag = DisposeBag()

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: FlightResultTableViewCell.reuseIdentifier, bundle: .none), forCellReuseIdentifier: FlightResultTableViewCell.reuseIdentifier)
            tableView.tableFooterView = UIView()
            tableView.contentInset = UIEdgeInsets(top: FlightsResultHeaderView.maxAllowedHeaderHeight, left: 0, bottom: 0, right: 0)
            tableView.contentOffset = CGPoint(x: 0, y: -FlightsResultHeaderView.maxAllowedHeaderHeight)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenAppearance()
        subscribeToDataSource()
        interactor.searchFlights()
    }

    deinit {
        disposeBag = DisposeBag()
        NSLog("Deinit: \(type(of: self))")
    }

}

extension FlightsResultViewController: FlightsResultDisplayLogic {
    final func showLiveFlightSearchFailResult(_ message: String) {
        headerView.setLoadingVisibility(true)
        showGeneralFailAlert(message: message)
    }

    final func showLiveFlightSearchResult(newData: [Itinerary], complete: Bool) {
        dataSource.accept(newData)
        if complete {
            headerView.setLoadingVisibility(true)
        }
    }
}

extension FlightsResultViewController: UITableViewDelegate {
    final func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FlightResultTableViewCell.cellHeight
    }
}

extension FlightsResultViewController: UIScrollViewDelegate {
    final func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}

private extension FlightsResultViewController {
    final func setupScreenAppearance() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        headerView.configureTripData(interactor.routeQuery, delegate: self)
        view.addSubview(headerView)
        updateHeaderView()
    }

    final func subscribeToDataSource() {
        dataSource.share().bind(to: tableView.rx.items(cellIdentifier: FlightResultTableViewCell.reuseIdentifier, cellType: FlightResultTableViewCell.self)) { _, model, cell in
            cell.setupCell(by: model)
        }.disposed(by: disposeBag)

        dataSource.asDriver().drive(onNext: { [weak self] (newData) in
            guard let wSelf = self else { return }
            wSelf.headerView.updateShowedResultCount(newData.count, allCount: newData.count)
        }).disposed(by: disposeBag)
    }

    final func updateHeaderView() {
        let newHeight = min(abs(min(tableView.contentOffset.y, -FlightsResultHeaderView.minAllowedHeaderHeight)), FlightsResultHeaderView.maxAllowedHeaderHeight)
        headerView.updateHeaderHeight(by: newHeight)
    }
}

extension FlightsResultViewController: FlightsResultHeaderViewDelegate {
    final func didClickOnBackButton() {
        router.popViewController()
    }

    final func didClickOnShareButton() {
        router.shareSkyScannerURL()
    }
}
