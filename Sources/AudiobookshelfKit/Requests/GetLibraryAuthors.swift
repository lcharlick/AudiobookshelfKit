//
//  GetLibraryAuthors.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 28/5/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint returns a library's authors.
    struct GetLibraryAuthors: ResourceRequest {
        public var path: String { "api/libraries/\(libraryID)/authors" }
        
        public var queryItems: [URLQueryItem]? {
            var items = [URLQueryItem]()
            
            if let limit {
                items.append(URLQueryItem(name: "limit", value: String(limit)))
            }
            if let page {
                items.append(URLQueryItem(name: "page", value: String(page)))
            }
            if let order {
                items.append(URLQueryItem(name: "sort", value: order))
            }
            if let desc, desc {
                items.append(URLQueryItem(name: "desc", value: true))
            }
            
            return items.isEmpty ? nil : items
        }

        private let libraryID: String
        private let limit: Int?
        private let page: Int?
        private let order: String?
        private let desc: Bool?

        /// - Parameters:
        ///   - libraryID:
        ///   - limit: Limit the number of returned results per page. If nil, no limit will be applied.
        ///   - page: The page number (0 indexed) to request. If there is no limit applied, then page will have no effect and all results will be returned.
        ///   - order:
        public init(
            libraryID: String,
            limit: Int,
            page: Int,
            order: String? = nil,
            desc: Bool? = nil,
        ) {
            self.libraryID = libraryID
            self.limit = limit
            self.page = page
            self.order = order
            self.desc = desc
        }
    }
}

public extension Audiobookshelf.Request.GetLibraryAuthors {
    struct Response: Codable, Sendable {
        public let results: [Author]
        public let total: Int
        public let limit: Int
        public let page: Int
    }
}
