//
//  BaseRequest.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseRequestProtocol {
    func params() -> [String: Any]
    func ignoredKeys() -> [String]
}

extension BaseRequest: BaseRequestProtocol {
    final func params() -> [String: Any] {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(Formatter.formatterApiRequest)
            let jsonData = try encoder.encode(self)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            guard var parsedDict = json as? [String: Any] else { return [:] }
            ignoredKeys().forEach({ parsedDict.removeValue(forKey: $0) })
            return parsedDict
        } catch {
            return [:]
        }
    }
}

class BaseRequest: Encodable, ApiRequestProtocol {
    var urlPath: ApiUtils.ApiPath
    var method: HTTPMethod
    var extraHeaderParameters: [String: String]
    let apiKey = Constant.Application.apiKey

    init(urlPath: ApiUtils.ApiPath, method: HTTPMethod, headerParams: [String: String]) {
        self.urlPath = urlPath
        self.method = method
        extraHeaderParameters = headerParams
    }

    enum CodingKeys: String, CodingKey {
        case urlPath
        case method
        case extraHeaderParameters
        case apiKey = "apikey"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(urlPath.url.asURL(), forKey: .urlPath)
        try container.encode(method.rawValue, forKey: .method)
        try container.encode(extraHeaderParameters, forKey: .extraHeaderParameters)
        try container.encode(apiKey, forKey: .apiKey)
    }

    func ignoredKeys() -> [String] {
        return ["extraHeaderParameters", "urlPath", "method"]
    }
}
