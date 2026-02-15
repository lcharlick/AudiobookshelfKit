//
//  EbookFile.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 15/2/26.
//

import Foundation

public struct EbookFile: Codable, Hashable, Sendable {
    /// The inode of the ebook file.
    public let ino: String
    /// The ebook file metadata.
    public let metadata: LibraryFile.Metadata
    /// The time when the ebook file was added to the library.
    public let addedAt: Date
    /// The time when the ebook file was last updated.
    public let updatedAt: Date
    /// The ebook format (for example, "epub").
    public let ebookFormat: String
}
