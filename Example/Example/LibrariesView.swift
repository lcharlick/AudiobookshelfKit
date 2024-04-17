//
//  LibrariesView.swift
//  Example
//
//  Created by Lachlan Charlick on 12/4/2024.
//

import AudiobookshelfKit
import SwiftUI

struct LibrariesView: View {
    let serverInfo: ServerInfo

    @Environment(\.client) private var client
    @Environment(\.isPreview) private var isPreview

    @State private var libraries: [Library]?
    @State private var errorMessage: String?

    private func getLibraries() async {
        let request = Audiobookshelf.Request.Libraries()
        let result = await client.request(request, from: serverInfo.url, token: serverInfo.token)
        switch result {
        case let .success(response):
            libraries = response.libraries
        case let .failure(error):
            errorMessage = error.description
        }
    }

    var body: some View {
        Group {
            if let errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }
            if let libraries {
                List {
                    ForEach(libraries) { library in
                        NavigationLink(value: Route.library(libraryID: library.id, serverInfo: serverInfo)) {
                            Text(library.name)
                        }
                    }
                }
            } else {
                ProgressView()
            }
        }
        .task {
            if !isPreview {
                await getLibraries()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Libraries")
    }
}

#Preview {
    LibrariesView(serverInfo: .mock)
        .environment(\.isPreview, true)
}
