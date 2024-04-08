//
//  ServerSettings.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

struct ServerSettings: Codable {
    let id: String
    let scannerFindCovers: Bool
    let scannerCoverProvider: String
    let scannerParseSubtitle: Bool
    let scannerPreferAudioMetadata: Bool
    let scannerPreferOpfMetadata: Bool
    let scannerPreferMatchedMetadata: Bool
    let scannerDisableWatcher: Bool
    let scannerPreferOverdriveMediaMarker: Bool
    let scannerUseSingleThreadedProber: Bool
    let scannerMaxThreads: Int
    let scannerUseTone: Bool
    let storeCoverWithItem: Bool
    let storeMetadataWithItem: Bool
    let metadataFileFormat: String
    let rateLimitLoginRequests: Int
    let rateLimitLoginWindow: Int
    let backupSchedule: String
    let backupsToKeep: Int
    let maxBackupSize: Int
    let backupMetadataCovers: Bool
    let loggerDailyLogsToKeep: Int
    let loggerScannerLogsToKeep: Int
    let homeBookshelfView: Int
    let bookshelfView: Int
    let sortingIgnorePrefix: Bool
    let sortingPrefixes: [String]
    let chromecastEnabled: Bool
    let dateFormat: String
    let language: String
    let logLevel: Int
    let version: String
}
