//
//  RemoveBookmark.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint removes a bookmark for the authenticated user.
    struct RemoveBookmark: ResourceRequest {
        public var path: String { "api/me/item/\(libraryItemId)/bookmark" }
        public let httpMethod = "DELETE"

        public var queryItems: [URLQueryItem]? {
            [
                URLQueryItem(name: "time", value: String(Int(time))),
            ]
        }

        private let libraryItemId: String
        private let time: TimeInterval

        /// - Parameters:
        ///   - libraryItemId: The ID of the library item.
        ///   - time: The time (in seconds) where the bookmark is.
        public init(libraryItemId: String, time: TimeInterval) {
            self.libraryItemId = libraryItemId
            self.time = time
        }
    }
}

public extension Audiobookshelf.Request.RemoveBookmark {
    struct Response: Codable, Sendable {
        public let success: Bool
    }
}
