//
//  GetLibraryItem.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint retrieves a library item.
    struct GetLibraryItem: ResourceRequest {
        public var path: String { "api/items/\(id)" }

        public var queryItems: [URLQueryItem]? = [
            URLQueryItem(name: "expanded", value: true),
            URLQueryItem(name: "include", value: "authors,progress"),
        ]

        private let id: String

        public init(id: String) {
            self.id = id
        }
    }
}

public extension Audiobookshelf.Request.GetLibraryItem {
    typealias Response = LibraryItemExpanded
}
