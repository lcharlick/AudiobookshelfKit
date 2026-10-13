//
//  Playlist.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Playlist: Codable, Hashable, Identifiable, Sendable {
    /// The ID of the playlist.
    public let id: String
    /// The ID of the library the playlist belongs to.
    @Lenient public var libraryId: String?
    /// The ID of the user the playlist belongs to.
    @Lenient public var userId: String?
    /// The name of the playlist.
    @Lenient public var name: String?
    /// The description of the playlist.
    @Lenient public var description: String?
    /// The absolute path on the server of the cover file. Will be null if there is no cover.
    @Lenient public var coverPath: String?
    /// The items in the playlist.
    @LossyArray public var items: [PlaylistItem]
    /// The time (in ms since POSIX epoch) when the playlist was last updated.
    @Lenient public var lastUpdate: Date?
    /// The time (in ms since POSIX epoch) when the playlist was created.
    @Lenient public var createdAt: Date?
}

public struct PlaylistItem: Codable, Hashable, Sendable {
    /// The ID of the library item.
    @Lenient public var libraryItemId: String?
    /// The ID of the podcast episode.
    @Lenient public var episodeId: String?
    /// The library item, expanded.
    @Lenient public var libraryItem: LibraryItemExpanded?
}
