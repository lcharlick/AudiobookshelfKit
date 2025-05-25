//
//  GetLibraryPlaylists.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint retrieves all playlists for a library that are accessible to the user.
    struct GetLibraryPlaylists: ResourceRequest {
        public var path: String { "api/libraries/\(libraryID)/playlists" }

        public var queryItems: [URLQueryItem]? {
            var items = [URLQueryItem]()
            items.append(URLQueryItem(name: "limit", value: String(limit)))
            items.append(URLQueryItem(name: "page", value: String(page)))
            return items
        }

        private let libraryID: String
        private let limit: Int
        private let page: Int

        /// - Parameters:
        ///   - libraryID: The ID of the library.
        ///   - limit: Limit the number of returned results per page. If 0, no limit will be applied.
        ///   - page: The page number (0 indexed) to request. If there is no limit applied, then page will have no effect and all results will be returned.
        public init(
            libraryID: String,
            limit: Int = 0,
            page: Int = 0
        ) {
            self.libraryID = libraryID
            self.limit = limit
            self.page = page
        }
    }
}

public extension Audiobookshelf.Request.GetLibraryPlaylists {
    struct Response: Codable {
        public let results: [Playlist]
        public let total: Int
        public let limit: Int
        public let page: Int
    }
}
