//
//  FlightsResultHeaderView.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import UIKit

protocol FlightsResultHeaderViewDelegate: class {
    func didClickOnBackButton()
    func didClickOnShareButton()
}

class FlightsResultHeaderView: UIView {
    static let minAllowedHeaderHeight: CGFloat = 49
    static let maxAllowedHeaderHeight: CGFloat = 95

    @IBOutlet private weak var shadowLayer: UIView! {
        didSet {
            shadowLayer.layer.masksToBounds = false
            shadowLayer.layer.shadowColor = AppTheme.tabBarShadow.cgColor
            shadowLayer.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            shadowLayer.layer.shadowRadius = 2
            shadowLayer.layer.shadowOpacity = 1
        }
    }
    @IBOutlet private weak var viewExpendedLayer: UIView!
    @IBOutlet private weak var viewNavHeaderLayer: UIView!
    @IBOutlet private weak var lblRoute: UILabel!
    @IBOutlet private weak var lblDate: UILabel!
    @IBOutlet private weak var lblResultInfo: UILabel!
    @IBOutlet private weak var lblNavigationHeaderTitle: UILabel! {
        didSet {
            lblNavigationHeaderTitle.text = "screen.flights_result.title".localized
        }
    }
    @IBOutlet weak var lblLoading: UILabel! {
        didSet {
            lblLoading.text = "global.loading".localized
        }
    }

    private weak var delegate: FlightsResultHeaderViewDelegate?

    override var frame: CGRect {
        didSet {
            updateLayersVisibility()
        }
    }

    init() {
        super.init(frame: CGRect(x: 0, y: UIApplication.fixedTopSafeAreInset(), width: UIScreen.main.bounds.width, height: FlightsResultHeaderView.maxAllowedHeaderHeight))
        initViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }

    final func configureTripData(_ element: SearchFlightsQuery?, delegate: FlightsResultHeaderViewDelegate? = .none) {
        self.delegate = delegate
        updateShowedResultCount(0, allCount: 0)
        guard let wElement = element else {
            lblRoute.text = .none
            lblDate.text = .none
            return
        }
        lblRoute.text = "\(wElement.departingCity.displayName) to \(wElement.arrivalCity.displayName)"

        lblDate.text = "\(Formatter.formatterFlightResult.string(from: wElement.departingDate)) - \(Formatter.formatterFlightResult.string(from: wElement.arrivalDate))"
    }

    final func updateHeaderHeight(by newHeight: CGFloat) {
        guard newHeight != frame.height else { return }
        frame = CGRect(x: 0, y: UIApplication.fixedTopSafeAreInset(), width: UIScreen.main.bounds.width, height: newHeight)
    }

    final func updateShowedResultCount(_ fetchedCount: Int, allCount: Int) {
        lblResultInfo.text = String(format: "screen.flights_result.header.showed_item.message".localized, fetchedCount, allCount)
    }

    final func setLoadingVisibility(_ isHidden: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let wSelf = self else { return }
            wSelf.lblLoading.alpha = isHidden ? 0 : 1
        }
    }
}

private extension FlightsResultHeaderView {
    final func updateLayersVisibility() {
        let percent = (frame.height - FlightsResultHeaderView.minAllowedHeaderHeight) / (FlightsResultHeaderView.maxAllowedHeaderHeight - FlightsResultHeaderView.minAllowedHeaderHeight)
        viewExpendedLayer?.alpha = percent
        viewNavHeaderLayer?.alpha = 1 - percent
    }

    @IBAction final func actionBackButton(_ sender: Any) {
        delegate?.didClickOnBackButton()
    }

    @IBAction final func actionShareButton(_ sender: Any) {
        delegate?.didClickOnShareButton()
    }
}
