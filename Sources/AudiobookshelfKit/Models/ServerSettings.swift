//
//  ServerSettings.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct ServerSettings: Codable, Hashable {
    /// The ID of the server settings.
    public let id: String
    /// Whether the scanner will attempt to find a cover if your audiobook does not have an embedded cover or a cover image inside the folder.
    /// Note: This will extend scan time.
    public let scannerFindCovers: Bool
    /// If scannerFindCovers is true, which metadata provider to use.
    public let scannerCoverProvider: String
    /// Whether to extract subtitles from audiobook folder names.
    /// Subtitles must be separated by -, i.e. `/audiobooks/Book Title - A Subtitle Here/` has the subtitle `A Subtitle Here`.
    public let scannerParseSubtitle: Bool
    /// Whether to use audio file ID3 meta tags instead of folder names for book details.
    public let scannerPreferAudioMetadata: Bool?
    /// Whether to use OPF file metadata instead of folder names for book details.
    public let scannerPreferOpfMetadata: Bool?
    /// Whether matched data will override item details when using Quick Match.
    /// By default, Quick Match will only fill in missing details.
    public let scannerPreferMatchedMetadata: Bool
    /// Whether to disable the automatic adding/updating of items when file changes are detected.
    /// Requires server restart for changes to take effect.
    public let scannerDisableWatcher: Bool
    /// Whether to use the custom metadata in MP3 files from Overdrive for chapter timings automatically.
    public let scannerPreferOverdriveMediaMarker: Bool?
    /// 
    public let scannerUseSingleThreadedProber: Bool?
    /// 
    public let scannerMaxThreads: Int?
    /// 
    public let scannerUseTone: Bool?
    /// Whether to store covers in the library item's folder.
    /// By default, covers are stored in `/metadata/items`.
    /// Only one file named cover will be kept.
    public let storeCoverWithItem: Bool
    /// Whether to store metadata files in the library item's folder.
    /// By default, metadata files are stored in `/metadata/items`.
    /// Uses the `.abs` file extension.
    public let storeMetadataWithItem: Bool
    /// Must be either `json` or `abs`.
    public let metadataFileFormat: MetatadataFileFormat
    /// The maximum number of login requests per `rateLimitLoginWindow`.
    public let rateLimitLoginRequests: Int
    /// The length (in ms) of each login rate limit window.
    public let rateLimitLoginWindow: Int
    /// The cron expression for when to do automatic backups.
    // TODO: This seems to be a string OR boolean, but the API docs don't specify.
    // public let backupSchedule: String
    /// The number of backups to keep.
    public let backupsToKeep: Int
    /// The maximum backup size (in GB) before they fail, a safeguard against misconfiguration.
    public let maxBackupSize: Int
    /// Whether backups should include library item covers and author images located in metadata.
    // public let backupMetadataCovers: Bool
    /// The number of daily logs to keep.
    public let loggerDailyLogsToKeep: Int
    /// The number of scanner logs to keep.
    public let loggerScannerLogsToKeep: Int
    /// Whether the home page should use a skeuomorphic design with wooden shelves.
    public let homeBookshelfView: Int
    /// Whether other bookshelf pages should use a skeuomorphic design with wooden shelves.
    public let bookshelfView: Int
    /// Whether to ignore prefixes when sorting.
    public let sortingIgnorePrefix: Bool
    /// If `sortingIgnorePrefix` is true, what prefixes to ignore.
    public let sortingPrefixes: [String]
    /// Whether to enable streaming to Chromecast devices.
    public let chromecastEnabled: Bool
    /// What date format to use.
    /// Options are `MM/dd/yyyy`, `dd/MM/yyyy`, `dd.MM.yyyy`, `yyyy-MM-dd`, `MMM do, yyyy`, `MMMM do, yyyy`, `dd MMM yyyy`, or `dd MMMM yyyy`.
    public let dateFormat: String
    /// What time format to use.
    public let timeFormat: String
    /// The default server language.
    public let language: String
    /// What log level the server should use when logging.
    /// 1 for debug, 2 for info, or 3 for warnings.
    public let logLevel: Int
    /// The server's version.
    public let version: String
}

public enum MetatadataFileFormat: String, Codable {
    case json
    case abs
}
