//
//  Collection.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/4/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Collection: Codable, Hashable, Identifiable, Sendable {
    /// The ID of the collection.
    public let id: String
    /// The ID of the library the collection belongs to.
    @Lenient public var libraryId: String?
    /// The ID of the user that created the collection.
    @Lenient public var userId: String?
    /// The name of the collection.
    @Lenient public var name: String?
    /// The collection's description. Will be null if there is none.
    @Lenient public var description: String?
    /// The books that belong to the collection.
    @LossyArray public var books: [LibraryItemExpanded]
    /// The time (in ms since POSIX epoch) when the collection was last updated.
    @Lenient public var lastUpdate: Date?
    /// The time (in ms since POSIX epoch) when the collection was created.
    @Lenient public var createdAt: Date?
}
