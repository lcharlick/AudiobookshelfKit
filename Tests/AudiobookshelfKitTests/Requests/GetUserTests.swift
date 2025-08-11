//
//  GetUserTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetUserTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetUser()
            .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/me"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])

        #expect(data.queryItems.isEmpty)
    }

    @Test func response() throws {
        let response = try loadResponse(
            "user",
            for: Audiobookshelf.Request.GetUser.self
        )

        #expect(response.id == "a7ea108d-ed8c-4179-bedd-07cf4db866aa")
        #expect(response.oldUserId == "root")
        #expect(response.username == "root")
        #expect(response.email == nil)
        #expect(response.type == .root)
        #expect(response.token == "my-token")
        #expect(response.isActive == true)
        #expect(response.isLocked == false)
        #expect(response.lastSeen == Date(timeIntervalSince1970: 1_712_674_531_253 / 1000))
        #expect(response.createdAt == Date(timeIntervalSince1970: 1_650_709_131_028 / 1000))
        // hasOpenIDLink field not present in User model

        // Check permissions
        #expect(response.permissions.download == true)
        #expect(response.permissions.update == true)
        #expect(response.permissions.delete == true)
        #expect(response.permissions.upload == true)
        #expect(response.permissions.accessAllLibraries == true)
        #expect(response.permissions.accessAllTags == true)
        #expect(response.permissions.accessExplicitContent == true)

        // Check media progress
        #expect(response.mediaProgress.count == 1)
        let mediaProgress = response.mediaProgress[0]
        #expect(mediaProgress.id == "8e7ed07e-19b4-4ccf-9668-03a7ed20f1dd")
        #expect(mediaProgress.libraryItemId == "27bec22a-0902-4226-a6ba-677a95fd993d")
        #expect(mediaProgress.isFinished == false)

        // Check bookmarks
        #expect(response.bookmarks.count == 1)
        let bookmark = response.bookmarks[0]
        #expect(bookmark.libraryItemId == "8f2b0e4b-d484-47b8-b357-fbdcbc4e6458")
        #expect(bookmark.title == "1234")
        #expect(bookmark.time == 6446)
        #expect(bookmark.createdAt == Date(timeIntervalSince1970: 1_723_386_963_225 / 1000))

        // Check arrays
        #expect(response.seriesHideFromContinueListening.count == 0)
        #expect(response.librariesAccessible.count == 0)
    }
}
