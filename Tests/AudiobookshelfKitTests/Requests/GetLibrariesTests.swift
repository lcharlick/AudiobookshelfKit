//
//  LibrariesTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import XCTest

class LibrariesTests: BaseTestCase {
    func testRequest() throws {
        let request = try Audiobookshelf.Request.GetLibraries()
            .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("api/libraries"))
        XCTAssertEqual(data.headers, [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
    }

    func testResponse() throws {
        let response = try loadResponse(
            "libraries",
            for: Audiobookshelf.Request.GetLibraries.self
        )

        let libraries = response.libraries
        XCTAssertEqual(libraries.count, 2)
        let mainLibrary = libraries[0]
        XCTAssertEqual(mainLibrary.id, "lib_5yvub9dqvctlcrza6h")
        XCTAssertEqual(mainLibrary.name, "Main")
        XCTAssertEqual(mainLibrary.folders.count, 1)
        let audiobooksFolder = mainLibrary.folders[0]
        XCTAssertEqual(audiobooksFolder.id, "audiobooks")
        XCTAssertEqual(audiobooksFolder.fullPath, "/audiobooks")
        XCTAssertEqual(audiobooksFolder.libraryId, "main")
        XCTAssertEqual(audiobooksFolder.addedAt, Date(timeIntervalSince1970: 1_633_522_963_509 / 1000))
        XCTAssertEqual(mainLibrary.displayOrder, 1)
        XCTAssertEqual(mainLibrary.icon, "audiobookshelf")
        XCTAssertEqual(mainLibrary.mediaType, .book)
        XCTAssertEqual(mainLibrary.provider, "audible")
        XCTAssertEqual(mainLibrary.settings.coverAspectRatio, 1)
        XCTAssertEqual(mainLibrary.settings.disableWatcher, false)
        XCTAssertEqual(mainLibrary.settings.skipMatchingMediaWithAsin, false)
        XCTAssertEqual(mainLibrary.settings.skipMatchingMediaWithIsbn, false)
        XCTAssertEqual(mainLibrary.settings.autoScanCronExpression, nil)
        XCTAssertEqual(mainLibrary.createdAt, Date(timeIntervalSince1970: 1_633_522_963_509 / 1000))
        XCTAssertEqual(mainLibrary.lastUpdate, Date(timeIntervalSince1970: 1_646_520_916_818 / 1000))

        let podcastsLibrary = libraries[1]
        XCTAssertEqual(podcastsLibrary.id, "lib_c1u6t4p45c35rf0nzd")
        XCTAssertEqual(podcastsLibrary.name, "Podcasts")
        XCTAssertEqual(podcastsLibrary.folders.count, 1)
        let podcastsFolder = podcastsLibrary.folders[0]
        XCTAssertEqual(podcastsFolder.id, "fol_bev1zuxhb0j0s1wehr")
        XCTAssertEqual(podcastsFolder.fullPath, "/podcasts")
        XCTAssertEqual(podcastsFolder.libraryId, "lib_c1u6t4p45c35rf0nzd")
        XCTAssertEqual(podcastsFolder.addedAt, Date(timeIntervalSince1970: 1_650_462_940_610 / 1000))
        XCTAssertEqual(podcastsLibrary.displayOrder, 4)
        XCTAssertEqual(podcastsLibrary.icon, "database")
        XCTAssertEqual(podcastsLibrary.mediaType, .podcast)
        XCTAssertEqual(podcastsLibrary.provider, "itunes")
        XCTAssertEqual(podcastsLibrary.settings.coverAspectRatio, 1)
        XCTAssertEqual(podcastsLibrary.settings.disableWatcher, false)
        XCTAssertEqual(podcastsLibrary.settings.skipMatchingMediaWithAsin, false)
        XCTAssertEqual(podcastsLibrary.settings.skipMatchingMediaWithIsbn, false)
        XCTAssertEqual(podcastsLibrary.settings.autoScanCronExpression, nil)
        XCTAssertEqual(podcastsLibrary.createdAt, Date(timeIntervalSince1970: 1_650_462_940_610 / 1000))
        XCTAssertEqual(podcastsLibrary.lastUpdate, Date(timeIntervalSince1970: 1_650_462_940_610 / 1000))
    }
}
