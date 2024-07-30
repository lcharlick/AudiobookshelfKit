//
//  GetUser.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 30/7/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public extension Audiobookshelf.Request {
    /// This endpoint retrieves your user.
    struct GetUser: ResourceRequest {
        public var path = "api/me"
    }
}

public extension Audiobookshelf.Request.GetUser {
    typealias Response = User
}
