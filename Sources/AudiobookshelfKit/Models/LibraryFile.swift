//
//  LibraryFile.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct LibraryFile: Codable, Hashable, Sendable {
    public let ino: String
    public let metadata: Metadata
    public let isSupplementary: Bool?
    public let addedAt: Date
    public let updatedAt: Date
    public let fileType: String
}

public extension LibraryFile {
    struct Metadata: Codable, Hashable, Sendable {
        public let filename: String
        public let ext: String
        public let path: String
        public let relPath: String
        public let size: Int64
        public let mtimeMs: Date
        public let ctimeMs: Date
        public let birthtimeMs: Date
    }
}
