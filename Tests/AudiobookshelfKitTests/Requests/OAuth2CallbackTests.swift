//
//  OAuth2CallbackTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct OAuth2CallbackTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.OAuth2Callback(
            state: "random-state-string",
            code: "authorization-code-from-provider",
            codeVerifier: "dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk"
        )
        .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/auth/openid/callback"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])

        #expect(data.queryItems == [
            "state": "random-state-string",
            "code": "authorization-code-from-provider",
            "code_verifier": "dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk",
        ])
    }

    @Test func response() throws {
        // OAuth2Callback returns the same response as Login
        let response = try loadResponse(
            "login",
            for: Audiobookshelf.Request.OAuth2Callback.self
        )

        #expect(response.user.id == "a7ea108d-ed8c-4179-bedd-07cf4db866aa")
        #expect(response.user.username == "root")
        #expect(response.user.type == .root)
        #expect(response.user.token == "my-token")
        #expect(response.userDefaultLibraryId == "5d8f9658-d52a-44f7-b52a-f7f02480f117")
        #expect(response.serverSettings.id == "server-settings")
        #expect(response.source == "docker")
    }
}
