//
//  GetLibrarySeries.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 1/3/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint returns a library's series.
    struct GetLibrarySeries: ResourceRequest {
        public var path: String { "api/\(libraryID)/series" }

        private let libraryID: String

        /// - Parameters:
        ///   - libraryID:
        public init(libraryID: String) {
            self.libraryID = libraryID
        }
    }
}

public extension Audiobookshelf.Request.GetLibrarySeries {
    struct Response: Decodable {
        public let results: [Series]
        public let total: Int
        public let limit: Int
        public let page: Int
        public let sortBy: String
        public let sortDesc: Bool
        public let minified: Bool
        public let include: String
    }
}
