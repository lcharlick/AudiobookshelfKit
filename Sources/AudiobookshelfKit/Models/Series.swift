//
//  Series.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 1/3/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct Series: Codable {
    public let id: String
    public let name: String
    public let nameIgnorePrefix: String
    public let description: String?
    public let addedAt: Date
    public let updatedAt: Date
    public let libraryId: String
    public let books: [LibraryItem]
}
