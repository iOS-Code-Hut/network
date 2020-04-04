//
//  NetworkError.swift
//  network
//
//  Created by Guilherme Ramos on 03/04/20.
//  Copyright © 2020 Guilherme Ramos. All rights reserved.
//

import Foundation

enum NetworkError: Error, Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidRequest, .invalidRequest):
            return true
        case let (.decoding(lhsError), .decoding(rhsError)),
             let (.notFound(lhsError), .notFound(rhsError)),
             let (.network(lhsError), .network(rhsError)),
             let (.generic(lhsError), .generic(rhsError)):
            return lhsError ~= rhsError
        default:
            return false
        }
    }

    case invalidRequest
    case decoding(_ error: Error?)
    case notFound(_ error: Error?)
    case network(_ error: Error?)
    case generic(_ error: Error?)
}

/// Custom operator for matching error objects
/// - Parameters:
///   - lhs: leftside error object
///   - rhs: rightside error object
func ~= (lhs: Error?, rhs: Error?) -> Bool {
    return lhs?._code == rhs?._code && lhs?._domain == rhs?._domain
}
