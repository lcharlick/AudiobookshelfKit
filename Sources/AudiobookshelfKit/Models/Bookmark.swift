//
//  Bookmark.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Bookmark: Codable, Hashable {
    /// The ID of the library item the bookmark is for.
    public let libraryItemId: String
    /// The title of the bookmark.
    public let title: String
    /// The time (in seconds) the bookmark is at in the book.
    public let time: TimeInterval
    /// The time the bookmark was created.
    public let createdAt: Date
}
