//
//  Client.swift
//  Example
//
//  Created by Lachlan Charlick on 23/4/2024.
//

import AudiobookshelfKit
import SwiftUI

private struct ClientKey: EnvironmentKey {
    static var defaultValue: Audiobookshelf { Audiobookshelf(sessionConfiguration: .default) }
}

extension EnvironmentValues {
    var client: Audiobookshelf {
        get { self[ClientKey.self] }
        set { self[ClientKey.self] = newValue }
    }
}
