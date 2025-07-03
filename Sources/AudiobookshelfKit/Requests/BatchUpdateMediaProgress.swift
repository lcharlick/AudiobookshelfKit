//
//  BatchUpdateMediaProgress.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 3/8/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint batch creates/updates your media progress.
    struct BatchUpdateMediaProgress: ResourceRequest {
        public let path = "api/me/progress/batch/update"
        public let httpMethod = "PATCH"
        public var httpBody: Codable? {
            parameters
        }

        private let parameters: [Parameters]

        public init(_ parameters: [Parameters]) {
            self.parameters = parameters
        }
    }
}

public extension Audiobookshelf.Request.BatchUpdateMediaProgress {
    typealias Response = Data

    static func response(from data: Data) throws -> Data {
        data
    }

    struct Parameters: Codable, Hashable, Sendable {
        /// The ID of the library item the media progress is for.
        public let libraryItemId: String
        /// The ID of the podcast episode the media progress is for.
        public let episodeId: String?
        /// The total duration (in seconds) of the media.
        public let duration: TimeInterval
        /// The percentage completion progress of the media. Will automatically be set to 1 if the media is finished.
        public let progress: Double
        /// The current time (in seconds) of your progress.
        public let currentTime: TimeInterval
        /// Whether the media is finished.
        public let isFinished: Bool
        /// Whether the media will be hidden from the "Continue Listening" shelf.
        public let hideFromContinueListening: Bool?
        /// The time when the user finished the media. The default will be Date.now() if isFinished is true.
        public let finishedAt: Date?
        /// The time when the user started consuming the media. The default will be the value of finishedAt if isFinished is true.
        public let startedAt: Date?

        public init(
            libraryItemId: String,
            episodeId: String? = nil,
            duration: TimeInterval,
            progress: Double,
            currentTime: TimeInterval,
            isFinished: Bool,
            hideFromContinueListening: Bool? = nil,
            finishedAt: Date? = nil,
            startedAt: Date? = nil
        ) {
            self.libraryItemId = libraryItemId
            self.episodeId = episodeId
            self.duration = duration
            self.progress = progress
            self.currentTime = currentTime
            self.isFinished = isFinished
            self.hideFromContinueListening = hideFromContinueListening
            self.finishedAt = finishedAt
            self.startedAt = startedAt
        }
    }
}
