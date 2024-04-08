//
//  User.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

struct User: Codable, Hashable {
    let id: String
    let username: String
    let type: String
    let token: String
    let mediaProgress: [MediaProgress]
    let seriesHideFromContinueListening: [String]
    let bookmarks: [String]
    let isActive: Bool
    let isLocked: Bool
    let lastSeen: Date
    let createdAt: Date
    let permissions: Permissions
    let librariesAccessible: [String]
    let itemTagsAccessible: [String]
}
