//
//  EbookFile.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 15/2/26.
//

import Foundation

public struct EbookFile: Codable, Hashable, Sendable {
    /// The inode of the ebook file.
    @Lenient public var ino: String?
    /// The ebook file metadata.
    @DefaultEmpty public var metadata: LibraryFile.Metadata
    /// The time when the ebook file was added to the library.
    @Lenient public var addedAt: Date?
    /// The time when the ebook file was last updated.
    @Lenient public var updatedAt: Date?
    /// The ebook format (for example, "epub").
    @Lenient public var ebookFormat: String?
}
