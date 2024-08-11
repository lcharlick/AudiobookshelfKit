//
//  User.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct User: Codable, Hashable {
    /// The ID of the user. Only the root user has the root ID.
    public let id: String
    ///
    public let oldUserId: String?
    /// The username of the user.
    public let username: String
    /// The email of the user.
    public let email: String?
    /// The type of the user. There will be only one root user which is created when the server first starts.
    public let type: UserType
    /// The authentication token of the user.
    public let token: String
    /// The user's media progress.
    public let mediaProgress: [MediaProgress]
    /// The IDs of series to hide from the user's "Continue Series" shelf.
    public let seriesHideFromContinueListening: [String]
    /// The user's bookmarks.
    public let bookmarks: [Bookmark]
    /// Whether the user's account is active.
    public let isActive: Bool
    /// Whether the user is locked.
    public let isLocked: Bool
    /// The time (in ms since POSIX epoch) when the user was last seen by the server. Will be null if the user has never logged in.
    public let lastSeen: Date?
    /// The time (in ms since POSIX epoch) when the user was created.
    public let createdAt: Date
    /// The user's permissions.
    public let permissions: Permissions
    /// The IDs of libraries accessible to the user. An empty array means all libraries are accessible.
    public let librariesAccessible: [String]
    /// The tags accessible to the user. An empty array means all tags are accessible.
    public let itemTagsAccessible: [String]?
}

public enum UserType: String, Codable {
    case root
    case guest
    case user
    case admin
}
