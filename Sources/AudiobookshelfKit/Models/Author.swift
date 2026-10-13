//
//  Author.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Author: Codable, Hashable, Sendable {
    /// The ID of the author.
    public let id: String
    /// The ASIN of the author. Will be null if unknown.
    @Lenient public var asin: String?
    /// The name of the author.
    @Lenient public var name: String?
    /// A description of the author. Will be null if there is none.
    @Lenient public var description: String?
    /// The absolute path for the author image. Will be null if there is no image.
    @Lenient public var imagePath: String?
    /// The time (in ms since POSIX epoch) when the author was added.
    @Lenient public var addedAt: Date?
    /// The time (in ms since POSIX epoch) when the author was last updated.
    @Lenient public var updatedAt: Date?
    /// The ID of the library the author belongs to.
    @Lenient public var libraryId: String?
    /// The number of books associated with the author in the library.
    @Lenient public var numBooks: Int?
    /// The name of the author, last name first.
    @Lenient public var lastFirst: String?
}
