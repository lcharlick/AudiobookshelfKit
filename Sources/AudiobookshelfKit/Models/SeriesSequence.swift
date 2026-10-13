//
//  SeriesSequence.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

public struct SeriesSequence: Codable, Hashable, Identifiable, Sendable {
    public let id: String
    @Lenient public var name: String?
    @Lenient public var sequence: String?
}
