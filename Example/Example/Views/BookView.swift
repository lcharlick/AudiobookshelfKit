//
//  BookView.swift
//  Example
//
//  Created by Lachlan Charlick on 23/4/2024.
//

import AudiobookshelfKit
import SwiftUI

struct BookView: View {
    let id: String
    let title: String

    @Environment(\.client) private var client
    @Environment(ServerInfo.self) private var serverInfo
    @Environment(\.isPreview) private var isPreview

    @State private var item: LibraryItemExpanded?
    @State private var errorMessage: String?

    private func getLibraryItem() async {
        let request = Audiobookshelf.Request.GetLibraryItem(id: id)
        let result = await client.request(request, from: serverInfo.url, token: serverInfo.token)
        switch result {
        case let .success(response):
            item = response
        case let .failure(error):
            errorMessage = error.description
        }
    }

    var body: some View {
        Group {
            if let item {
                VStack {
                    Cover(itemID: id, size: 150)
                    Text(item.media.metadata.title)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Text("By \(item.media.metadata.authorName)")
                }
            } else if let errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            } else {
                ProgressView()
            }
        }
        .task {
            await getLibraryItem()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(title)
    }
}

#Preview {
    BookView(id: "my-book", title: "My Book")
}
