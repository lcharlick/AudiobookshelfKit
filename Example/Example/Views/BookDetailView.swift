//
//  BookDetailView.swift
//  Example
//
//  Created by Lachlan Charlick on 23/4/2024.
//

import AudiobookshelfKit
import SwiftUI

struct BookDetailView: View {
    let id: String
    let title: String

    @Environment(\.client) private var client
    @Environment(ServerInfo.self) private var serverInfo
    @Environment(\.isPreview) private var isPreview

    @State private var item: LibraryItemExpanded?
    @State private var errorMessage: String?

    init(id: String, title: String) {
        self.id = id
        self.title = title
    }

    #if DEBUG
        init(item: LibraryItemExpanded) {
            id = item.id
            title = item.media.metadata.title
            _item = State(initialValue: item)
        }
    #endif

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
                BookView(item: item)
            } else if let errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            } else {
                ProgressView()
            }
        }
        .task {
            if !isPreview {
                await getLibraryItem()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(title)
    }
}

private struct BookView: View {
    let item: LibraryItemExpanded

    @Environment(Player.self) private var player
    @Environment(ServerInfo.self) private var serverInfo

    var body: some View {
        List {
            VStack {
                Cover(itemID: item.id, size: 150)
                Text(item.media.metadata.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                Text("By \(item.media.metadata.authorName)")
                Button(action: {
                    player.play(item: item, serverInfo: serverInfo)
                }, label: {
                    Text("Play")
                })
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity)
            .listRowBackground(EmptyView())
            Section("Chapters") {
                ForEach(item.media.chapters) { chapter in
                    Text(chapter.title)
                }
            }
        }
    }
}

#Preview {
    let data = try! Data(contentsOf: Bundle.main.url(forResource: "library_item", withExtension: "json")!)
    let item = try! JSONDecoder().decode(LibraryItemExpanded.self, from: data)

    return NavigationStack {
        BookDetailView(item: item)
            .environment(\.isPreview, true)
            .environment(ServerInfo.mock)
            .environment(Player())
    }
}
