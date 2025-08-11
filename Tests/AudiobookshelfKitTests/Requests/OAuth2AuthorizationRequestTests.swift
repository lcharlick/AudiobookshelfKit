//
//  OAuth2AuthorizationRequestTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct OAuth2AuthorizationRequestTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.OAuth2AuthorizationRequest(
            codeChallenge: "E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM",
            redirectURI: URL(string: "app://oauth-callback")!,
            clientID: "my-client-id",
            state: "random-state-string"
        )
        .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/auth/openid"))
        #expect(data.headers == [
            "Accept": "*/*",
            "Authorization": "Bearer my-token",
        ])

        #expect(data.queryItems == [
            "code_challenge": "E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM",
            "code_challenge_method": "S256",
            "response_type": "code",
            "redirect_uri": "app://oauth-callback",
            "client_id": "my-client-id",
            "state": "random-state-string",
        ])
    }

    @Test func request_customParameters() throws {
        let request = try Audiobookshelf.Request.OAuth2AuthorizationRequest(
            codeChallenge: "custom-challenge",
            codeChallengeMethod: "plain",
            responseType: "token",
            redirectURI: URL(string: "https://example.com/callback")!,
            clientID: "another-client",
            state: "custom-state"
        )
        .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/auth/openid"))
        #expect(data.headers == [
            "Accept": "*/*",
            "Authorization": "Bearer my-token",
        ])

        #expect(data.queryItems == [
            "code_challenge": "custom-challenge",
            "code_challenge_method": "plain",
            "response_type": "token",
            "redirect_uri": "https://example.com/callback",
            "client_id": "another-client",
            "state": "custom-state",
        ])
    }
}
