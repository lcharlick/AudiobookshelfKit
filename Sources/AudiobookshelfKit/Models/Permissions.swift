//
//  Permissions.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

struct Permissions: Codable, Hashable {
    let download: Bool
    let update: Bool
    let delete: Bool
    let upload: Bool
    let accessAllLibraries: Bool
    let accessAllTags: Bool
    let accessExplicitContent: Bool
}
