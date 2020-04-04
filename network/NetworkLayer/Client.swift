//
//  Client.swift
//  network
//
//  Created by Guilherme Ramos on 03/04/20.
//  Copyright © 2020 Guilherme Ramos. All rights reserved.
//

import Foundation


struct NetworkClient {
    typealias RequestHandler<T: Decodable> = (_ result: Result<T, NetworkError>) -> Void

    static let shared = NetworkClient()

    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    /// Execute a request to an endpoint; after finishing the operation it will execute the completion block with a result
    /// that can be either  a swift decodable object or a NetworkError
    /// - Parameters:
    ///   - endpoint: Object conforming ot the Endpoint protocol, containing information to execute a request
    ///   - type: Type of the object to be returned if the request succeeds
    ///   - completion: completion block executed after the operation finishes
    func request<T: Decodable>(_ endpoint: Endpoint, for type: T.Type, _ completion: @escaping RequestHandler<T>) {
        guard let request = endpoint.request else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let task = dataTask(with: request, for: type, completion)
        task.resume()
    }

    /// Creates a URLSessionDataTask object  to execute a request to a specific urlRequest
    /// - Parameters:
    ///   - url: url that will be requested
    ///   - type: type of the object returned as the response
    ///   - completion: completion block taht will lbe executed when the request finishes
    private func dataTask<T: Decodable>(with request: URLRequest, for type: T.Type,  _ completion: @escaping RequestHandler<T>) -> URLSessionDataTask  {
        return session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.notFound(error)))
                return
            }

            if let error = error {
                completion(.failure(.generic(error)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(type, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decoding(error)))
            }
        }
    }

    /// Creates a URLSessionDataTask object  to execute a request to a specific url
    /// - Parameters:
    ///   - url: url that will be requested
    ///   - type: type of the object returned as the response
    ///   - completion: completion block taht will lbe executed when the request finishes
    private func dataTask<T: Decodable>(with url: URL, for type: T.Type, completion: @escaping RequestHandler<T>) -> URLSessionDataTask {
        return session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.notFound(error)))
                return
            }

            if let error = error {
                completion(.failure(.generic(error)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(type, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decoding(error)))
            }
        }
    }
}
