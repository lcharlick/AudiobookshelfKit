//
//  GetLibrarySeries.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 1/3/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint returns a library's series.
    struct GetLibrarySeries: ResourceRequest {
        public var path: String { "api/libraries/\(libraryID)/series" }

        public var queryItems: [URLQueryItem]? {
            [
                URLQueryItem(name: "page", value: page),
                URLQueryItem(name: "limit", value: limit),
                URLQueryItem(name: "sort", value: sort),
                URLQueryItem(name: "desc", value: desc),
                URLQueryItem(name: "minified", value: minified),
            ]
        }

        private let libraryID: String
        private let page: Int
        private let limit: Int
        private let sort: String
        private let desc: Bool
        private let minified: Bool

        /// - Parameters:
        ///   - libraryID: The ID of the library.
        ///   - page: The page number (0 indexed) to request.
        ///   - limit: Limit the number of returned results per page. Must be greater than 0.
        ///   - sort: What to sort the results by. By default, the results will be sorted by series name. Other sort options are: numBooks, totalDuration, and addedAt.
        ///   - desc: Whether to reverse the sort order.
        ///   - minified:
        public init(
            libraryID: String,
            page: Int,
            limit: Int,
            sort: String = "name",
            desc: Bool = false,
            minified: Bool = false
        ) {
            self.libraryID = libraryID
            self.page = page
            self.limit = limit
            self.sort = sort
            self.desc = desc
            self.minified = minified
        }
    }
}

public extension Audiobookshelf.Request.GetLibrarySeries {
    struct Response: Codable, Sendable {
        public let results: [Series]
        public let total: Int
        public let limit: Int
        public let page: Int
        public let sortBy: String?
        public let desc: Bool?
        public let minified: Bool?
        public let include: String?

        enum CodingKeys: String, CodingKey {
            case results
            case total
            case limit
            case page
            case sortBy
            case desc
            case minified
            case include
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            results = try container.decode([Series].self, forKey: .results)
            total = try container.decodeIfPresent(Int.self, forKey: .total) ?? results.count
            limit = try container.decode(Int.self, forKey: .limit)
            page = try container.decode(Int.self, forKey: .page)
            sortBy = try container.decodeIfPresent(String.self, forKey: .sortBy)
            desc = try container.decodeIfPresent(Bool.self, forKey: .desc)
            minified = try container.decodeIfPresent(Bool.self, forKey: .minified)
            include = try container.decodeIfPresent(String.self, forKey: .include)
        }
    }
}
