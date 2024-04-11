//
//  ExampleApp.swift
//  Example
//
//  Created by Lachlan Charlick on 9/4/2024.
//

import SwiftUI
import AudiobookshelfKit

@main
struct ExampleApp: App {
    @State private var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                SignInView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .libraries(let serverInfo):
                            LibrariesView(serverInfo: serverInfo)
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
}

private struct ClientKey: EnvironmentKey {
    static var defaultValue: Audiobookshelf { Audiobookshelf(sessionConfiguration: .default) }
}

extension EnvironmentValues {
    public var client: Audiobookshelf {
        get { self[ClientKey.self] }
        set { self[ClientKey.self] = newValue }
    }
}
