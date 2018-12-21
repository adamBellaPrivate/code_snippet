//
//  ErrorWorker.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/13/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

struct ErrorWorker {
    enum ApiError: Error {
        case invalidLocationHeader
        case invalidResponse
        case businessError(Int)
    }

    func process(error err: Error) -> String {
        guard let apiError = err as? ApiError else { return err.localizedDescription }

        switch apiError {
        case .invalidLocationHeader, .invalidResponse:
            return "general_error".localized
        case .businessError(let statusCode):
            return String(format: "business_error".localized, statusCode)
        }
    }
}
