//
//  URLSessionProtocol+Mock.swift
//  networkTests
//
//  Created by Guilherme Ramos on 03/04/20.
//  Copyright © 2020 Guilherme Ramos. All rights reserved.
//

import Foundation
@testable import network

final class URLSessionMock: URLSessionProtocol {
    private var data: Data?
    private var response: URLResponse?
    private var error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        URLSessionDatakTaskMock {
            completionHandler(self.data, self.response, self.error)
        }
    }

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        URLSessionDatakTaskMock {
            completionHandler(self.data, self.response, self.error)
        }
    }

}

final class URLSessionDatakTaskMock: URLSessionDataTask {
    private var execution: () -> Void

    init(execution: @escaping () -> Void) {
        self.execution = execution
    }

    override func resume() {
        execution()
    }
}
