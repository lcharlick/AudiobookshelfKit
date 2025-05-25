//
//  Playlist.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Playlist: Codable, Hashable, Identifiable {
    /// The ID of the playlist.
    public let id: String
    /// The ID of the library the playlist belongs to.
    public let libraryId: String
    /// The ID of the user the playlist belongs to.
    public let userId: String
    /// The name of the playlist.
    public let name: String
    /// The description of the playlist.
    public let description: String?
    /// The absolute path on the server of the cover file. Will be null if there is no cover.
    public let coverPath: String?
    /// The items in the playlist.
    public let items: [PlaylistItem]
    /// The time (in ms since POSIX epoch) when the playlist was last updated.
    public let lastUpdate: Date
    /// The time (in ms since POSIX epoch) when the playlist was created.
    public let createdAt: Date
}

public struct PlaylistItem: Codable, Hashable {
    /// The ID of the library item.
    public let libraryItemId: String
    /// The ID of the podcast episode.
    public let episodeId: String?
    /// The library item, expanded.
    public let libraryItem: LibraryItemExpanded?
}