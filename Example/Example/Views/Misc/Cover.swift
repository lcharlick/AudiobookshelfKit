//
//  Cover.swift
//  Example
//
//  Created by Lachlan Charlick on 18/4/2024.
//

import AudiobookshelfKit
import Foundation
import SwiftUI

struct Cover: View {
    let itemID: String
    var size: CGFloat = 80

    @Environment(\.client) private var client
    @Environment(ServerInfo.self) private var serverInfo
    @Environment(\.isPreview) private var isPreview
    @Environment(\.displayScale) private var displayScale

    @State private var image: UIImage?

    private enum Constants {
        static let cornerRadius: CGFloat = 8
    }

    private func getCover() async {
        let request = Audiobookshelf.Request.GetLibraryItemCover(
            id: itemID,
            width: Int(size * displayScale),
            height: Int(size * displayScale),
            format: .webp
        )
        let result = await client.request(request, from: serverInfo.url, token: serverInfo.token)
        switch result {
        case let .success(data):
            image = UIImage(data: data)
        case .failure:
            break
        }
    }

    var body: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(height: size)
                .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
        } else {
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                .foregroundStyle(.secondary)
                .aspectRatio(1, contentMode: .fit)
                .frame(height: size)
                .task {
                    if !isPreview {
                        await getCover()
                    }
                }
        }
    }
}

#Preview {
    Cover(itemID: "my-item")
        .environment(ServerInfo.mock)
}
