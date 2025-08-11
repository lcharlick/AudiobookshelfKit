//
//  LoginTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

@testable import AudiobookshelfKit
import Foundation
import Testing

struct LoginTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.Login(username: "juno", password: "w00f")
            .asURLRequest(from: testURL, using: nil, customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("login"))

        #expect(data.headers == [
            "Accept": "application/json",
            "Content-Type": "application/json",
        ])

        #expect(data.httpBody == [
            "username": "juno",
            "password": "w00f",
        ])
    }

    @Test func response() throws {
        let response = try loadResponse(
            "login",
            for: Audiobookshelf.Request.Login.self
        )

        #expect(response.user.id == "a7ea108d-ed8c-4179-bedd-07cf4db866aa")
        #expect(response.user.oldUserId == "root")
        #expect(response.user.username == "root")
        #expect(response.user.email == nil)
        #expect(response.user.type == .root)
        #expect(response.user.token == "my-token")
        #expect(response.user.mediaProgress.count == 2)
        let mediaProgress = response.user.mediaProgress[0]
        #expect(mediaProgress.id == "8e7ed07e-19b4-4ccf-9668-03a7ed20f1dd")
        #expect(mediaProgress.userId == "a7ea108d-ed8c-4179-bedd-07cf4db866aa")
        #expect(mediaProgress.libraryItemId == "27bec22a-0902-4226-a6ba-677a95fd993d")
        #expect(mediaProgress.episodeId == nil)
        #expect(mediaProgress.mediaItemId == "66d835f9-5899-41e2-8184-2b235f6ad998")
        #expect(mediaProgress.mediaItemType == .book)
        #expect(mediaProgress.duration == 102_531.286)
        #expect(mediaProgress.progress == 6.908974757226784e-05)
        #expect(mediaProgress.currentTime == 7.083860668)
        #expect(mediaProgress.isFinished == false)
        #expect(mediaProgress.hideFromContinueListening == false)
        // #expect(mediaProgress.ebookLocation == nil)
        // #expect(mediaProgress.ebookProgress == nil)
        #expect(mediaProgress.lastUpdate == Date(timeIntervalSince1970: 1_660_451_502_259 / 1000))
        #expect(mediaProgress.startedAt == Date(timeIntervalSince1970: 1_660_451_494_311 / 1000))
        #expect(mediaProgress.finishedAt == nil)
        #expect(response.user.seriesHideFromContinueListening.count == 0)
        #expect(response.user.bookmarks.count == 1)

        let bookmark = response.user.bookmarks[0]
        #expect(bookmark.libraryItemId == "8f2b0e4b-d484-47b8-b357-fbdcbc4e6458")
        #expect(bookmark.title == "1234")
        #expect(bookmark.time == 6446)
        #expect(bookmark.createdAt == Date(timeIntervalSince1970: 1_723_386_963_225 / 1000))

        #expect(response.user.isActive == true)
        #expect(response.user.isLocked == false)
        #expect(response.user.lastSeen == Date(timeIntervalSince1970: 1_712_674_531_253 / 1000))
        #expect(response.user.createdAt == Date(timeIntervalSince1970: 1_650_709_131_028 / 1000))
        #expect(response.user.permissions.download == true)
        #expect(response.user.permissions.update == true)
        #expect(response.user.permissions.delete == true)
        #expect(response.user.permissions.upload == true)
        #expect(response.user.permissions.accessAllLibraries == true)
        #expect(response.user.permissions.accessAllTags == true)
        #expect(response.user.permissions.accessExplicitContent == true)
        #expect(response.user.librariesAccessible.count == 0)
        // #expect(response.user.itemTagsSelected.count == 0)
        // #expect(response.user.hasOpenIDLink == false)
        #expect(response.userDefaultLibraryId == "5d8f9658-d52a-44f7-b52a-f7f02480f117")
        #expect(response.serverSettings.id == "server-settings")
        #expect(response.serverSettings.scannerFindCovers == false)
        #expect(response.serverSettings.scannerCoverProvider == "google")
        #expect(response.serverSettings.scannerParseSubtitle == true)
        #expect(response.serverSettings.scannerPreferMatchedMetadata == false)
        #expect(response.serverSettings.scannerDisableWatcher == false)
        #expect(response.serverSettings.storeCoverWithItem == false)
        #expect(response.serverSettings.storeMetadataWithItem == false)
        #expect(response.serverSettings.metadataFileFormat == .json)
        #expect(response.serverSettings.rateLimitLoginRequests == 10)
        #expect(response.serverSettings.rateLimitLoginWindow == 600_000)
        // #expect(response.serverSettings.backupSchedule == false)
        #expect(response.serverSettings.backupsToKeep == 2)
        #expect(response.serverSettings.maxBackupSize == 1)
        #expect(response.serverSettings.loggerDailyLogsToKeep == 7)
        #expect(response.serverSettings.loggerScannerLogsToKeep == 2)
        #expect(response.serverSettings.homeBookshelfView == 0)
        #expect(response.serverSettings.bookshelfView == 0)
        // #expect(response.serverSettings.podcastEpisodeSchedule == "0 * * * *")
        #expect(response.serverSettings.sortingIgnorePrefix == false)
        #expect(response.serverSettings.sortingPrefixes == ["the", "a"])
        #expect(response.serverSettings.chromecastEnabled == false)
        #expect(response.serverSettings.dateFormat == "MM/dd/yyyy")
        #expect(response.serverSettings.timeFormat == "HH:mm")
        #expect(response.serverSettings.language == "en-us")
        #expect(response.serverSettings.logLevel == 2)
        #expect(response.serverSettings.version == "2.8.1")
        // #expect(response.serverSettings.buildNumber == 1)
        // #expect(response.serverSettings.authLoginCustomMessage == nil)
        // #expect(response.serverSettings.authActiveAuthMethods == ["local"])
        // #expect(response.serverSettings.authOpenIDIssuerURL == nil)
        // #expect(response.serverSettings.authOpenIDAuthorizationURL == nil)
        // #expect(response.serverSettings.authOpenIDTokenURL == nil)
        // #expect(response.serverSettings.authOpenIDUserInfoURL == nil)
        // #expect(response.serverSettings.authOpenIDJwksURL == nil)
        // #expect(response.serverSettings.authOpenIDLogoutURL == nil)
        // #expect(response.serverSettings.authOpenIDButtonText == "Login with OpenId")
        // #expect(response.serverSettings.authOpenIDAutoLaunch == false)
        // #expect(response.serverSettings.authOpenIDAutoRegister == false)
        // #expect(response.serverSettings.authOpenIDMatchExistingBy == nil)
        // #expect(response.ereaderDevices.count == 0)
        #expect(response.source == "docker")
    }
}
