//
//  GetLibrariesTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetLibrariesTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetLibraries()
            .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("api/libraries"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
    }

    @Test func response() throws {
        let response = try loadResponse(
            "libraries",
            for: Audiobookshelf.Request.GetLibraries.self
        )

        let libraries = response.libraries
        #expect(libraries.count == 2)
        let mainLibrary = libraries[0]
        #expect(mainLibrary.id == "lib_5yvub9dqvctlcrza6h")
        #expect(mainLibrary.name == "Main")
        #expect(mainLibrary.folders.count == 1)
        let audiobooksFolder = mainLibrary.folders[0]
        #expect(audiobooksFolder.id == "audiobooks")
        #expect(audiobooksFolder.fullPath == "/audiobooks")
        #expect(audiobooksFolder.libraryId == "main")
        #expect(audiobooksFolder.addedAt == Date(timeIntervalSince1970: 1_633_522_963_509 / 1000))
        #expect(mainLibrary.displayOrder == 1)
        #expect(mainLibrary.icon == "audiobookshelf")
        #expect(mainLibrary.mediaType == .book)
        #expect(mainLibrary.provider == "audible")
        #expect(mainLibrary.settings.coverAspectRatio == 1)
        #expect(mainLibrary.settings.disableWatcher == false)
        #expect(mainLibrary.settings.skipMatchingMediaWithAsin == false)
        #expect(mainLibrary.settings.skipMatchingMediaWithIsbn == false)
        #expect(mainLibrary.settings.autoScanCronExpression == nil)
        #expect(mainLibrary.createdAt == Date(timeIntervalSince1970: 1_633_522_963_509 / 1000))
        #expect(mainLibrary.lastUpdate == Date(timeIntervalSince1970: 1_646_520_916_818 / 1000))

        let podcastsLibrary = libraries[1]
        #expect(podcastsLibrary.id == "lib_c1u6t4p45c35rf0nzd")
        #expect(podcastsLibrary.name == "Podcasts")
        #expect(podcastsLibrary.folders.count == 1)
        let podcastsFolder = podcastsLibrary.folders[0]
        #expect(podcastsFolder.id == "fol_bev1zuxhb0j0s1wehr")
        #expect(podcastsFolder.fullPath == "/podcasts")
        #expect(podcastsFolder.libraryId == "lib_c1u6t4p45c35rf0nzd")
        #expect(podcastsFolder.addedAt == Date(timeIntervalSince1970: 1_650_462_940_610 / 1000))
        #expect(podcastsLibrary.displayOrder == 4)
        #expect(podcastsLibrary.icon == "database")
        #expect(podcastsLibrary.mediaType == .podcast)
        #expect(podcastsLibrary.provider == "itunes")
        #expect(podcastsLibrary.settings.coverAspectRatio == 1)
        #expect(podcastsLibrary.settings.disableWatcher == false)
        #expect(podcastsLibrary.settings.skipMatchingMediaWithAsin == false)
        #expect(podcastsLibrary.settings.skipMatchingMediaWithIsbn == false)
        #expect(podcastsLibrary.settings.autoScanCronExpression == nil)
        #expect(podcastsLibrary.createdAt == Date(timeIntervalSince1970: 1_650_462_940_610 / 1000))
        #expect(podcastsLibrary.lastUpdate == Date(timeIntervalSince1970: 1_650_462_940_610 / 1000))
    }
}
