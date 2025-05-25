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
    public let start: TimeInterval
    public let end: TimeInterval
    public let title: String
}
