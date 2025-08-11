//
//  GetMediaProgressTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetMediaProgressTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetMediaProgress(
            libraryItemID: "27bec22a-0902-4226-a6ba-677a95fd993d"
        )
        .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/me/progress/27bec22a-0902-4226-a6ba-677a95fd993d"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])

        #expect(data.queryItems.isEmpty)
    }

    @Test func response() throws {
        let response = try loadResponse(
            "media_progress",
            for: Audiobookshelf.Request.GetMediaProgress.self
        )

        #expect(response.id == "8e7ed07e-19b4-4ccf-9668-03a7ed20f1dd")
        #expect(response.userId == "a7ea108d-ed8c-4179-bedd-07cf4db866aa")
        #expect(response.libraryItemId == "27bec22a-0902-4226-a6ba-677a95fd993d")
        #expect(response.episodeId == nil)
        #expect(response.mediaItemId == "66d835f9-5899-41e2-8184-2b235f6ad998")
        #expect(response.mediaItemType == .book)
        #expect(response.duration == 102_531.286)
        #expect(response.progress == 0.00006908974757226784)
        #expect(response.currentTime == 7.083860668)
        #expect(response.isFinished == false)
        #expect(response.hideFromContinueListening == false)
        #expect(response.lastUpdate == Date(timeIntervalSince1970: 1_660_451_502_259 / 1000))
        #expect(response.startedAt == Date(timeIntervalSince1970: 1_660_451_494_311 / 1000))
        #expect(response.finishedAt == nil)
    }
}
