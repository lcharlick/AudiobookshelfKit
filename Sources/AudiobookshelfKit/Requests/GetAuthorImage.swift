//
//  GetAuthorImage.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 6/5/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint retrieves an author's image.
    struct GetAuthorImage: ResourceRequest {
        public var path: String { "api/authors/\(id)/image" }
        public var accept: String { "image/*" }

        public var queryItems: [URLQueryItem]? {
            var items = [URLQueryItem]()
            if let width {
                items.append(.init(name: "width", value: String(width)))
            }
            if let height {
                items.append(.init(name: "height", value: String(height)))
            }
            if let format {
                items.append(.init(name: "format", value: format.rawValue))
            }
            if let raw {
                items.append(.init(name: "raw", value: raw))
            }
            return items
        }

        private let id: String
        private let width: Int?
        private let height: Int?
        private let format: Format?
        private let raw: Bool?

        /// Create a new request to retrieve an author's image.
        /// - Parameters:
        ///   - id: The ID of the author to retrieve the image for
        ///   - width: The requested width of the author image
        ///   - height: The requested height of the author image
        ///   - format: The requested format of the author image
        ///   - raw: Whether to get the raw author image file instead of a scaled version
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

        public enum Format: String, Sendable {
            case webp, jpeg
        }
    }
}

public extension Audiobookshelf.Request.GetAuthorImage {
    typealias Response = Data

    static func response(from data: Data) throws -> Data {
        data
    }
}
