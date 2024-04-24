//
//  Player.swift
//  Example
//
//  Created by Lachlan Charlick on 24/4/2024.
//

import AudiobookshelfKit
import AVFoundation
import Foundation
import OSLog

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "player")

@MainActor @Observable final class Player {
    private var player = AVQueuePlayer()

    func play(item: LibraryItemExpanded, serverInfo: ServerInfo) {
        let playerItems = item.media.audioFiles.compactMap { audioFile -> AVPlayerItem? in
            let request: URLRequest
            do {
                request = try Audiobookshelf.Request.GetLibraryItemFile(id: item.id, ino: audioFile.ino)
                    .asURLRequest(from: serverInfo.url, using: serverInfo.token, tokenStrategy: .queryItem)
            } catch {
                logger.error("Failed to initialize asset for file: \(error)")
                return nil
            }

            return AVPlayerItem(url: request.url!)
        }

        player = AVQueuePlayer(items: playerItems)
        player.play()
    }
}
