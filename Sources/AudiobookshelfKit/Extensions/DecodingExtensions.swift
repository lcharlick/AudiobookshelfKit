//
//  DecodingExtensions.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 3/5/26.
//

import Foundation

extension KeyedDecodingContainer {
    func decodeAudiobookshelfDateIfPresent(forKey key: Key) throws -> Date? {
        if try decodeNil(forKey: key) {
            return nil
        }

        if let milliseconds = try? decode(Double.self, forKey: key) {
            return Date(timeIntervalSince1970: milliseconds / 1000)
        }

        guard let string = try? decode(String.self, forKey: key) else {
            return nil
        }

        let value = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !value.isEmpty else {
            return nil
        }

        if let milliseconds = Double(value) {
            return Date(timeIntervalSince1970: milliseconds / 1000)
        }

        return AudiobookshelfDateFormatter.date(from: value)
    }
}

private enum AudiobookshelfDateFormatter {
    private static let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    static func date(from value: String) -> Date? {
        dateFormatter.date(from: value) ?? yearFormatter.date(from: value)
    }
}
