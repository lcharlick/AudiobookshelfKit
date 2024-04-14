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
        transformer: @escaping (Data) throws -> Response
    ) async -> Result<Response, AudiobookshelfError> {

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: request)
        } catch let error {
            return .failure(.networkError(request.url!, .urlSessionError(error)))
        }

        if let response = response as? HTTPURLResponse {
            guard Constants.acceptableStatusCodes.contains(response.statusCode) else {
                return .failure(.networkError(request.url!, .unacceptableStatusCode(response.statusCode)))
            }
        }
        
        do {
            return .success(try transformer(data))
        } catch {
            return .failure(.decodingFailed(request.url!, error))
        }
    }

    @discardableResult public func request<Request: ResourceRequest>(
        _ request: Request,
        from url: URL,
        token: String? = nil
    ) async -> Result<Request.Response, AudiobookshelfError> {
        let urlRequest: URLRequest

        do {
            urlRequest = try request.asURLRequest(
                from: url,
                using: token
            )
        } catch let error as AudiobookshelfError {
            return .failure(error)
        } catch {
            return .failure(.invalidRequest(.unknown(error)))
        }

        return await self.request(
            urlRequest,
            transformer: Request.response(from:)
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
        case urlSessionError(Error)
    }
}

