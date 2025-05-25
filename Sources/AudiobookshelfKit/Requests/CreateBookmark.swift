//
//  CreateBookmark.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint creates a bookmark for the authenticated user.
    struct CreateBookmark: ResourceRequest {
        public var path: String { "api/me/item/\(libraryItemId)/bookmark" }
        public let httpMethod = "POST"
        public var httpBody: Codable? {
            RequestBody(time: time, title: title)
        }

        private let libraryItemId: String
        private let time: TimeInterval
        private let title: String

        /// - Parameters:
        ///   - libraryItemId: The ID of the library item.
        ///   - time: The time (in seconds) in the book to place the bookmark.
        ///   - title: The title of the bookmark.
        public init(libraryItemId: String, time: TimeInterval, title: String) {
            self.libraryItemId = libraryItemId
            self.time = time
            self.title = title
        }
    }
}

public extension Audiobookshelf.Request.CreateBookmark {
    struct RequestBody: Codable {
        public let time: TimeInterval
        public let title: String
    }

    struct Response: Codable, Sendable {
        public let success: Bool
        public let bookmark: Bookmark
    }
}
