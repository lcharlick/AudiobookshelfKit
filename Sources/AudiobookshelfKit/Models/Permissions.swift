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
    public let download: Bool
    /// Whether the user can update library items.
    public let update: Bool
    /// Whether the user can delete library items.
    public let delete: Bool
    /// Whether the user can upload items to the server.
    public let upload: Bool
    /// Whether the user can access all libraries.
    public let accessAllLibraries: Bool
    /// Whether the user can access all tags.
    public let accessAllTags: Bool
    /// Whether the user can access explicit content.
    public let accessExplicitContent: Bool
}
