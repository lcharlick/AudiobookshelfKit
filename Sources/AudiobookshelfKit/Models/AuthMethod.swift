//
//  AuthMethod.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 15/12/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public enum AuthMethod: Codable, Hashable {
    case local
    case openid
    case unknown(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)

        switch stringValue.lowercased() {
        case "local":
            self = .local
        case "openid":
            self = .openid
        default:
            self = .unknown(stringValue)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .local:
            try container.encode("local")
        case .openid:
            try container.encode("openid")
        case .unknown(let value):
            try container.encode(value)
        }
    }
}
