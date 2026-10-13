//
//  LibrarySettings.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct LibrarySettings: Codable, Hashable, Sendable {
    /// Whether the library should use square book covers.
    /// Must be 0 (for false) or 1 (for true).
    @Lenient public var coverAspectRatio: Int?
    /// Whether to disable the folder watcher for the library.
    @Lenient public var disableWatcher: Bool?
    /// Whether to skip matching books that already have an ASIN.
    @Lenient public var skipMatchingMediaWithAsin: Bool?
    /// Whether to skip matching books that already have an ISBN.
    @Lenient public var skipMatchingMediaWithIsbn: Bool?
    /// The cron expression for when to automatically scan the library folders.
    /// If null, automatic scanning will be disabled.
    @Lenient public var autoScanCronExpression: String?
}
