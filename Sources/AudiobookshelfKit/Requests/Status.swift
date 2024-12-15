//
//  Status.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 15/12/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint reports the server's initialization status.
    struct Status: ResourceRequest {
        public let path = "status"

        public init() {}
    }
}

public extension Audiobookshelf.Request.Status {
    struct Response: Codable {
        public let app: String
        public let serverVersion: String
        public let isInit: Bool
        public let language: String
        public let authMethods: Set<AuthMethod>
        public let authFormData: AuthFormData

        public struct AuthFormData: Codable {
            public let authLoginCustomMessage: String?
            public let authOpenIDButtonText: String?
            public let authOpenIDAutoLaunch: Bool?
        }
    }
}
