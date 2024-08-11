//
//  GetMediaProgress.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 30/7/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint retrieves your media progress that is associated with the given library item ID or podcast episode ID.
    struct GetMediaProgress: ResourceRequest {
        public var path: String { "api/me/progress/\(libraryItemID)" }

        private let libraryItemID: String

        /// - Parameters:
        ///   - libraryItemID:
        public init(libraryItemID: String) {
            self.libraryItemID = libraryItemID
        }
    }
}

public extension Audiobookshelf.Request.GetMediaProgress {
    typealias Response = MediaProgress
}
