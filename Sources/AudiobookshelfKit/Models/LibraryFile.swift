//
//  LibraryFile.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct LibraryFile: Codable, Hashable, Sendable {
    @Lenient public var ino: String?
    @DefaultEmpty public var metadata: Metadata
    @Lenient public var isSupplementary: Bool?
    @Lenient public var addedAt: Date?
    @Lenient public var updatedAt: Date?
    @Lenient public var fileType: String?
}

public extension LibraryFile {
    struct Metadata: Codable, Hashable, Sendable {
        @Lenient public var filename: String?
        @Lenient public var ext: String?
        @Lenient public var path: String?
        @Lenient public var relPath: String?
        @Lenient public var size: Int64?
        @Lenient public var mtimeMs: Date?
        @Lenient public var ctimeMs: Date?
        @Lenient public var birthtimeMs: Date?
    }
}
