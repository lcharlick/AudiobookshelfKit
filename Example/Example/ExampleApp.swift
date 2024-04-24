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
    @State private var router: Router
    @State private var player: Player
    @State private var serverInfo: ServerInfo

    init() {
        router = Router()
        player = Player()
        serverInfo = ServerInfo()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                SignInView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .libraries:
                            LibrariesView()
                        case let .library(id):
                            LibraryView(id: id)
                        case let .book(id, title):
                            BookDetailView(id: id, title: title)
                        }
                    }
            }
        }
        .environment(\.client, Audiobookshelf(sessionConfiguration: .default))
        .environment(router)
        .environment(player)
        .environment(serverInfo)
    }
}
