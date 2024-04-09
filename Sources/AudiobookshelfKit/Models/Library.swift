//
//  Library.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Library: Codable, Hashable {
    /// The ID of the library.
    public let id: String
    /// The name of the library.
    public let name: String
    /// The folders that the library is composed of on the server.
    public let folders: [Folder]
    /// Display position of the library in the list of libraries. Must be >= 1.
    public let displayOrder: Int
    /// The selected icon for the library. See Library Icons for a list of possible icons.
    public let icon: String
    /// The type of media that the library contains.
    public let mediaType: MediaType
    /// Preferred metadata provider for the library.
    public let provider: String
    /// The settings for the library.
    public let settings: LibrarySettings
    /// The time when the library was created.
    public let createdAt: Date
    /// The time when the library was last updated.
    public let lastUpdate: Date

    public init(id: String, name: String, folders: [Folder], displayOrder: Int, icon: String, mediaType: MediaType, provider: String, settings: LibrarySettings, createdAt: Date, lastUpdate: Date) {
        self.id = id
        self.name = name
        self.folders = folders
        self.displayOrder = displayOrder
        self.icon = icon
        self.mediaType = mediaType
        self.provider = provider
        self.settings = settings
        self.createdAt = createdAt
        self.lastUpdate = lastUpdate
    }
}
