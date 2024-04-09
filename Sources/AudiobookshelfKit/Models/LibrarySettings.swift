//
//  LibrarySettings.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct LibrarySettings: Codable, Hashable {
    /// Whether the library should use square book covers.
    /// Must be 0 (for false) or 1 (for true).
    public let coverAspectRatio: Int
    /// Whether to disable the folder watcher for the library.
    public let disableWatcher: Bool
    /// Whether to skip matching books that already have an ASIN.
    public let skipMatchingMediaWithAsin: Bool
    /// Whether to skip matching books that already have an ISBN.
    public let skipMatchingMediaWithIsbn: Bool
    /// The cron expression for when to automatically scan the library folders.
    /// If null, automatic scanning will be disabled.
    public let autoScanCronExpression: String?

    public init(coverAspectRatio: Int, disableWatcher: Bool, skipMatchingMediaWithAsin: Bool, skipMatchingMediaWithIsbn: Bool, autoScanCronExpression: String?) {
        self.coverAspectRatio = coverAspectRatio
        self.disableWatcher = disableWatcher
        self.skipMatchingMediaWithAsin = skipMatchingMediaWithAsin
        self.skipMatchingMediaWithIsbn = skipMatchingMediaWithIsbn
        self.autoScanCronExpression = autoScanCronExpression
    }
}
