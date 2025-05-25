//
//  Collection.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/4/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Collection: Codable, Hashable, Identifiable {
    /// The ID of the collection.
    public let id: String
    /// The ID of the library the collection belongs to.
    public let libraryId: String
    /// The ID of the user that created the collection.
    public let userId: String?
    /// The name of the collection.
    public let name: String
    /// The collection's description. Will be null if there is none.
    public let description: String?
    /// The books that belong to the collection.
    public let books: [LibraryItem]
    /// The time (in ms since POSIX epoch) when the collection was last updated.
    public let lastUpdate: Date
    /// The time (in ms since POSIX epoch) when the collection was created.
    public let createdAt: Date
}
