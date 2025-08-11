//
//  BatchUpdateMediaProgressTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 3/8/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct BatchUpdateMediaProgressTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.BatchUpdateMediaProgress([])
            .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("api/me/progress/batch/update"))
        #expect(data.httpMethod == "PATCH")
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
            "Content-Type": "application/json",
        ])

        let httpBody = try JSONDecoder().decode([Audiobookshelf.Request.BatchUpdateMediaProgress.Parameters].self, from: data.rawHttpBody!)

        #expect(httpBody == [])
    }

    @Test func requestWithParameters() throws {
        let parameters = Audiobookshelf.Request.BatchUpdateMediaProgress.Parameters(
            libraryItemId: "123",
            episodeId: "456",
            duration: 123,
            progress: 0.5,
            currentTime: 60,
            isFinished: false,
            hideFromContinueListening: false,
            finishedAt: Date(),
            startedAt: Date()
        )
        let request = try Audiobookshelf.Request.BatchUpdateMediaProgress([parameters])
            .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("api/me/progress/batch/update"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
            "Content-Type": "application/json",
        ])
    }
}
