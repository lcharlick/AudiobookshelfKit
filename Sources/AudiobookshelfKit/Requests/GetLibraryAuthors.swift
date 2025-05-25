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

        private let libraryID: String

        /// - Parameters:
        ///   - libraryID:
        public init(libraryID: String) {
            self.libraryID = libraryID
        }
    }
}

public extension Audiobookshelf.Request.GetLibraryAuthors {
    struct Response: Codable, Sendable {
        public let authors: [Author]
    }
}
