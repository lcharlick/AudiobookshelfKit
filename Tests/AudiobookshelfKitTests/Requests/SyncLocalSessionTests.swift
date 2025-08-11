//
//  SyncLocalSessionTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct SyncLocalSessionTests {
    @Test func request_singleSession() throws {
        let deviceInfo = DeviceInfo(
            deviceId: "device123",
            manufacturer: "Apple",
            model: "iPhone",
            sdkVersion: 17,
            clientName: "AudiobookshelfKit",
            clientVersion: "1.0.0"
        )

        let session = Audiobookshelf.Request.SyncLocalSession.Session(
            id: "play_session_1",
            libraryItemId: "li_8gch9ve09orgn4fdz8",
            episodeId: nil,
            displayTitle: "Wizards First Rule",
            displayAuthor: "Terry Goodkind",
            deviceInfo: deviceInfo,
            playMethod: .directPlay,
            startTime: 0,
            timeListening: 300,
            currentTime: 300,
            startedAt: Date(timeIntervalSince1970: 1_650_621_073_750 / 1000),
            updatedAt: Date(timeIntervalSince1970: 1_650_621_373_750 / 1000)
        )

        let request = try Audiobookshelf.Request.SyncLocalSession(session)
            .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/session/local-all"))
        #expect(data.httpMethod == "POST")
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
            "Content-Type": "application/json",
        ])

        let body = try JSONDecoder().decode(
            Audiobookshelf.Request.SyncLocalSession.RequestBody.self,
            from: data.rawHttpBody!
        )
        #expect(body.sessions.count == 1)
        #expect(body.sessions[0].id == "play_session_1")
        #expect(body.sessions[0].libraryItemId == "li_8gch9ve09orgn4fdz8")
        #expect(body.deviceInfo?.deviceId == "device123")
    }

    @Test func request_multipleSessions() throws {
        let deviceInfo = DeviceInfo(
            deviceId: "device123",
            manufacturer: "Apple",
            model: "iPhone",
            sdkVersion: 17,
            clientName: "AudiobookshelfKit",
            clientVersion: "1.0.0"
        )

        let sessions = [
            Audiobookshelf.Request.SyncLocalSession.Session(
                id: "play_session_1",
                libraryItemId: "li_8gch9ve09orgn4fdz8",
                episodeId: nil,
                displayTitle: "Wizards First Rule",
                displayAuthor: "Terry Goodkind",
                deviceInfo: deviceInfo,
                playMethod: .directPlay,
                startTime: 0,
                timeListening: 300,
                currentTime: 300,
                startedAt: Date(timeIntervalSince1970: 1_650_621_073_750 / 1000),
                updatedAt: Date(timeIntervalSince1970: 1_650_621_373_750 / 1000)
            ),
            Audiobookshelf.Request.SyncLocalSession.Session(
                id: "play_session_2",
                libraryItemId: "li_another_item",
                episodeId: "ep_123",
                displayTitle: "Podcast Episode",
                displayAuthor: "Podcast Author",
                deviceInfo: deviceInfo,
                playMethod: .transcode,
                startTime: 100,
                timeListening: 200,
                currentTime: 300,
                startedAt: Date(timeIntervalSince1970: 1_650_621_173_750 / 1000),
                updatedAt: Date(timeIntervalSince1970: 1_650_621_473_750 / 1000)
            ),
        ]

        let request = try Audiobookshelf.Request.SyncLocalSession(sessions)
            .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        let body = try JSONDecoder().decode(
            Audiobookshelf.Request.SyncLocalSession.RequestBody.self,
            from: data.rawHttpBody!
        )
        #expect(body.sessions.count == 2)
        #expect(body.sessions[0].id == "play_session_1")
        #expect(body.sessions[1].id == "play_session_2")
        #expect(body.sessions[1].episodeId == "ep_123")
    }

    @Test func response() throws {
        let response = try loadResponse(
            "sync_local_session",
            for: Audiobookshelf.Request.SyncLocalSession.self
        )

        #expect(response.results.count == 2)

        let result1 = response.results[0]
        #expect(result1.id == "play_session_1")
        #expect(result1.success == true)
        #expect(result1.error == nil)
        #expect(result1.progressSynced == true)

        let result2 = response.results[1]
        #expect(result2.id == "play_session_2")
        #expect(result2.success == false)
        #expect(result2.error == "Session not found")
        #expect(result2.progressSynced == nil)
    }
}
