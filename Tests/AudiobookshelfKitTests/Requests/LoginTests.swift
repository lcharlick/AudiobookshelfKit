//
//  LoginTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import XCTest
import AudiobookshelfKit

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
            "Accept": "application/json"
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

        XCTAssertEqual(response.user.id, "root")
        XCTAssertEqual(response.user.username, "root")
        XCTAssertEqual(response.user.type, .root)
        XCTAssertEqual(response.user.token, "exJhbGciOiJI6IkpXVCJ9.eyJ1c2Vyi5NDEyODc4fQ.ZraBFohS4Tg39NszY")
        let mediaProgress = response.user.mediaProgress[0]
        XCTAssertEqual(response.user.mediaProgress.count, 1)
        XCTAssertEqual(mediaProgress.id, "li_bufnnmp4y5o2gbbxfm-ep_lh6ko39pumnrma3dhv")
        XCTAssertEqual(mediaProgress.libraryItemId, "li_bufnnmp4y5o2gbbxfm")
        XCTAssertEqual(mediaProgress.episodeId, "ep_lh6ko39pumnrma3dhv")
        XCTAssertEqual(mediaProgress.duration, 1454.18449)
        XCTAssertEqual(mediaProgress.progress, 0.434998929881311)
        XCTAssertEqual(mediaProgress.currentTime, 632.568697)
        XCTAssertEqual(mediaProgress.isFinished, false)
        XCTAssertEqual(mediaProgress.hideFromContinueListening, false)
        XCTAssertEqual(mediaProgress.lastUpdate, Date(timeIntervalSince1970: 1668586015691.0 / 1000))
        XCTAssertEqual(mediaProgress.startedAt, Date(timeIntervalSince1970: 1668120083771.0 / 1000))
        XCTAssertEqual(mediaProgress.finishedAt, nil)
        XCTAssertEqual(response.user.seriesHideFromContinueListening.count, 0)
        XCTAssertEqual(response.user.bookmarks.count, 0)
        XCTAssertEqual(response.user.isActive, true)
        XCTAssertEqual(response.user.isLocked, false)
        XCTAssertEqual(response.user.lastSeen, Date(timeIntervalSince1970: 1669010786013 / 1000))
        XCTAssertEqual(response.user.createdAt, Date(timeIntervalSince1970: 1666543632566 / 1000))
        XCTAssertEqual(response.user.permissions.download, true)
        XCTAssertEqual(response.user.permissions.update, true)
        XCTAssertEqual(response.user.permissions.delete, true)
        XCTAssertEqual(response.user.permissions.upload, true)
        XCTAssertEqual(response.user.permissions.accessAllLibraries, true)
        XCTAssertEqual(response.user.permissions.accessAllTags, true)
        XCTAssertEqual(response.user.permissions.accessExplicitContent, true)
        XCTAssertEqual(response.user.librariesAccessible.count, 0)
        XCTAssertEqual(response.user.itemTagsAccessible.count, 0)
        XCTAssertEqual(response.userDefaultLibraryId, "lib_c1u6t4p45c35rf0nzd")
        XCTAssertEqual(response.serverSettings.id, "server-settings")
        XCTAssertEqual(response.serverSettings.scannerFindCovers, false)
        XCTAssertEqual(response.serverSettings.scannerCoverProvider, "audible")
        XCTAssertEqual(response.serverSettings.scannerParseSubtitle, false)
        XCTAssertEqual(response.serverSettings.scannerPreferAudioMetadata, false)
        XCTAssertEqual(response.serverSettings.scannerPreferOpfMetadata, false)
        XCTAssertEqual(response.serverSettings.scannerPreferMatchedMetadata, false)
        XCTAssertEqual(response.serverSettings.scannerDisableWatcher, true)
        XCTAssertEqual(response.serverSettings.scannerPreferOverdriveMediaMarker, false)
        XCTAssertEqual(response.serverSettings.scannerUseSingleThreadedProber, true)
        XCTAssertEqual(response.serverSettings.scannerMaxThreads, 0)
        XCTAssertEqual(response.serverSettings.scannerUseTone, false)
        XCTAssertEqual(response.serverSettings.storeCoverWithItem, false)
        XCTAssertEqual(response.serverSettings.storeMetadataWithItem, false)
        XCTAssertEqual(response.serverSettings.metadataFileFormat, .json)
        XCTAssertEqual(response.serverSettings.rateLimitLoginRequests, 10)
        XCTAssertEqual(response.serverSettings.rateLimitLoginWindow, 600000)
        XCTAssertEqual(response.serverSettings.backupSchedule, "30 1 * * *")
        XCTAssertEqual(response.serverSettings.backupsToKeep, 2)
        XCTAssertEqual(response.serverSettings.maxBackupSize, 1)
        XCTAssertEqual(response.serverSettings.backupMetadataCovers, true)
        XCTAssertEqual(response.serverSettings.loggerDailyLogsToKeep, 7)
        XCTAssertEqual(response.serverSettings.loggerScannerLogsToKeep, 2)
        XCTAssertEqual(response.serverSettings.homeBookshelfView, 1)
        XCTAssertEqual(response.serverSettings.bookshelfView, 1)
        XCTAssertEqual(response.serverSettings.sortingIgnorePrefix, false)
        XCTAssertEqual(response.serverSettings.sortingPrefixes, ["the", "a"])
        XCTAssertEqual(response.serverSettings.chromecastEnabled, false)
        XCTAssertEqual(response.serverSettings.dateFormat, "MM/dd/yyyy")
        XCTAssertEqual(response.serverSettings.language, "en-us")
        XCTAssertEqual(response.serverSettings.logLevel, 2)
        XCTAssertEqual(response.serverSettings.version, "2.2.5")
        XCTAssertEqual(response.source, "docker")
    }
}
