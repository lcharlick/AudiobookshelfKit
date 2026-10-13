//
//  JSONEditing.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 13/10/26.
//  Copyright © 2026 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

/// A change to one value in a JSON fixture, addressed by a path such as `media.audioFiles[0].ino`.
struct JSONEdit: CustomTestStringConvertible, Sendable {
    enum Change: Sendable {
        case remove
        case null
        case string(String)
        case number(Double)
        case object([String: String])
        case array([[String: String]])
    }

    let issue: String
    let path: String
    let change: Change

    init(_ issue: String, _ path: String, _ change: Change) {
        self.issue = issue
        self.path = path
        self.change = change
    }

    var testDescription: String { "\(issue): \(path) \(change)" }
}

/// Decodes a request's response from a fixture after applying edits to it.
func decode<R: ResourceRequest>(
    _ request: R.Type,
    from resource: String,
    editing edits: [JSONEdit]
) throws -> R.Response {
    let json = try JSONSerialization.jsonObject(with: loadResource(resource, ext: "json"))
    return try decode(request, json: json, editing: edits)
}

/// Decodes a request's response from a JSON object after applying edits to it.
func decode<R: ResourceRequest>(
    _: R.Type,
    json: Any,
    editing edits: [JSONEdit]
) throws -> R.Response {
    var json = json
    for edit in edits {
        json = try apply(edit.change, at: PathComponent.parse(edit.path)[...], to: json)
    }
    return try R.response(from: JSONSerialization.data(withJSONObject: json))
}

/// Decodes a request's response from a fixture after applying edits to it, with its issues.
func decodeWithIssues<R: ResourceRequest>(
    _: R.Type,
    from resource: String,
    editing edits: [JSONEdit]
) throws -> Decoded<R.Response> {
    var json = try JSONSerialization.jsonObject(with: loadResource(resource, ext: "json"))
    for edit in edits {
        json = try apply(edit.change, at: PathComponent.parse(edit.path)[...], to: json)
    }
    return try R.decodedResponse(from: JSONSerialization.data(withJSONObject: json))
}

func loadJSONObject(_ resource: String) throws -> [String: Any] {
    try JSONSerialization.jsonObject(with: loadResource(resource, ext: "json")) as! [String: Any]
}

private enum PathComponent {
    case key(String)
    case index(Int)

    static func parse(_ path: String) -> [PathComponent] {
        path.split(separator: ".").flatMap { segment -> [PathComponent] in
            let parts = segment.split(separator: "[")
            let indices = parts.dropFirst().map { PathComponent.index(Int($0.dropLast())!) }
            return [.key(String(parts[0]))] + indices
        }
    }
}

private struct JSONPathError: Error {
    let description: String
}

private func apply(_ change: JSONEdit.Change, at path: ArraySlice<PathComponent>, to node: Any) throws -> Any {
    guard let component = path.first else {
        return value(for: change) as Any
    }
    let rest = path.dropFirst()
    switch component {
    case .key(let key):
        guard var object = node as? [String: Any] else {
            throw JSONPathError(description: "Expected an object for \(key)")
        }
        if rest.isEmpty, case .remove = change {
            object.removeValue(forKey: key)
        } else {
            guard let child = rest.isEmpty ? NSNull() : object[key] else {
                throw JSONPathError(description: "No value for \(key)")
            }
            object[key] = try apply(change, at: rest, to: child)
        }
        return object
    case .index(let index):
        guard var array = node as? [Any], array.indices.contains(index) else {
            throw JSONPathError(description: "No element at \(index)")
        }
        array[index] = try apply(change, at: rest, to: array[index])
        return array
    }
}

private func value(for change: JSONEdit.Change) -> Any? {
    switch change {
    case .remove: nil
    case .null: NSNull()
    case .string(let string): string
    case .number(let number): number
    case .object(let object): object
    case .array(let array): array
    }
}
