//
//  GetLibraryItemCover.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint retrieves a library item's cover.
    struct GetLibraryItemCover: ResourceRequest {
        public var path: String { "api/items/\(id)/cover" }
        public var accept: String { "image/*" }

        public var queryItems: [URLQueryItem]? {
            var items = [URLQueryItem]()
            if let width = width {
                items.append(.init(name: "width", value: String(width)))
            }
            if let height = height {
                items.append(.init(name: "height", value: String(height)))
            }
            if let format = format {
                items.append(.init(name: "format", value: format.rawValue))
            }
            if let raw = raw {
                items.append(.init(name: "raw", value: raw))
            }
            return items
        }

        private let id: String
        private let width: Int?
        private let height: Int?
        private let format: Format?
        private let raw: Bool?

        /// Create a new request to retrieve a library item's cover.
        /// - Parameters:
        ///   - id: The ID of the library item to retrieve the cover for
        ///   - width: The requested width of the cover image
        ///   - height: The requested height of the cover image
        ///   - format: The requested format of the cover image
        ///   - raw: Whether to get the raw cover image file instead of a scaled version
        public init(
            id: String,
            width: Int? = nil,
            height: Int? = nil,
            format: Format? = nil,
            raw: Bool? = nil
        ) {
            self.id = id
            self.width = width
            self.height = height
            self.format = format
            self.raw = raw
        }

        public enum Format: String {
            case webp, jpeg
        }
    }
}

public extension Audiobookshelf.Request.GetLibraryItemCover {
    typealias Response = Data

    static func response(from data: Data) throws -> Data {
        data
    }
}
