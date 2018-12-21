//
//  FlightsResultInteractor.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift

protocol FlightsResultBusinessLogic {
    func searchFlights()
}

protocol FlightsResultDataStore: class {
    var routeQuery: SearchFlightsQuery? { get set }
}

class FlightsResultInteractor: FlightsResultDataStore {
    private var presenter: FlightsResultPresentationLogic?
    private let apiWorker = ApiWorker()
    private let errorWorker = ErrorWorker()
    private var disposeBag = DisposeBag()
    private var sessionId: String?

    var routeQuery: SearchFlightsQuery?

    init(_ resourceView: FlightsResultDisplayLogic) {
        presenter = FlightsResultPresenter(resourceView)
    }

    deinit {
        disposeBag = DisposeBag()
        NSLog("Deinit: \(type(of: self))")
    }
}

extension FlightsResultInteractor: FlightsResultBusinessLogic {
    final func searchFlights() {
        guard let wRouteQuery = routeQuery else { return }
        apiWorker.requestPricingSession(FlightsRequest(originPlace: wRouteQuery.departingCity.skyCode, destinationPlace: wRouteQuery.arrivalCity.skyCode, outboundDate: wRouteQuery.departingDate, inboundDate: wRouteQuery.arrivalDate))
            .asDriver(onErrorJustReturn: ApiWorker.Result.failure(ErrorWorker.ApiError.invalidResponse))
            .drive(onNext: { [weak self] (result) in
                guard let wSelf = self else {return}
                switch result {
                case .success(let response):
                    if let location = response.1["Location"] as? String {
                        wSelf.sessionId = URL(string: location)!.lastPathComponent
                        wSelf.pollFlights()
                    } else {
                        wSelf.presenter?.manageLiveFlightSearchFailResult(wSelf.errorWorker.process(error: ErrorWorker.ApiError.invalidLocationHeader))
                    }
                case .failure(let error):
                    wSelf.presenter?.manageLiveFlightSearchFailResult(wSelf.errorWorker.process(error: error))
                    wSelf.sessionId = .none
                }
        }).disposed(by: disposeBag)
    }
}

private extension FlightsResultInteractor {
    final func pollFlights(_ pageIndex: Int = 0) {
        apiWorker.pollFlightsResult(FlightResultsRequest(sessionId: sessionId!, pageIndex: pageIndex))
            .asDriver(onErrorJustReturn: ApiWorker.Result.failure(ErrorWorker.ApiError.invalidResponse))
            .drive(onNext: { [weak self] (result) in
                guard let wSelf = self else {return}
                switch result {
                case .success(let response):
                    wSelf.processData(response.0, isPolling: pageIndex != -1)
                case .failure(let error):
                    wSelf.presenter?.manageLiveFlightSearchFailResult(wSelf.errorWorker.process(error: error))
                }
        }).disposed(by: disposeBag)
    }

    final func processData(_ response: FlightResultsResponse, isPolling: Bool = true) {

        NSLog("Process stating")
        DispatchQueue.global().async {
            var items = [Itinerary]()
            response.itineraries.forEach { (itinerary) in
                let outboundLeg = Leg.initLeg(response.legs, originalSegments: response.segments, places: response.places, carriers: response.carriers, wantedLegId: itinerary.outboundLegId)
                let inboundLeg = Leg.initLeg(response.legs, originalSegments: response.segments, places: response.places, carriers: response.carriers, wantedLegId: itinerary.inboundLegId)

                let firstPriceOption = itinerary.pricingOptions.first
                var agent: Agent?

                if let agentId = firstPriceOption?.agents.first {
                    agent = response.agents.first(where: { $0.identifier == agentId})
                }

                items.append(Itinerary(outboundLeg: outboundLeg, inboundLeg: inboundLeg, agent: agent, price: firstPriceOption?.price))
            }

            DispatchQueue.main.async { [weak self] in
                guard let wSelf = self else { return }
                let isComplete = response.status == "UpdatesComplete"
                wSelf.presenter?.manageLiveFlightSearchResult(newData: items, complete: isComplete && !isPolling)
                NSLog("Process ending")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    if !isComplete {
                        NSLog("Start polling again")
                        wSelf.pollFlights()
                    } else if isPolling {
                        NSLog("Start fetching all data")
                        wSelf.pollFlights(-1)
                    }
                }
            }
        }

    }
}
