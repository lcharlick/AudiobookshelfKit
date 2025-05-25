//
//  Track.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Track: Codable, Hashable, Sendable {
    public let index: Int
    public let startOffset: TimeInterval
    public let duration: TimeInterval
    public let title: String
    public let contentUrl: String
    public let mimeType: String
    public let codec: String
    public let metadata: LibraryFile.Metadata
}
