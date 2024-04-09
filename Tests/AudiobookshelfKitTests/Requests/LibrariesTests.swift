//
//  LibrariesTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import XCTest
import AudiobookshelfKit

class LibrariesTests: BaseTestCase {
    func testRequest() throws {
        let request = try Audiobookshelf.Request.Libraries()
            .asURLRequest(from: testURL, using: "my-token")
        
        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("libraries"))
        XCTAssertEqual(data.headers, [
            "Accept": "application/json",
            "Authorization": "Bearer my-token"
        ])
    }

    func testResponse() throws {
        let response = try loadResponse(
            "libraries",
            for: Audiobookshelf.Request.Libraries.self
        )

        let libraries = response.libraries
        XCTAssertEqual(libraries, [
            Library(
                id: "lib_5yvub9dqvctlcrza6h",
                name: "Main",
                folders: [
                    Folder(
                        id: "audiobooks",
                        fullPath: "/audiobooks",
                        libraryId: "main",
                        addedAt: Date(timeIntervalSince1970: 1633522963509 / 1000)
                    )
                ],
                displayOrder: 1,
                icon: "audiobookshelf",
                mediaType: .book,
                provider: "audible",
                settings: LibrarySettings(
                    coverAspectRatio: 1,
                    disableWatcher: false,
                    skipMatchingMediaWithAsin: false,
                    skipMatchingMediaWithIsbn: false,
                    autoScanCronExpression: nil
                ),
                createdAt: Date(timeIntervalSince1970: 1633522963509 / 1000),
                lastUpdate: Date(timeIntervalSince1970: 1646520916818 / 1000)
            ),
            Library(
                id: "lib_c1u6t4p45c35rf0nzd",
                name: "Podcasts",
                folders: [
                    Folder(
                        id: "fol_bev1zuxhb0j0s1wehr",
                        fullPath: "/podcasts",
                        libraryId: "lib_c1u6t4p45c35rf0nzd",
                        addedAt: Date(timeIntervalSince1970: 1650462940610 / 1000)
                    )
                ],
                displayOrder: 4,
                icon: "database",
                mediaType: .podcast,
                provider: "itunes",
                settings: LibrarySettings(
                    coverAspectRatio: 1,
                    disableWatcher: false,
                    skipMatchingMediaWithAsin: false,
                    skipMatchingMediaWithIsbn: false,
                    autoScanCronExpression: nil
                ),
                createdAt: Date(timeIntervalSince1970: 1650462940610 / 1000),
                lastUpdate: Date(timeIntervalSince1970: 1650462940610 / 1000)
            )
        ])
    }
}
