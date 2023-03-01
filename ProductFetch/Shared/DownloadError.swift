//
//  DownloadError.swift
//  ProductFetch
//
//  Created by Aleksandra Narewska on 01/03/2023.
//

import Foundation

enum DownloadError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension DownloadError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the error from the service"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "The error is unknown"
        }
    }
}
