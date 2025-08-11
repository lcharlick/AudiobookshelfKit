//
//  StatusTests.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 15/12/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct StatusTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.Status()
            .asURLRequest(from: testURL, using: nil, customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("status"))
        #expect(data.headers == [
            "Accept": "application/json",
        ])
    }

    @Test func response() throws {
        let data = """
        {
          "app": "audiobookshelf",
          "serverVersion": "2.17.3",
          "isInit": true,
          "language": "en-us",
          "authMethods": [
            "local",
            "openid",
            "woof"
          ],
          "authFormData": {
            "authLoginCustomMessage": "A custom message",
            "authOpenIDButtonText": "Login with OpenId",
            "authOpenIDAutoLaunch": false
          }
        }
        """.data(using: .utf8)

        let response = try Audiobookshelf.Request.Status.response(from: data!)

        #expect(response.app == "audiobookshelf")
        #expect(response.serverVersion == "2.17.3")
        #expect(response.isInit)
        #expect(response.language == "en-us")
        #expect(response.authMethods == [.local, .openid, .unknown("woof")])
        #expect(response.authFormData.authLoginCustomMessage == "A custom message")
        #expect(response.authFormData.authOpenIDButtonText == "Login with OpenId")
    }
}
