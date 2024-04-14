//
//  LibrariesView.swift
//  Example
//
//  Created by Lachlan Charlick on 12/4/2024.
//

import SwiftUI
import AudiobookshelfKit

struct LibrariesView: View {
    let serverInfo: ServerInfo
    @Environment(\.client) private var client
    @State private var libraries: [Library]?
    @State private var errorMessage: String?

    private func fetchLibraries() async {
        let request = Audiobookshelf.Request.Libraries()
        let result = await client.request(request, from: serverInfo.url, token: serverInfo.token)
        switch result {
        case .success(let response):
            libraries = response.libraries
        case .failure(let error):
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
                        Text(library.name)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .task {
            await fetchLibraries()
        }
        .navigationTitle("Libraries")
    }
}

#Preview {
    LibrariesView(serverInfo: ServerInfo(url: URL(string: "https://abs.myserver.com")!, token: "12345"))
}
