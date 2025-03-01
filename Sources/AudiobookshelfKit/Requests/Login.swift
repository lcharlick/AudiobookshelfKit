//
//  Login.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint logs in a client to the server, returning information about the user and server.
    struct Login: ResourceRequest {
        public let path = "login"
        public let httpMethod = "POST"
        public var httpBody: Codable? {
            ["username": username, "password": password]
        }

        private let username: String
        private let password: String

        public init(username: String, password: String) {
            self.username = username
            self.password = password
        }
    }
}

public extension Audiobookshelf.Request.Login {
    typealias Response = LoginResponse
}
