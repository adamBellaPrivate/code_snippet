//
//  ApiWorker.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

protocol ApiRequestProtocol {
    var urlPath: ApiUtils.ApiPath { get }
    var method: HTTPMethod {get}
    var extraHeaderParameters: [String: String] { get }
}

struct ApiWorker {
    public enum Result<Value> {
        case success(Value, [AnyHashable: Any])
        case failure(Error)
    }

    public typealias ResultCallback<Value> = (Result<Value>) -> Void

    private static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(Formatter.formatterJSONDecoder)
        return jsonDecoder
    }()
    private static let successStatusCodes: Set<Int> = {
        var codes = Set(200...299)
        codes.remove(204)
        return codes
    }()
    private static let businessErrorCodes = Set([204, 304, 400, 405, 410, 429, 500])

    func requestPricingSession(_ request: FlightsRequest) -> Observable<Result<BaseResponse>> {
        return createCall(request, responseType: BaseResponse.self)
    }

    func pollFlightsResult(_ request: FlightResultsRequest) -> Observable<Result<FlightResultsResponse>> {
        return createCall(request, responseType: FlightResultsResponse.self)
    }
}

private extension ApiWorker {
    private var defaultHeaders: [String: String] {
        return [ "Accept": "application/json" ]
    }

    func createCall<U: ApiRequestProtocol & BaseRequestProtocol, T: Decodable>(_ request: U, responseType: T.Type) -> Observable<Result<T>> {
        return RxAlamofire.requestData(request.method, request.urlPath.url, parameters: request.params(), encoding: URLEncoding.httpBody, headers: defaultHeaders).map { (urlResponse, data) -> Result<T> in
            print("End WS call \(request.urlPath.url) with status code: \(urlResponse.statusCode)")
            if ApiWorker.successStatusCodes.contains(urlResponse.statusCode) {
                do {
                    let response = try ApiWorker.jsonDecoder.decode(responseType, from: data)
                    return Result.success(response, urlResponse.allHeaderFields)
                } catch {
                    return Result.failure(ErrorWorker.ApiError.invalidResponse)
                }
            } else if ApiWorker.businessErrorCodes.contains(urlResponse.statusCode) {
                 return Result.failure(ErrorWorker.ApiError.businessError(urlResponse.statusCode))
            } else {
                return Result.failure(ErrorWorker.ApiError.invalidResponse)
            }
        }.catchError({ (error) -> Observable<Result<T>> in
            return Observable.just(Result.failure(error))
        })
    }
}
