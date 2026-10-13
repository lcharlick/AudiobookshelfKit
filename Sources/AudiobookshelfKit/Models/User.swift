//
//  User.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct User: Codable, Hashable, Identifiable, Sendable {
    /// The ID of the user. Only the root user has the root ID.
    public let id: String
    ///
    @Lenient public var oldUserId: String?
    /// The username of the user.
    @Lenient public var username: String?
    /// The email of the user.
    @Lenient public var email: String?
    /// The type of the user. There will be only one root user which is created when the server first starts.
    @Lenient public var type: UserType?
    /// The authentication token of the user. Old method of authentication, replaced by access and refresh tokens in ABS 2.26.0+.
    @Lenient public var token: String?
    /// Long-lived token used to create new access tokens. ABS 2.26.0+.
    @Lenient public var refreshToken: String?
    /// Short-lived tokens used for requests. ABS 2.26.0+.
    @Lenient public var accessToken: String?
    /// The user's media progress.
    @LossyArray public var mediaProgress: [MediaProgress]
    /// The IDs of series to hide from the user's "Continue Series" shelf.
    @LossyArray public var seriesHideFromContinueListening: [String]
    /// The user's bookmarks.
    @LossyArray public var bookmarks: [Bookmark]
    /// Whether the user's account is active.
    @Lenient public var isActive: Bool?
    /// Whether the user is locked.
    @Lenient public var isLocked: Bool?
    /// The time (in ms since POSIX epoch) when the user was last seen by the server. Will be null if the user has never logged in.
    @Lenient public var lastSeen: Date?
    /// The time (in ms since POSIX epoch) when the user was created.
    @Lenient public var createdAt: Date?
    /// The user's permissions.
    @DefaultEmpty public var permissions: Permissions
    /// The IDs of libraries accessible to the user. An empty array means all libraries are accessible.
    @LossyArray public var librariesAccessible: [String]
    /// The tags accessible to the user. An empty array means all tags are accessible.
    @LossyArray public var itemTagsAccessible: [String]
}

public enum UserType: String, Codable, Sendable {
    case root
    case guest
    case user
    case admin
}
