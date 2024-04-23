//
//  LibrariesView.swift
//  Example
//
//  Created by Lachlan Charlick on 12/4/2024.
//

import AudiobookshelfKit
import SwiftUI

struct LibrariesView: View {
    @Environment(\.client) private var client
    @Environment(ServerInfo.self) private var serverInfo
    @Environment(\.isPreview) private var isPreview

    @State private var libraries: [Library]?
    @State private var errorMessage: String?

    private func getLibraries() async {
        let request = Audiobookshelf.Request.GetLibraries()
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
                        NavigationLink(value: Route.library(id: library.id)) {
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
    LibrariesView()
        .environment(ServerInfo.mock)
        .environment(\.isPreview, true)
}
