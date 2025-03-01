//
//  OAuth2Callback.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 16/12/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This API call finalizes the OAuth2 flow.
    struct OAuth2Callback: ResourceRequest {
        public let path = "auth/openid/callback"

        public var queryItems: [URLQueryItem]? {
            [
                URLQueryItem(name: "state", value: state),
                URLQueryItem(name: "code", value: code),
                URLQueryItem(name: "code_verifier", value: codeVerifier),
            ]
        }

        private let state: String
        private let code: String
        private let codeVerifier: String

        public init(state: String, code: String, codeVerifier: String) {
            self.state = state
            self.code = code
            self.codeVerifier = codeVerifier
        }
    }
}

public extension Audiobookshelf.Request.OAuth2Callback {
    typealias Response = LoginResponse
}
