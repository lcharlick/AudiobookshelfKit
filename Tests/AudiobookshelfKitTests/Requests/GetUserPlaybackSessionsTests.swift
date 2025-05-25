//
//  GetUserSessionsTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 18/4/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetUserSessionsTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetUserPlaybackSessions(userId: "user123")
            .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("api/users/user123/listening-sessions"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
        #expect(data.queryItems == [:])
    }
    
    @Test func request_withPaging() throws {
        let request = try Audiobookshelf.Request.GetUserPlaybackSessions(userId: "user123", page: 2, itemsPerPage: 10)
            .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("api/users/user123/listening-sessions"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
        #expect(data.queryItems == [
            "page": "2",
            "itemsPerPage": "10"
        ])
    }
    
    @Test func response() throws {
        let data = """
        {
            "sessions": [
                {
                    "id": "123e4567-e89b-12d3-a456-426614174000",
                    "userId": "user123",
                    "libraryId": "lib456",
                    "libraryItemId": "lib123",
                    "episodeId": null,
                    "mediaType": "book",
                    "mediaMetadata": {
                        "title": "Test Book",
                        "titleIgnorePrefix": null,
                        "subtitle": null,
                        "authorName": "Test Author",
                        "authorNameLF": "Author, Test",
                        "narratorName": "Test Narrator",
                        "seriesName": null,
                        "genres": [],
                        "publishedYear": null,
                        "publishedDate": null,
                        "publisher": null,
                        "description": null,
                        "isbn": null,
                        "asin": null,
                        "language": null,
                        "explicit": false,
                        "abridged": false
                    },
                    "chapters": [],
                    "displayTitle": "Test Book",
                    "displayAuthor": "Test Author",
                    "coverPath": "/covers/lib123.jpg",
                    "duration": 3600,
                    "playMethod": 0,
                    "mediaPlayer": "iOS",
                    "deviceInfo": {
                        "id": "dev123",
                        "userId": "user123",
                        "deviceId": "device123",
                        "ipAddress": "192.168.1.1",
                        "browserName": null,
                        "browserVersion": null,
                        "osName": "iOS",
                        "osVersion": "17.0",
                        "deviceName": "iPhone",
                        "deviceType": "mobile",
                        "manufacturer": "Apple",
                        "model": "iPhone",
                        "sdkVersion": null,
                        "clientName": "Test Client",
                        "clientVersion": "1.0.0"
                    },
                    "serverVersion": "2.5.0",
                    "date": "2024-03-19",
                    "dayOfWeek": "Tuesday",
                    "timeListening": 300,
                    "startTime": 0,
                    "currentTime": 300,
                    "startedAt": 1710864000000,
                    "updatedAt": 1710864300000
                }
            ],
            "total": 1,
            "numPages": 1,
            "itemsPerPage": 10
        }
        """.data(using: .utf8)!

        let response = try Audiobookshelf.Request.GetUserPlaybackSessions.response(from: data)
        
        #expect(response.sessions.count == 1)
        #expect(response.total == 1)
        #expect(response.numPages == 1)
        #expect(response.itemsPerPage == 10)
        
        let session = response.sessions[0]
        #expect(session.id == "123e4567-e89b-12d3-a456-426614174000")
        #expect(session.libraryItemId == "lib123")
        #expect(session.episodeId == nil)
        #expect(session.displayTitle == "Test Book")
        #expect(session.displayAuthor == "Test Author")
        #expect(session.deviceInfo.deviceId == "device123")
        #expect(session.deviceInfo.manufacturer == "Apple")
        #expect(session.deviceInfo.model == "iPhone")
        #expect(session.deviceInfo.sdkVersion == nil)
        #expect(session.deviceInfo.clientName == "Test Client")
        #expect(session.deviceInfo.clientVersion == "1.0.0")
        #expect(session.startTime == 0)
        #expect(session.timeListening == 300)
        #expect(session.currentTime == 300)
        #expect(session.startedAt.timeIntervalSince1970 == 1710864000)
        #expect(session.updatedAt.timeIntervalSince1970 == 1710864300)
    }
} 