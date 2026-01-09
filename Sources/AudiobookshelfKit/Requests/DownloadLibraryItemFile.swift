//
//  DownloadLibraryItemFile.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/9/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    struct DownloadLibraryItemFile: ResourceRequest {
        public var path: String { "api/items/\(id)/file/\(ino)/download" }
        public var accept: String { "audio/*" }

        private let id: String
        private let ino: String

        /// - Parameters:
        ///   - id: The ID of the library item to download the file for
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

public extension Audiobookshelf.Request.DownloadLibraryItemFile {
    typealias Response = Data

    static func response(from data: Data) throws -> Data {
        data
    }
}