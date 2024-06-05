//
//  SeriesSequence.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

public struct SeriesSequence: Codable, Hashable {
    public let id: String
    public let name: String
    public let sequence: String?
}
