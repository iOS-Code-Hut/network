//
//  Endppppoint.swift
//  network
//
//  Created by Guilherme Ramos on 03/04/20.
//  Copyright © 2020 Guilherme Ramos. All rights reserved.
//

import Foundation

enum Method: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol Endpoint {
    var request: URLRequest? { get }
    var method: Method { get }
    var headers: [String: String]? { get }
    var httpBody: Data? { get }

    init(_ method: Method, path: String, queryItems: [URLQueryItem])
    init<T: Encodable>(_ method: Method, path: String, httpBody: T, headers: [String: String]) throws
}


struct SymbolEndpoint: Endpoint {
    private var path: String
    private var queryItems: [URLQueryItem] = []

    private(set) var request: URLRequest? = nil
    private(set) var httpBody: Data? = nil
    private(set) var method: Method = .get
    private(set) var headers: [String: String]? = nil


    init(_ method: Method, path: String, queryItems: [URLQueryItem]) {
        self.method = method
        self.path = path
        self.queryItems = queryItems
        self.request = makeRequest()
    }

    init<T: Encodable>(_ method: Method, path: String, httpBody: T, headers: [String: String]) throws {
        self.method = method
        self.path = path
        self.httpBody = try JSONEncoder().encode(httpBody)
        self.headers = headers
        self.request = makeRequest()
    }

    private func makeRequest() -> URLRequest? {
        guard let url = makeUrl() else {
            return nil
        }
        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        request.httpBody = httpBody
        headers?.forEach { (arg) in
            let (field, value) = arg
            request.addValue(value, forHTTPHeaderField: field)
        }
        return request
    }

    private func makeUrl() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.exchangeratesapi.io"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
