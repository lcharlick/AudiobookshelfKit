//
//  DecodingIssue.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 13/10/26.
//

import Foundation

/// A decoded response, with anything the kit had to leave out or couldn't read.
public struct Decoded<Response> {
    public let value: Response
    /// Empty when every value decoded as expected.
    public let issues: [DecodingIssue]

    public init(value: Response, issues: [DecodingIssue] = []) {
        self.value = value
        self.issues = issues
    }
}

extension Decoded: Sendable where Response: Sendable {}

/// A value that was present in a response but couldn't be read, or an array element that was left
/// out. Values the server leaves out or sends as null aren't issues.
public struct DecodingIssue: Sendable, CustomStringConvertible {
    public enum Kind: Sendable {
        /// The value couldn't be read as its type, so it decoded as nil or empty.
        case unreadableValue
        /// The array element couldn't be read, so it was left out.
        case skippedElement
    }

    public let kind: Kind
    /// Why decoding failed. Its coding path locates the value from the root of the response.
    public let error: DecodingError

    public init(kind: Kind, error: DecodingError) {
        self.kind = kind
        self.error = error
    }

    /// Where the value was, such as `results[3].media.metadata.series`.
    public var path: String {
        context?.codingPath.reduce(into: "") { path, key in
            if let index = key.intValue {
                path += "[\(index)]"
            } else {
                path += path.isEmpty ? key.stringValue : ".\(key.stringValue)"
            }
        } ?? ""
    }

    public var description: String {
        let kind = switch kind {
        case .unreadableValue: "Unreadable value"
        case .skippedElement: "Skipped element"
        }
        return "\(kind) at \(path): \(context?.debugDescription ?? String(describing: error))"
    }

    private var context: DecodingError.Context? {
        switch error {
        case .typeMismatch(_, let context), .valueNotFound(_, let context), .keyNotFound(_, let context),
             .dataCorrupted(let context):
            context
        @unknown default:
            nil
        }
    }
}

public extension ResourceRequest {
    /// Decodes a response, with the issues found while decoding it. Responses that aren't decoded
    /// from JSON have none.
    static func decodedResponse(from data: Data) throws -> Decoded<Response> {
        let collector = DecodingIssueCollector()
        let value = try DecodingIssueCollector.$current.withValue(collector) {
            try response(from: data)
        }
        return Decoded(value: value, issues: collector.issues)
    }
}

/// Collects issues while a response decodes. The wrappers in `LenientDecoding.swift` record into
/// the collector bound for the current decode.
final class DecodingIssueCollector: @unchecked Sendable {
    @TaskLocal static var current: DecodingIssueCollector?

    private let lock = NSLock()
    private var recorded: [DecodingIssue] = []

    var issues: [DecodingIssue] {
        lock.withLock { recorded }
    }

    static func record(_ kind: DecodingIssue.Kind, _ error: Error, codingPath: [CodingKey]) {
        guard let current else { return }
        let decodingError = error as? DecodingError ?? .dataCorrupted(.init(
            codingPath: codingPath,
            debugDescription: String(describing: error),
            underlyingError: error
        ))
        current.lock.withLock {
            current.recorded.append(DecodingIssue(kind: kind, error: decodingError))
        }
    }
}
