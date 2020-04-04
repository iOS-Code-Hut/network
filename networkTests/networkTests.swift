//
//  networkTests.swift
//  networkTests
//
//  Created by Guilherme Ramos on 03/04/20.
//  Copyright © 2020 Guilherme Ramos. All rights reserved.
//

import XCTest
@testable import network

class networkTests: XCTestCase {
    func testRequestOnHistory() {
        let exoected = SymbolHistory(
            rates: ["USD": ["BRL": 1.0]],
            base: "t",
            startDate: "2020-01-01",
            endDate: "2020-01-08"
        )
        let data = try? JSONEncoder().encode(exoected)

        let endpoint: SymbolEndpoint = .get7DaysHistory(base:"USD", to: "BRL")

        NetworkClient(session: URLSessionMock(data: data, response: nil, error: nil))
            .request(endpoint, for: SymbolHistory.self) { result in
                switch result {
                case let .success(result):
                    XCTAssertEqual(exoected, result)
                case let .failure(error):
                    XCTFail(error.localizedDescription)
                }
            }

    }
}
