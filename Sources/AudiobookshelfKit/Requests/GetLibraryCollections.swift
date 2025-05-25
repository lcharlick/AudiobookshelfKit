//
//  GetLibraryCollections.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/4/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint retrieves a library's collections.
    struct GetLibraryCollections: ResourceRequest {
        public var path: String { "api/libraries/\(libraryID)/collections" }

        public var queryItems: [URLQueryItem]? {
            var items = [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "page", value: String(page)),
            ]
            if let sort {
                items.append(URLQueryItem(name: "sort", value: sort))
            }
            if let desc {
                items.append(URLQueryItem(name: "desc", value: desc ? "1" : "0"))
            }
            if let minified {
                items.append(URLQueryItem(name: "minified", value: minified ? "1" : "0"))
            }
            if let include {
                items.append(URLQueryItem(name: "include", value: include))
            }
            return items
        }

        private let libraryID: String
        private let page: Int
        private let limit: Int
        private let sort: String?
        private let desc: Bool?
        private let minified: Bool?
        private let include: String?

        /// - Parameters:
        ///   - libraryID: The ID of the library.
        ///   - page: The page number (0 indexed) to request. If there is no limit applied, then page will have no effect and all results will be returned.
        ///   - limit: Limit the number of returned results per page. If 0, no limit will be applied.
        ///   - sort: What to sort the results by.
        ///   - desc: Whether to reverse the sort order.
        ///   - minified: Whether to request minified objects.
        ///   - include: A comma separated list of what to include with the library items. The only current option is rssfeed.
        public init(
            libraryID: String,
            page: Int,
            limit: Int,
            sort: String? = nil,
            desc: Bool? = nil,
            minified: Bool? = nil,
            include: String? = nil
        ) {
            self.libraryID = libraryID
            self.limit = limit
            self.page = page
            self.sort = sort
            self.desc = desc
            self.minified = minified
            self.include = include
        }
    }
}

public extension Audiobookshelf.Request.GetLibraryCollections {
    struct Response: Codable, Sendable {
        /// The requested collections.
        public let results: [Collection]
        /// The total number of results.
        public let total: Int
        /// The limit set in the request.
        public let limit: Int
        /// The page set in request.
        public let page: Int
        /// The sort set in the request. Will not exist if no sort was set.
        public let sortBy: String?
        /// Whether to reverse the sort order.
        public let sortDesc: Bool?
        /// The filter set in the request, URL decoded. Will not exist if no filter was set.
        public let filterBy: String?
        /// Whether minified was set in the request.
        public let minified: Bool?
        /// The requested include.
        public let include: String?
    }
}
