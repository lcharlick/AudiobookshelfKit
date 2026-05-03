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
        public var path: String { "api/me/listening-sessions" }

        public var queryItems: [URLQueryItem]? {
            [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "itemsPerPage", value: String(itemsPerPage)),
            ]
        }

        private let page: Int
        private let itemsPerPage: Int

        public init(page: Int, itemsPerPage: Int) {
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

        enum CodingKeys: String, CodingKey {
            case sessions
            case total
            case numPages
            case itemsPerPage
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            sessions = try container.decode([PlaybackSession].self, forKey: .sessions)
            total = try container.decodeIfPresent(Int.self, forKey: .total) ?? sessions.count
            numPages = try container.decodeIfPresent(Int.self, forKey: .numPages) ?? 1
            itemsPerPage = try container.decodeIfPresent(Int.self, forKey: .itemsPerPage) ?? sessions.count
        }
    }
}
