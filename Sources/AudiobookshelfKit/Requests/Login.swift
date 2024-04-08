//
//  Login.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// Basic auth with username / password.
    struct Login: ResourceRequest {
        public let path = "login"
        public let httpMethod = "POST"
        public var httpBody: [String : String]? {
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
    struct Response: Codable {
        let user: User
        let userDefaultLibraryId: String
        let serverSettings: ServerSettings
        private let Source: String
        public var source: String { Source }
    }
}
