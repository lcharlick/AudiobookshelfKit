//
//  Folder.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Folder: Codable, Hashable {
    /// The ID of the folder.
    public let id: String
    /// The path on the server for the folder.
    public let fullPath: String
    /// The ID of the library the folder belongs to.
    public let libraryId: String
    /// The time (in ms since POSIX epoch) when the folder was added.
    public let addedAt: Date

    public init(id: String, fullPath: String, libraryId: String, addedAt: Date) {
        self.id = id
        self.fullPath = fullPath
        self.libraryId = libraryId
        self.addedAt = addedAt
    }
}
