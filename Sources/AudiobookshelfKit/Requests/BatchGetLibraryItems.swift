//
//  BatchGetLibraryItems.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 4/10/26.
//  Copyright © 2026 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint retrieves expanded library items by ID.
    ///
    /// Items the server can't find are left out of the response.
    struct BatchGetLibraryItems: ResourceRequest {
        public let path = "api/items/batch/get"
        public let httpMethod = "POST"
        public var httpBody: Codable? {
            Body(libraryItemIds: libraryItemIDs)
        }

        private let libraryItemIDs: [String]

        public init(libraryItemIDs: [String]) {
            self.libraryItemIDs = libraryItemIDs
        }
    }
}

public extension Audiobookshelf.Request.BatchGetLibraryItems {
    struct Body: Codable, Hashable, Sendable {
        public let libraryItemIds: [String]
    }

    struct Response: Codable, Sendable {
        public let libraryItems: [LibraryItemExpanded]
    }
}
