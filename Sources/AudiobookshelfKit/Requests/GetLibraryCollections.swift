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
                items.append(URLQueryItem(name: "desc", value: desc))
            }
            if let minified {
                items.append(URLQueryItem(name: "minified", value: minified))
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
        public let results: [Collection]
        /// Results left out because they couldn't be decoded.
        public let skippedCount: Int
        public let total: Int
        public let limit: Int?
        public let page: Int?
        public let sortBy: String?
        public let desc: Bool?
        public let filterBy: String?
        public let minified: Bool?
        public let include: String?

        enum CodingKeys: String, CodingKey {
            case results
            case total
            case limit
            case page
            case sortBy
            case desc
            case filterBy
            case minified
            case include
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let results = try container.decodeRequiredLossyArray(Collection.self, forKey: .results)
            self.results = results.wrappedValue
            skippedCount = results.skippedCount
            total = container.decodeLeniently(Int.self, forKey: .total) ?? results.wrappedValue.count + results.skippedCount
            limit = container.decodeLeniently(Int.self, forKey: .limit)
            page = container.decodeLeniently(Int.self, forKey: .page)
            sortBy = container.decodeLeniently(String.self, forKey: .sortBy)
            desc = container.decodeLeniently(Bool.self, forKey: .desc)
            filterBy = container.decodeLeniently(String.self, forKey: .filterBy)
            minified = container.decodeLeniently(Bool.self, forKey: .minified)
            include = container.decodeLeniently(String.self, forKey: .include)
        }
    }
}
