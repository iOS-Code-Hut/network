//
//  Model.swift
//  network
//
//  Created by Guilherme Ramos on 03/04/20.
//  Copyright © 2020 Guilherme Ramos. All rights reserved.
//

import Foundation

typealias CurrencyPair = [String: Double]

struct Symbol: Codable, Equatable {
    var rates: CurrencyPair
    var base: String
    var date: String

    enum CodingKeys: String, CodingKey {
        case rates
        case base
        case date
    }
}

struct SymbolHistory: Codable, Equatable {
    var rates: [String: CurrencyPair] = [:]
    var base: String = ""
    var startDate: String = ""
    var endDate: String = ""

    enum CodingKeys: String, CodingKey {
        case rates, base
        case startDate = "start_at"
        case endDate = "end_at"
    }

    func list() -> [String] {
        return rates.reduce([]) { (result, pair) -> [String] in
            return result + pair.value.compactMap { String(format: "%.2f", $0.value)}
        }

    }
}
