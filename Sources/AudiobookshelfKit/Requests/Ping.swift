//
//  Ping.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 9/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

public extension Audiobookshelf.Request {
    /// This endpoint is a simple check to see if the server is operating and responding with JSON correctly.
    struct Ping: ResourceRequest {
        public let path = "ping"

        public init() {}
    }
}

public extension Audiobookshelf.Request.Ping {
    struct Response: Codable {
        /// Will always be `true`.
        public let success: Bool
    }
}
