//
//  ExampleApp.swift
//  Example
//
//  Created by Lachlan Charlick on 9/4/2024.
//

import AudiobookshelfKit
import SwiftUI

@main
struct ExampleApp: App {
    @State private var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                SignInView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case let .libraries(serverInfo):
                            LibrariesView(serverInfo: serverInfo)
                        case let .library(libraryID, serverInfo):
                            LibraryView(libraryID: libraryID, serverInfo: serverInfo)
                        }
                    }
            }
        }
        .environment(\.client, Audiobookshelf(sessionConfiguration: .default))
        .environment(router)
    }
}

struct ServerInfo: Hashable {
    let url: URL
    let token: String

    static let mock = ServerInfo(url: URL(string: "https://abs.myserver.com")!, token: "12345")
}

private struct ClientKey: EnvironmentKey {
    static var defaultValue: Audiobookshelf { Audiobookshelf(sessionConfiguration: .default) }
}

extension EnvironmentValues {
    var client: Audiobookshelf {
        get { self[ClientKey.self] }
        set { self[ClientKey.self] = newValue }
    }
}

private struct IsPreviewKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var isPreview: Bool {
        get { self[IsPreviewKey.self] }
        set { self[IsPreviewKey.self] = newValue }
    }
}
