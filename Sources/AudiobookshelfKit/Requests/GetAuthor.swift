//
//  GetAuthor.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 29/5/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint retrieves an author.
    struct GetAuthor: ResourceRequest {
        public var path: String { "api/authors/\(id)" }
        public var queryItems: [URLQueryItem]? = [
            URLQueryItem(name: "include", value: "items"),
        ]

        private let id: String

        public init(id: String) {
            self.id = id
        }
    }
}

public extension Audiobookshelf.Request.GetAuthor {
    typealias Response = AuthorExpanded
}
