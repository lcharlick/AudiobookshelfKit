//
//  Track.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Track: Codable, Hashable, Sendable {
    @Lenient public var index: Int?
    @Lenient public var startOffset: TimeInterval?
    @Lenient public var duration: TimeInterval?
    @Lenient public var title: String?
    @Lenient public var contentUrl: String?
    @Lenient public var mimeType: String?
    @Lenient public var codec: String?
    @DefaultEmpty public var metadata: LibraryFile.Metadata
}
