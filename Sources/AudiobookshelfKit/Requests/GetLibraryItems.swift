//
//  GetLibraryItems.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 14/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint retrieves all libraries accessible to the user.
    struct GetLibraryItems: ResourceRequest {
        public var path: String { "api/libraries/\(libraryID)/items" }

        public var queryItems: [URLQueryItem]? {
            var items = [URLQueryItem]()
            items.append(URLQueryItem(name: "limit", value: String(limit)))
            items.append(URLQueryItem(name: "page", value: String(page)))
            if let sort {
                items.append(URLQueryItem(name: "sort", value: sort))
            }
            if let desc {
                items.append(URLQueryItem(name: "desc", value: desc))
            }
            if let filter, let data = filter.value.data(using: .utf8) {
                items.append(URLQueryItem(name: "filter", value: "\(filter.group).\(data.base64EncodedString())"))
            }
            if let collapsedSeries {
                items.append(URLQueryItem(name: "collapsedSeries", value: String(collapsedSeries ? 1 : 0)))
            }
            if let include {
                items.append(URLQueryItem(name: "include", value: include))
            }
            return items
        }

        private let libraryID: String
        private let limit: Int
        private let page: Int
        private let sort: String?
        private let desc: Bool?
        private let filter: Filter?
        private let collapsedSeries: Bool?
        private let include: String?

        /// - Parameters:
        ///   - libraryID:
        ///   - limit: Limit the number of returned results per page. If 0, no limit will be applied.
        ///   - page: The page number (0 indexed) to request. If there is no limit applied, then page will have no effect and all results will be returned.
        ///   - sort: What to sort the results by. Specify the attribute to sort by using JavaScript object notation. For example, to sort by title use sort=media.metadata.title. When filtering for a series, sort can also be sequence.
        ///   - desc: Whether to reverse the sort order. 0 for false, 1 for true.
        ///   - collapsedSeries: Whether to collapse books in a series to a single entry. 0 for false, 1 for true.
        ///   - include: A comma separated list of what to include with the library items. The only current option is rssfeed.
        public init(
            libraryID: String,
            limit: Int,
            page: Int,
            sort: String? = nil,
            desc: Bool? = nil,
            filter: Filter? = nil,
            collapsedSeries: Bool? = nil,
            include: String? = nil
        ) {
            self.libraryID = libraryID
            self.limit = limit
            self.page = page
            self.sort = sort
            self.desc = desc
            self.filter = filter
            self.collapsedSeries = collapsedSeries
            self.include = include
        }
        
        public struct Filter: Codable, Hashable, Sendable {
            let group: String
            let value: String
            
            public init(group: String, value: String) {
                self.group = group
                self.value = value
            }
        }
    }
}

public extension Audiobookshelf.Request.GetLibraryItems {
    struct Response: Codable, Sendable {
        public let results: [LibraryItem]
        public let total: Int
        public let limit: Int
        public let page: Int
    }
}
