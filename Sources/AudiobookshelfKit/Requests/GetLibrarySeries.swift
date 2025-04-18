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
                URLQueryItem(name: "sortBy", value: sortBy),
                URLQueryItem(name: "sortDesc", value: sortDesc),
                URLQueryItem(name: "minified", value: minified)
            ]
        }

        private let libraryID: String
        private let page: Int
        private let limit: Int
        private let sortBy: String
        private let sortDesc: Bool
        private let minified: Bool

        /// - Parameters:
        ///   - libraryID: The ID of the library.
        ///   - page: The page number (0 indexed) to request.
        ///   - limit: Limit the number of returned results per page. Must be greater than 0.
        ///   - sortBy: What to sort the results by. By default, the results will be sorted by series name. Other sort options are: numBooks, totalDuration, and addedAt.
        ///   - sortDesc: Whether to reverse the sort order. 
        ///   - minified: 
        public init(
            libraryID: String,
            page: Int,
            limit: Int,
            sortBy: String = "name",
            sortDesc: Bool = false,
            minified: Bool = false
        ) {
            self.libraryID = libraryID
            self.page = page
            self.limit = limit
            self.sortBy = sortBy
            self.sortDesc = sortDesc
            self.minified = minified
        }
    }
}

extension Audiobookshelf.Request.GetLibrarySeries {
    public struct Response: Codable {
        public let results: [Series]
        public let total: Int
        public let limit: Int
        public let page: Int
        public let sortBy: String?
        public let sortDesc: Bool?
        public let minified: Bool?
        public let include: String?
    }
}
