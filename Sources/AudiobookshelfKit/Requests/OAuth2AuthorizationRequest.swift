//
//  OAuth2AuthorizationRequest.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 16/12/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint starts a standard OAuth2 flow with PKCE (required - S256; see RFC7636), to log the user in using SSO.
    struct OAuth2AuthorizationRequest: ResourceRequest {
        public let path = "auth/openid"
        public let accept = "*/*"

        public var queryItems: [URLQueryItem]? {
            [
                URLQueryItem(name: "code_challenge", value: codeChallenge),
                URLQueryItem(name: "code_challenge_method", value: codeChallengeMethod),
                URLQueryItem(name: "response_type", value: responseType),
                URLQueryItem(name: "redirect_uri", value: redirectURI.absoluteString),
                URLQueryItem(name: "client_id", value: clientID),
                URLQueryItem(name: "state", value: state),
            ]
        }

        private let codeChallenge: String
        private let codeChallengeMethod: String
        private let responseType: String
        private let redirectURI: URL
        private let clientID: String
        private let state: String

        public init(
            codeChallenge: String,
            codeChallengeMethod: String = "S256",
            responseType: String = "code",
            redirectURI: URL,
            clientID: String,
            state: String
        ) {
            self.codeChallenge = codeChallenge
            self.codeChallengeMethod = codeChallengeMethod
            self.responseType = responseType
            self.redirectURI = redirectURI
            self.clientID = clientID
            self.state = state
        }
    }
}

public extension Audiobookshelf.Request.OAuth2AuthorizationRequest {
    typealias Response = Data

    static func response(from data: Data) throws -> Data {
        data
    }
}
