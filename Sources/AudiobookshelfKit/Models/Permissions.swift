//
//  Permissions.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Permissions: Codable, Hashable, Sendable {
    /// Whether the user can download items to the server.
    @Lenient public var download: Bool?
    /// Whether the user can update library items.
    @Lenient public var update: Bool?
    /// Whether the user can delete library items.
    @Lenient public var delete: Bool?
    /// Whether the user can upload items to the server.
    @Lenient public var upload: Bool?
    /// Whether the user can access all libraries.
    @Lenient public var accessAllLibraries: Bool?
    /// Whether the user can access all tags.
    @Lenient public var accessAllTags: Bool?
    /// Whether the user can access explicit content.
    @Lenient public var accessExplicitContent: Bool?
}
