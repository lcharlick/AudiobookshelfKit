//
//  GetUserSessionsTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 18/4/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import XCTest

class GetUserSessionsTests: BaseTestCase {
    func testRequest() throws {
        let request = try Audiobookshelf.Request.GetUserPlaybackSessions(userId: "user123")
            .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("api/users/user123/listening-sessions"))
        XCTAssertEqual(data.headers, [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
        XCTAssertEqual(data.queryItems, [:])
    }
    
    func testRequest_withPaging() throws {
        let request = try Audiobookshelf.Request.GetUserPlaybackSessions(userId: "user123", page: 2, itemsPerPage: 10)
            .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("api/users/user123/listening-sessions"))
        XCTAssertEqual(data.headers, [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
        XCTAssertEqual(data.queryItems, [
            "page": "2",
            "itemsPerPage": "10"
        ])
    }
    
    func testResponse() throws {
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
        
        XCTAssertEqual(response.sessions.count, 1)
        XCTAssertEqual(response.total, 1)
        XCTAssertEqual(response.numPages, 1)
        XCTAssertEqual(response.itemsPerPage, 10)
        
        let session = response.sessions[0]
        XCTAssertEqual(session.id, "123e4567-e89b-12d3-a456-426614174000")
        XCTAssertEqual(session.libraryItemId, "lib123")
        XCTAssertNil(session.episodeId)
        XCTAssertEqual(session.displayTitle, "Test Book")
        XCTAssertEqual(session.displayAuthor, "Test Author")
        XCTAssertEqual(session.deviceInfo.deviceId, "device123")
        XCTAssertEqual(session.deviceInfo.manufacturer, "Apple")
        XCTAssertEqual(session.deviceInfo.model, "iPhone")
        XCTAssertNil(session.deviceInfo.sdkVersion)
        XCTAssertEqual(session.deviceInfo.clientName, "Test Client")
        XCTAssertEqual(session.deviceInfo.clientVersion, "1.0.0")
        XCTAssertEqual(session.startTime, 0)
        XCTAssertEqual(session.timeListening, 300)
        XCTAssertEqual(session.currentTime, 300)
        XCTAssertEqual(session.startedAt.timeIntervalSince1970, 1710864000)
        XCTAssertEqual(session.updatedAt.timeIntervalSince1970, 1710864300)
    }
} 