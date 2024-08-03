//
//  _Request.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

/// Describes a request to an Audiobookshelf resource (e.g. server).
public protocol ResourceRequest {
    associatedtype Response

    var path: String { get }
    var httpMethod: String { get }
    var accept: String { get }

    var queryItems: [URLQueryItem]? { get }
    var httpBody: Codable? { get }

    static func response(from data: Data) throws -> Response
}

public extension ResourceRequest {
    var httpMethod: String { "GET" }
    var accept: String { "application/json" }
    var queryItems: [URLQueryItem]? { nil }
    var httpBody: Codable? { nil }
}

public extension ResourceRequest where Response: Codable {
    static func _response(from data: Data) throws -> Response {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970

        // Check that we have valid utf8 data.
        // Internal JSONSerialization can crash under certain circumstances if `data` can't be decoded as utf8.
        guard String(data: data, encoding: .utf8) != nil else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Can't convert data to utf8 string"))
        }

        return try decoder.decode(Response.self, from: data)
    }

    static func response(from data: Data) throws -> Response {
        try _response(from: data)
    }
}

public extension ResourceRequest {
    func asURLRequest(
        from url: URL,
        using token: String?,
        tokenStrategy: TokenStrategy = .header
    ) throws -> URLRequest {
        try _asURLRequest(from: url, using: token, tokenStrategy: tokenStrategy)
    }

    internal func _asURLRequest(
        from url: URL,
        using token: String?,
        tokenStrategy: TokenStrategy
    ) throws -> URLRequest {
        var queryItems = self.queryItems ?? []
        if tokenStrategy == .queryItem, let token {
            queryItems.append(URLQueryItem(name: "token", value: token))
        }

        guard let url = url.appendingPathComponent(path).appendingQueryItems(queryItems) else {
            throw AudiobookshelfError.invalidRequest(.invalidQueryItems(queryItems))
        }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue(accept, forHTTPHeaderField: "accept")

        if tokenStrategy == .header, let token = token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let httpBody {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(httpBody)
        }

        return request
    }
}

public enum TokenStrategy {
    case header
    case queryItem
}
