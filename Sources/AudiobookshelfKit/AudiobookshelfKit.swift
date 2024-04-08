//
//  AudiobookshelfKit.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

// MARK: - Client.

public final class Audiobookshelf {
    private let sessionConfiguration: URLSessionConfiguration
    lazy var session = URLSession(
        configuration: sessionConfiguration
    )

    enum Constants {
        static let acceptableStatusCodes = 200 ..< 300
    }

    public init(sessionConfiguration: URLSessionConfiguration) {
        self.sessionConfiguration = sessionConfiguration
    }

    private func request<Response>(
        _ request: URLRequest,
        transformer: @escaping (Data) throws -> Response,
        completion: @escaping (Result<Response, AudiobookshelfError>) -> Void
    ) -> URLSessionTask? {
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(
                    .networkError(request.url!, .httpError(error))
                ))
                return
            }

            guard Constants.acceptableStatusCodes.contains(response.statusCode) else {
                completion(.failure(
                    .networkError(request.url!, .unacceptableStatusCode(response.statusCode))
                ))
                return
            }

            do {
                completion(.success(try transformer(data)))
            } catch {
                completion(.failure(.decodingFailed(request.url!, error)))
            }
        }

        task.resume()

        return task
    }

    @discardableResult public func request<Request: ResourceRequest>(
        _ request: Request,
        from url: URL,
        token: String? = nil,
        completion: @escaping (Result<Request.Response, AudiobookshelfError>) -> Void
    ) -> URLSessionTask? {
        let urlRequest: URLRequest

        do {
            urlRequest = try request.asURLRequest(
                from: url,
                using: token
            )
        } catch let error as AudiobookshelfError {
            completion(.failure(error))
            return nil
        } catch {
            completion(.failure(.invalidRequest(.unknown(error))))
            return nil
        }

        return self.request(
            urlRequest,
            transformer: Request.response(from:),
            completion: completion
        )
    }
}

// MARK: - Namespaces.

public extension Audiobookshelf {
    /// Namespace for `PlexConnectionRequest` implementations.
    enum Request {}
}

// MARK: - Errors.

public enum AudiobookshelfError: Error {
    /// An error occurred while constructing the request.
    case invalidRequest(RequestFailureReason)
    /// An networking error occurred.
    case networkError(URL, NetworkFailureReason)
    /// An error occurred while decoding the response.
    case decodingFailed(URL, Error)

    /// A token was not supplied for a request that required one.
    case notAuthenticated

    public enum RequestFailureReason {
        case invalidURL(String)
        case invalidQueryItems([URLQueryItem])
        case unknown(Error)
    }

    public enum NetworkFailureReason {
        case unacceptableStatusCode(Int)
        case httpError(Error?)
    }
}

