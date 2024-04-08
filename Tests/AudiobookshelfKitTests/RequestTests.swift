//
//  RequestTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import XCTest
@testable import AudiobookshelfKit

class RequestTests: XCTestCase {
    private let testURL = URL(string: "http://192.168.0.100:32400")!

    private struct RequestData {
        init(request: URLRequest) {
            let url = request.url!
            baseURL = url.removingQueryItems()
            httpMethod = request.httpMethod
            headers = request.allHTTPHeaderFields

            let items = url.queryItems?.map {
                ($0.name, $0.value)
            } ?? []

            queryItems = Dictionary(uniqueKeysWithValues: items)
            if let httpBody = request.httpBody {
                self.httpBody = try! JSONDecoder().decode([String: String].self, from: httpBody)
            } else {
                self.httpBody = nil
            }
        }

        let baseURL: URL
        let httpMethod: String?
        let queryItems: [String: String?]
        let headers: [String: String]?
        let httpBody: [String: String]?
    }
}

// MARK: - Login.

extension RequestTests {
    func testLogin() throws {
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
}

// MARK: - Extensions.

private extension URL {
    var queryItems: [URLQueryItem]? {
        URLComponents(url: self, resolvingAgainstBaseURL: true)?.queryItems
    }

    func removingQueryItems() -> URL {
        var comps = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        comps.queryItems = nil
        return comps.url!
    }
}
