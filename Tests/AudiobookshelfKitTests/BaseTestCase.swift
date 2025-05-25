//
//  BaseTestCase.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import XCTest

let testURL = URL(string: "http://192.168.0.100:32400")!

func loadResponse<R: ResourceRequest>(
    _ name: String,
    for _: R.Type
) throws -> R.Response {
    let data = try loadResource(name, ext: "json")
    return try R.response(from: data)
}
