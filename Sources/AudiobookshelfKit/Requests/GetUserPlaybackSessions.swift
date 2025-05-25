//
//  GetUserPlaybackSessions.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/4/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint retrieves a user's playback sessions.
    struct GetUserPlaybackSessions: ResourceRequest {
        public var path: String { "api/users/\(userId)/listening-sessions" }

        public var queryItems: [URLQueryItem]? {
            var items = [URLQueryItem]()
            if let page {
                items.append(URLQueryItem(name: "page", value: String(page)))
            }
            if let itemsPerPage {
                items.append(URLQueryItem(name: "itemsPerPage", value: String(itemsPerPage)))
            }
            return items
        }

        private let userId: String
        private let page: Int?
        private let itemsPerPage: Int?

        public init(userId: String, page: Int? = nil, itemsPerPage: Int? = nil) {
            self.userId = userId
            self.page = page
            self.itemsPerPage = itemsPerPage
        }
    }
}

public extension Audiobookshelf.Request.GetUserPlaybackSessions {
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
