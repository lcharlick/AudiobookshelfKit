//
//  Folder.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Folder: Codable, Hashable, Sendable {
    /// The ID of the folder.
    @Lenient public var id: String?
    /// The path on the server for the folder.
    @Lenient public var fullPath: String?
    /// The ID of the library the folder belongs to.
    @Lenient public var libraryId: String?
    /// The time (in ms since POSIX epoch) when the folder was added.
    @Lenient public var addedAt: Date?
}
