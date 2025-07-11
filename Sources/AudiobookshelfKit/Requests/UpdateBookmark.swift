//
//  UpdateBookmark.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint updates a bookmark for the authenticated user.
    struct UpdateBookmark: ResourceRequest {
        public var path: String { "api/me/item/\(libraryItemId)/bookmark" }
        public let httpMethod = "PATCH"
        public var httpBody: Codable? {
            RequestBody(time: time, title: title)
        }

        private let libraryItemId: String
        private let time: TimeInterval
        private let title: String

        /// - Parameters:
        ///   - libraryItemId: The ID of the library item.
        ///   - time: The time (in seconds) in the book where the bookmark is.
        ///   - title: The new title of the bookmark.
        public init(libraryItemId: String, time: TimeInterval, title: String) {
            self.libraryItemId = libraryItemId
            self.time = time
            self.title = title
        }
    }
}

public extension Audiobookshelf.Request.UpdateBookmark {
    typealias Response = Bookmark

    struct RequestBody: Codable {
        public let time: TimeInterval
        public let title: String
    }
}
