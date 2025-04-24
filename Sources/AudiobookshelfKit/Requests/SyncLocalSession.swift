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
            RequestBody(sessions: sessions)
        }

        private let sessions: [Session]

        public init(_ sessions: Session) {
            self.sessions = [sessions]
        }

        public init(_ parameters: [Session]) {
            self.sessions = parameters
        }
    }
}

public extension Audiobookshelf.Request.SyncLocalSession {
    struct Response: Codable {
        public let results: [Result]
    }

    struct RequestBody: Codable {
        public let sessions: [Session]
    }

    struct Result: Codable {
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
            self.startTime = startTime
            self.timeListening = timeListening
            self.currentTime = currentTime
            self.startedAt = startedAt
            self.updatedAt = updatedAt
        }
    }

    struct DeviceInfo: Codable {
        /// The ID of the device.
        public let deviceId: String
        /// The client device's manufacturer, as provided in the request.
        public let manufacturer: String?
        /// The client device's model, as provided in the request.
        public let model: String?
        /// For an Android device, the Android SDK version of the client, as provided in the request.
        public let sdkVersion: Int?
        /// Name of the client, as provided in the request.
        public let clientName: String
        /// Version of the client, as provided in the request.
        public let clientVersion: String

        public init(
            deviceId: String,
            manufacturer: String?,
            model: String?,
            sdkVersion: Int?,
            clientName: String,
            clientVersion: String
        ) {
            self.deviceId = deviceId
            self.manufacturer = manufacturer
            self.model = model
            self.sdkVersion = sdkVersion
            self.clientName = clientName
            self.clientVersion = clientVersion
        }
    }
}
