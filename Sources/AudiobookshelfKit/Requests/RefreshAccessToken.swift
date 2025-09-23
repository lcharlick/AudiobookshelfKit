//
//  RefreshAccessToken.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 9/9/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint refreshes an access token using a refresh token.
    struct RefreshAccessToken: ResourceRequest {
        public let path = "auth/refresh"
        public let httpMethod = "POST"
        public var headers: [String : String]? {
            ["x-refresh-token": refreshToken]
        }
        
        private let refreshToken: String
        
        public init(refreshToken: String) {
            self.refreshToken = refreshToken
        }
    }
}

public extension Audiobookshelf.Request.RefreshAccessToken {
    typealias Response = LoginResponse
}