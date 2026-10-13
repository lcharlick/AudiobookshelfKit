//
//  Chapter.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Chapter: Codable, Hashable, Identifiable, Sendable {
    public let id: Int
    @Lenient public var start: TimeInterval?
    @Lenient public var end: TimeInterval?
    @Lenient public var title: String?
}
