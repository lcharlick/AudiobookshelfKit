//
//  LoginResponse.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 1712/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct LoginResponse: Codable, Hashable, Sendable {
    /// The authenticated user.
    public let user: User
    /// The ID of the first library in the list the user has access to.
    @Lenient public var userDefaultLibraryId: String?
    /// The server's settings.
    @DefaultEmpty public var serverSettings: ServerSettings
    /// The server's installation source.
    @Lenient private var Source: String?
    /// The server's installation source.
    public var source: String? { Source }
}
