//
//  SyncLocalSession.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    struct SyncLocalSession: ResourceRequest {
        public let path = "api/session/local-all"
        public let httpMethod: String = "POST"
        public var httpBody: Codable? {
            RequestBody(sessions: sessions, deviceInfo: sessions.first?.deviceInfo)
        }

        private let sessions: [Session]

        public init(_ sessions: Session) {
            self.sessions = [sessions]
        }

        public init(_ parameters: [Session]) {
            sessions = parameters
        }
    }
}

public extension Audiobookshelf.Request.SyncLocalSession {
    struct Response: Codable, Sendable {
        public let results: [Result]
    }

    struct RequestBody: Codable {
        public let sessions: [Session]
        public let deviceInfo: DeviceInfo?
    }

    struct Result: Codable, Hashable, Identifiable, Sendable {
        /// The ID of the playback session.
        public let id: String
        /// Whether the session was successfully synced.
        public let success: Bool
        /// Will only exist if success is false. The error that occurred when syncing.
        public let error: String?
        /// Will only exist if success is true. Whether the progress for the session's library item was updated.
        public let progressSynced: Bool?
    }

    struct Session: Codable {
        /// The ID of the playback session.
        public let id: String
        /// The ID of the library item.
        public let libraryItemId: String
        /// The ID of the episode. Will be null if this playback session was started without an episode ID.
        public let episodeId: String?
        /// The title of the playing item to show to the user.
        public let displayTitle: String
        /// The author of the playing item to show to the user.
        public let displayAuthor: String
        /// The given device info when the playback session was requested.
        public let deviceInfo: DeviceInfo
        /// What play method the playback session is using. See below for values.
        public let playMethod: PlayMethod
        /// The time (in seconds) where the playback session started.
        public let startTime: TimeInterval
        /// The amount of time (in seconds) the user has spent listening using this playback session.
        public let timeListening: TimeInterval
        /// The current time (in seconds) of the playback position.
        public let currentTime: TimeInterval
        /// The time when the playback session was started.
        public let startedAt: Date
        /// The time when the playback session was last updated.
        public let updatedAt: Date

        public init(
            id: String,
            libraryItemId: String,
            episodeId: String?,
            displayTitle: String,
            displayAuthor: String,
            deviceInfo: DeviceInfo,
            playMethod: PlayMethod,
            startTime: TimeInterval,
            timeListening: TimeInterval,
            currentTime: TimeInterval,
            startedAt: Date,
            updatedAt: Date
        ) {
            self.id = id
            self.libraryItemId = libraryItemId
            self.episodeId = episodeId
            self.displayTitle = displayTitle
            self.displayAuthor = displayAuthor
            self.deviceInfo = deviceInfo
            self.playMethod = playMethod
            self.startTime = startTime
            self.timeListening = timeListening
            self.currentTime = currentTime
            self.startedAt = startedAt
            self.updatedAt = updatedAt
        }
    }
}
