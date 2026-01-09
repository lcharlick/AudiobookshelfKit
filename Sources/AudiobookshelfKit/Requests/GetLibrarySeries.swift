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
    }
}
