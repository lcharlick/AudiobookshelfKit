//
//  GetLibraryItemFile.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    struct GetLibraryItemFile: ResourceRequest {
        public var path: String { "api/items/\(id)/file/\(ino)" }
        public var accept: String { "audio/*" }

        private let id: String
        private let ino: String

        /// - Parameters:
        ///   - id: The ID of the library item to retrieve the file for
        ///   - ino: The inode of the file
        public init(
            id: String,
            ino: String
        ) {
            self.id = id
            self.ino = ino
        }
    }
}

public extension Audiobookshelf.Request.GetLibraryItemFile {
    typealias Response = Data

    static func response(from data: Data) throws -> Data {
        data
    }
}
