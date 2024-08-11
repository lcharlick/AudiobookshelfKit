//
//  LoginTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

@testable import AudiobookshelfKit
import XCTest

class LoginTests: BaseTestCase {
    func testRequest() throws {
        let request = try Audiobookshelf.Request.Login(username: "juno", password: "w00f")
            .asURLRequest(from: testURL, using: nil)

        let data = RequestData(request: request)

        XCTAssertEqual(
            data.baseURL,
            testURL.appendingPathComponent("login")
        )

        XCTAssertEqual(data.headers, [
            "Accept": "application/json",
            "Content-Type": "application/json",
        ])

        XCTAssertEqual(data.httpBody, [
            "username": "juno",
            "password": "w00f",
        ])
    }

    func testResponse() throws {
        let response = try loadResponse(
            "login",
            for: Audiobookshelf.Request.Login.self
        )

        XCTAssertEqual(response.user.id, "a7ea108d-ed8c-4179-bedd-07cf4db866aa")
        XCTAssertEqual(response.user.oldUserId, "root")
        XCTAssertEqual(response.user.username, "root")
        XCTAssertEqual(response.user.email, nil)
        XCTAssertEqual(response.user.type, .root)
        XCTAssertEqual(response.user.token, "my-token")
        XCTAssertEqual(response.user.mediaProgress.count, 2)
        let mediaProgress = response.user.mediaProgress[0]
        XCTAssertEqual(mediaProgress.id, "8e7ed07e-19b4-4ccf-9668-03a7ed20f1dd")
        XCTAssertEqual(mediaProgress.userId, "a7ea108d-ed8c-4179-bedd-07cf4db866aa")
        XCTAssertEqual(mediaProgress.libraryItemId, "27bec22a-0902-4226-a6ba-677a95fd993d")
        XCTAssertEqual(mediaProgress.episodeId, nil)
        XCTAssertEqual(mediaProgress.mediaItemId, "66d835f9-5899-41e2-8184-2b235f6ad998")
        XCTAssertEqual(mediaProgress.mediaItemType, .book)
        XCTAssertEqual(mediaProgress.duration, 102_531.286)
        XCTAssertEqual(mediaProgress.progress, 6.908974757226784e-05)
        XCTAssertEqual(mediaProgress.currentTime, 7.083860668)
        XCTAssertEqual(mediaProgress.isFinished, false)
        XCTAssertEqual(mediaProgress.hideFromContinueListening, false)
        // XCTAssertEqual(mediaProgress.ebookLocation, nil)
        // XCTAssertEqual(mediaProgress.ebookProgress, nil)
        XCTAssertEqual(mediaProgress.lastUpdate, Date(timeIntervalSince1970: 1_660_451_502_259 / 1000))
        XCTAssertEqual(mediaProgress.startedAt, Date(timeIntervalSince1970: 1_660_451_494_311 / 1000))
        XCTAssertEqual(mediaProgress.finishedAt, nil)
        XCTAssertEqual(response.user.seriesHideFromContinueListening.count, 0)
        XCTAssertEqual(response.user.bookmarks.count, 1)

        let bookmark = response.user.bookmarks[0]
        XCTAssertEqual(bookmark.libraryItemId, "8f2b0e4b-d484-47b8-b357-fbdcbc4e6458")
        XCTAssertEqual(bookmark.title, "1234")
        XCTAssertEqual(bookmark.time, 6446)
        XCTAssertEqual(bookmark.createdAt, Date(timeIntervalSince1970: 1_723_386_963_225 / 1000))

        XCTAssertEqual(response.user.isActive, true)
        XCTAssertEqual(response.user.isLocked, false)
        XCTAssertEqual(response.user.lastSeen, Date(timeIntervalSince1970: 1_712_674_531_253 / 1000))
        XCTAssertEqual(response.user.createdAt, Date(timeIntervalSince1970: 1_650_709_131_028 / 1000))
        XCTAssertEqual(response.user.permissions.download, true)
        XCTAssertEqual(response.user.permissions.update, true)
        XCTAssertEqual(response.user.permissions.delete, true)
        XCTAssertEqual(response.user.permissions.upload, true)
        XCTAssertEqual(response.user.permissions.accessAllLibraries, true)
        XCTAssertEqual(response.user.permissions.accessAllTags, true)
        XCTAssertEqual(response.user.permissions.accessExplicitContent, true)
        XCTAssertEqual(response.user.librariesAccessible.count, 0)
        // XCTAssertEqual(response.user.itemTagsSelected.count, 0)
        // XCTAssertEqual(response.user.hasOpenIDLink, false)
        XCTAssertEqual(response.userDefaultLibraryId, "5d8f9658-d52a-44f7-b52a-f7f02480f117")
        XCTAssertEqual(response.serverSettings.id, "server-settings")
        XCTAssertEqual(response.serverSettings.scannerFindCovers, false)
        XCTAssertEqual(response.serverSettings.scannerCoverProvider, "google")
        XCTAssertEqual(response.serverSettings.scannerParseSubtitle, true)
        XCTAssertEqual(response.serverSettings.scannerPreferMatchedMetadata, false)
        XCTAssertEqual(response.serverSettings.scannerDisableWatcher, false)
        XCTAssertEqual(response.serverSettings.storeCoverWithItem, false)
        XCTAssertEqual(response.serverSettings.storeMetadataWithItem, false)
        XCTAssertEqual(response.serverSettings.metadataFileFormat, .json)
        XCTAssertEqual(response.serverSettings.rateLimitLoginRequests, 10)
        XCTAssertEqual(response.serverSettings.rateLimitLoginWindow, 600_000)
        // XCTAssertEqual(response.serverSettings.backupSchedule, false)
        XCTAssertEqual(response.serverSettings.backupsToKeep, 2)
        XCTAssertEqual(response.serverSettings.maxBackupSize, 1)
        XCTAssertEqual(response.serverSettings.loggerDailyLogsToKeep, 7)
        XCTAssertEqual(response.serverSettings.loggerScannerLogsToKeep, 2)
        XCTAssertEqual(response.serverSettings.homeBookshelfView, 0)
        XCTAssertEqual(response.serverSettings.bookshelfView, 0)
        // XCTAssertEqual(response.serverSettings.podcastEpisodeSchedule, "0 * * * *")
        XCTAssertEqual(response.serverSettings.sortingIgnorePrefix, false)
        XCTAssertEqual(response.serverSettings.sortingPrefixes, ["the", "a"])
        XCTAssertEqual(response.serverSettings.chromecastEnabled, false)
        XCTAssertEqual(response.serverSettings.dateFormat, "MM/dd/yyyy")
        XCTAssertEqual(response.serverSettings.timeFormat, "HH:mm")
        XCTAssertEqual(response.serverSettings.language, "en-us")
        XCTAssertEqual(response.serverSettings.logLevel, 2)
        XCTAssertEqual(response.serverSettings.version, "2.8.1")
        // XCTAssertEqual(response.serverSettings.buildNumber, 1)
        // XCTAssertEqual(response.serverSettings.authLoginCustomMessage, nil)
        // XCTAssertEqual(response.serverSettings.authActiveAuthMethods, ["local"])
        // XCTAssertEqual(response.serverSettings.authOpenIDIssuerURL, nil)
        // XCTAssertEqual(response.serverSettings.authOpenIDAuthorizationURL, nil)
        // XCTAssertEqual(response.serverSettings.authOpenIDTokenURL, nil)
        // XCTAssertEqual(response.serverSettings.authOpenIDUserInfoURL, nil)
        // XCTAssertEqual(response.serverSettings.authOpenIDJwksURL, nil)
        // XCTAssertEqual(response.serverSettings.authOpenIDLogoutURL, nil)
        // XCTAssertEqual(response.serverSettings.authOpenIDButtonText, "Login with OpenId")
        // XCTAssertEqual(response.serverSettings.authOpenIDAutoLaunch, false)
        // XCTAssertEqual(response.serverSettings.authOpenIDAutoRegister, false)
        // XCTAssertEqual(response.serverSettings.authOpenIDMatchExistingBy, nil)
        // XCTAssertEqual(response.ereaderDevices.count, 0)
        XCTAssertEqual(response.source, "docker")
    }
}
