//
//  LibraryView.swift
//  Example
//
//  Created by Lachlan Charlick on 17/4/2024.
//

import AudiobookshelfKit
import SwiftUI

struct LibraryView: View {
    let id: String

    @Environment(\.client) private var client
    @Environment(ServerInfo.self) private var serverInfo
    @Environment(\.isPreview) private var isPreview

    @State private var items: [AudiobookshelfKit.LibraryItem]
    @State private var errorMessage: String?

    init(id: String) {
        self.id = id
        items = []
    }

    init(id: String, items: [AudiobookshelfKit.LibraryItem]) {
        self.id = id
        self.items = items
    }

    private func getLibraryItems() async {
        let request = Audiobookshelf.Request.GetLibraryItems(libraryID: id, limit: 10, page: 1)
        let result = await client.request(request, from: serverInfo.url, token: serverInfo.token)
        switch result {
        case let .success(response):
            items = response.results
        case let .failure(error):
            errorMessage = error.description
        }
    }

    var body: some View {
        List {
            if let errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            } else {
                ForEach(items) { item in
                    HStack {
                        Cover(itemID: item.id)
                        Text(item.media.metadata.title)
                    }
                }
            }
        }
        .listStyle(.plain)
        .task {
            if !isPreview {
                await getLibraryItems()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Library")
    }
}

#Preview {
    let data = try! Data(contentsOf: Bundle.main.url(forResource: "library_items", withExtension: "json")!)
    let items = try! JSONDecoder().decode([AudiobookshelfKit.LibraryItem].self, from: data)
    return LibraryView(id: "my-library", items: items)
        .environment(ServerInfo.mock)
        .environment(\.isPreview, true)
}
