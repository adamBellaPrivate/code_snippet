//
//  ApiUtils.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/12/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation
import Alamofire

struct ApiUtils {
    static var contentType: [String: String] = {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }()

    enum ApiPath {
        case pricing
        case pricingDetails(String, Int)

        var url: URLConvertible {
            switch self {
            case .pricing:
                return ApiUtils.apiURL(by: "pricing/v1.0")
            case .pricingDetails(let sessionId, let pageIndex):
                var params = ["apiKey": Constant.Application.apiKey]
                if pageIndex != -1 {
                    params["pageIndex"] = "\(pageIndex)"
                }

                return ApiUtils.apiURL(by: "pricing/uk1/v1.0/\(sessionId)", params: params)
            }
        }
    }

    static func apiURL(by path: String, params: [String: String] = [:]) -> URL {
        let fullURL = Constant.ApplicationURLs.apiBaseURL.appendingPathComponent(path)
        var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: false)
        if !params.keys.isEmpty {
            components?.queryItems = params.compactMap({ URLQueryItem(name: $0.key, value: $0.value )})
        }
        guard let fixedURL = components?.url else { return fullURL}
        return fixedURL
    }
}
