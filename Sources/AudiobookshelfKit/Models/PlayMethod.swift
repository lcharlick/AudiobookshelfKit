//
//  PlayMethod.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/4/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public enum PlayMethod: Int, Codable {
    case directPlay = 0
    case directStream = 1
    case transcode = 2
    case local = 3
}
