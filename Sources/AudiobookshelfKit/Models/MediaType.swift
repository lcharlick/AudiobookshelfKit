//
//  MediaType.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public enum MediaType: String, Codable, Sendable {
    case book
    case podcast
    case podcastEpisode
}
