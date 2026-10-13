//
//  Library.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Library: Codable, Hashable, Identifiable, Sendable {
    /// The ID of the library.
    public let id: String
    /// The name of the library.
    @Lenient public var name: String?
    /// The folders that the library is composed of on the server.
    @LossyArray public var folders: [Folder]
    /// Display position of the library in the list of libraries. Must be >= 1.
    @Lenient public var displayOrder: Int?
    /// The selected icon for the library. See Library Icons for a list of possible icons.
    @Lenient public var icon: String?
    /// The type of media that the library contains.
    @Lenient public var mediaType: MediaType?
    /// Preferred metadata provider for the library.
    @Lenient public var provider: String?
    /// The settings for the library.
    @DefaultEmpty public var settings: LibrarySettings
    /// The time when the library was created.
    @Lenient public var createdAt: Date?
    /// The time when the library was last updated.
    @Lenient public var lastUpdate: Date?
    /// The time when the library was last scanned.
    @Lenient public var lastScan: Date?
}
