//
//  GetLibraries.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 9/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

public extension Audiobookshelf.Request {
    /// This endpoint retrieves all libraries accessible to the user.
    struct GetLibraries: ResourceRequest {
        public let path = "api/libraries"

        public init() {}
    }
}

public extension Audiobookshelf.Request.GetLibraries {
    struct Response: Codable, Sendable {
        /// The requested libraries.
        public let libraries: [Library]
        /// Libraries left out because they couldn't be decoded.
        public let skippedCount: Int

        enum CodingKeys: String, CodingKey {
            case libraries
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let libraries = try container.decodeRequiredLossyArray(Library.self, forKey: .libraries)
            self.libraries = libraries.wrappedValue
            skippedCount = libraries.skippedCount
        }
    }
}
