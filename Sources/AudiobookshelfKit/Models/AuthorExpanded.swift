//
//  AuthorExpanded.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct AuthorExpanded: Codable, Hashable, Sendable {
    /// The ID of the author.
    public let id: String
    /// The ASIN of the author. Will be null if unknown.
    public let asin: String?
    /// The name of the author.
    public let name: String
    /// A description of the author. Will be null if there is none.
    public let description: String?
    /// The absolute path for the author image. Will be null if there is no image.
    public let imagePath: String?
    /// The time (in ms since POSIX epoch) when the author was added.
    public let addedAt: Date
    /// The time (in ms since POSIX epoch) when the author was last updated.
    public let updatedAt: Date
    /// The ID of the library the author belongs to.
    public let libraryId: String
    public let libraryItems: [LibraryItemExpanded]
}
