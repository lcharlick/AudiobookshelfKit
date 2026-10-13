//
//  Series.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 1/3/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Series: Codable, Identifiable, Sendable {
    public let id: String
    @Lenient public var name: String?
    @Lenient public var nameIgnorePrefix: String?
    @Lenient public var description: String?
    @Lenient public var addedAt: Date?
    @Lenient public var updatedAt: Date?
    @Lenient public var libraryId: String?
    @LossyArray public var books: [LibraryItem]
}
