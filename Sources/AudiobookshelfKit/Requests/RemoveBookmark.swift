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
        public var path: String { "api/me/item/\(libraryItemId)/bookmark/\(Int(time))" }
        public let httpMethod = "DELETE"

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
    typealias Response = Data

    static func response(from data: Data) throws -> Data {
        data
    }
}
