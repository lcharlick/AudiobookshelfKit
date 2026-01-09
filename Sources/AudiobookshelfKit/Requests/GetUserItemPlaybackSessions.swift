//
//  GetUserItemPlaybackSessions.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 4/12/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint retrieves a user's playback sessions for a specific library item.
    struct GetUserItemPlaybackSessions: ResourceRequest {
        public var path: String { "api/me/item/listening-sessions/\(libraryItemId)" }

        public var queryItems: [URLQueryItem]? {
            [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "itemsPerPage", value: String(itemsPerPage)),
            ]
        }

        private let libraryItemId: String
        private let page: Int
        private let itemsPerPage: Int

        public init(libraryItemId: String, page: Int, itemsPerPage: Int) {
            self.libraryItemId = libraryItemId
            self.page = page
            self.itemsPerPage = itemsPerPage
        }
    }
}

public extension Audiobookshelf.Request.GetUserItemPlaybackSessions {
    struct Response: Codable, Sendable {
        /// The requested sessions.
        public let sessions: [PlaybackSession]
        /// The total number of sessions.
        public let total: Int
        /// The number of pages.
        public let numPages: Int
        /// The provided itemsPerPage parameter.
        public let itemsPerPage: Int
    }
}
