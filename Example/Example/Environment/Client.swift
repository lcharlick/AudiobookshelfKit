//
//  Client.swift
//  Example
//
//  Created by Lachlan Charlick on 23/4/2024.
//

import SwiftUI
import AudiobookshelfKit

private struct ClientKey: EnvironmentKey {
    static var defaultValue: Audiobookshelf { Audiobookshelf(sessionConfiguration: .default) }
}

extension EnvironmentValues {
    var client: Audiobookshelf {
        get { self[ClientKey.self] }
        set { self[ClientKey.self] = newValue }
    }
}
