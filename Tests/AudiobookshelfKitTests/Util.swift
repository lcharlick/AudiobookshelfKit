//
//  Util.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 29/5/20.
//  Copyright © 2020 Lachlan Charlick. All rights reserved.
//

import Foundation

class BundleLocator {}

func loadResource(_ name: String, ext: String) throws -> Data {
    guard let path = Bundle.module.path(forResource: name, ofType: ext) else {
        throw ResourceNotFoundError(name: name, ext: ext)
    }
    return try Data(contentsOf: URL(fileURLWithPath: path))
}

func urlForFile(_ name: String, ext: String) -> URL {
    let bundle = Bundle(for: BundleLocator.self)
    return bundle.url(forResource: name, withExtension: ext)!
}

struct ResourceNotFoundError: Error {
    let name: String
    let ext: String
}

struct RequestData {
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