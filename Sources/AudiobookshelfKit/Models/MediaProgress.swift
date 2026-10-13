//
//  MediaProgress.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct MediaProgress: Codable, Hashable, Identifiable, Sendable {
    /// The ID of the media progress.
    /// If the media progress is for a book, this will just be the libraryItemId.
    /// If for a podcast episode, it will be a hyphenated combination of the libraryItemId and episodeId.
    public let id: String
    /// The ID of the user the media progress is for.
    @Lenient public var userId: String?
    /// The ID of the library item the media progress is of.
    @Lenient public var libraryItemId: String?
    /// The ID of the podcast episode the media progress is of.
    /// Will be nil if the progress is for a book.
    @Lenient public var episodeId: String?
    ///
    @Lenient public var mediaItemId: String?
    ///
    @Lenient public var mediaItemType: MediaType?
    /// The total duration (in seconds) of the media.
    /// Will be 0 if the media was marked as finished without the user listening to it.
    @Lenient public var duration: TimeInterval?
    /// The percentage completion progress of the media.
    /// Will be 1 if the media is finished.
    @Lenient public var progress: Double?
    /// The current time (in seconds) of the user's progress.
    /// If the media has been marked as finished, this will be the time the user was at beforehand.
    @Lenient public var currentTime: TimeInterval?
    /// Whether the media is finished.
    @Lenient public var isFinished: Bool?
    /// Whether the media will be hidden from the "Continue Listening" shelf.
    @Lenient public var hideFromContinueListening: Bool?
    /// The time when the media progress was last updated.
    @Lenient public var lastUpdate: Date?
    /// The time when the media progress was created.
    @Lenient public var startedAt: Date?
    /// The time when the media was finished.
    /// Will be nil if the media is not finished.
    @Lenient public var finishedAt: Date?
}
