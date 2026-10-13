//
//  LenientDecoding.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 13/10/26.
//

import Foundation

// Audiobookshelf servers send whatever their database holds: fields go missing or arrive as null
// across server versions and scanner states, and SQLite booleans can arrive as numbers. These
// wrappers keep one odd value from failing a whole response. Only identifiers stay required.
//
// Values that are present but can't be read, and array elements that are left out, are recorded
// as `DecodingIssue`s for `ResourceRequest.decodedResponse(from:)`. Missing and null values aren't.

/// A value that decodes as nil when the server leaves it out, sends null, or sends a type that
/// can't be read as the expected one.
///
/// Booleans also accept 0 and 1, strings accept numbers, numbers accept numeric strings, and dates
/// accept the formats `decodeAudiobookshelfDateIfPresent` reads.
@propertyWrapper
public struct Lenient<Value> {
    public var wrappedValue: Value?

    public init(wrappedValue: Value?) {
        self.wrappedValue = wrappedValue
    }
}

extension Lenient: Equatable where Value: Equatable {}
extension Lenient: Hashable where Value: Hashable {}
extension Lenient: Sendable where Value: Sendable {}

extension Lenient: Decodable where Value: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = container.decodeNil() ? nil : try? container.decode(Value.self)
    }
}

extension Lenient: Encodable where Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

/// An array that skips elements it can't decode, and decodes as empty when the server leaves it
/// out or sends null.
///
/// The projected value reports how many elements were skipped: `item.$audioFiles.skippedCount`.
@propertyWrapper
public struct LossyArray<Element> {
    public var wrappedValue: [Element]
    /// Elements left out because they couldn't be decoded.
    public var skippedCount: Int

    public var projectedValue: LossyArray<Element> { self }

    public init(wrappedValue: [Element]) {
        self.wrappedValue = wrappedValue
        skippedCount = 0
    }

    init(_ elements: [Element], skippedCount: Int) {
        wrappedValue = elements
        self.skippedCount = skippedCount
    }
}

extension LossyArray: Equatable where Element: Equatable {}
extension LossyArray: Hashable where Element: Hashable {}
extension LossyArray: Sendable where Element: Sendable {}

extension LossyArray: Decodable where Element: Decodable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements = [Element]()
        var skippedCount = 0
        while !container.isAtEnd {
            do {
                try elements.append(container.decode(Element.self))
            } catch {
                DecodingIssueCollector.record(
                    .skippedElement,
                    error,
                    codingPath: container.codingPath + [IndexKey(container.currentIndex)]
                )
                // A failed decode leaves the container on the same element, so step over it.
                _ = try container.decode(SkippedElement.self)
                skippedCount += 1
            }
        }
        self.init(elements, skippedCount: skippedCount)
    }
}

extension LossyArray: Encodable where Element: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

/// A nested object that decodes as empty, with every field nil, when the server leaves it out,
/// sends null, or sends something that isn't an object. Its type must decode from `{}`.
@propertyWrapper
public struct DefaultEmpty<Value> {
    public var wrappedValue: Value

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}

extension DefaultEmpty: Equatable where Value: Equatable {}
extension DefaultEmpty: Hashable where Value: Hashable {}
extension DefaultEmpty: Sendable where Value: Sendable {}

extension DefaultEmpty: Decodable where Value: Decodable {
    public init(from decoder: Decoder) throws {
        wrappedValue = try (try? Value(from: decoder)) ?? Value.decodedFromEmptyObject()
    }
}

extension DefaultEmpty: Encodable where Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

private struct SkippedElement: Decodable {
    init(from _: Decoder) {}
}

private struct IndexKey: CodingKey {
    let intValue: Int?
    let stringValue: String

    init(_ index: Int) {
        intValue = index
        stringValue = "Index \(index)"
    }

    init?(intValue: Int) {
        self.init(intValue)
    }

    init?(stringValue _: String) {
        nil
    }
}

private extension Decodable {
    static func decodedFromEmptyObject() throws -> Self {
        try JSONDecoder().decode(Self.self, from: Data("{}".utf8))
    }
}

// MARK: - Keyed containers

// Synthesized `Codable` conformances call these overloads for wrapped properties, which lets a
// missing key decode instead of throwing `keyNotFound`.

extension KeyedDecodingContainer {
    func decode<Value: Decodable>(_: Lenient<Value>.Type, forKey key: Key) throws -> Lenient<Value> {
        Lenient(wrappedValue: decodeLeniently(Value.self, forKey: key))
    }

    func decode<Element: Decodable>(_: LossyArray<Element>.Type, forKey key: Key) throws -> LossyArray<Element> {
        guard hasValue(forKey: key) else {
            return LossyArray(wrappedValue: [])
        }
        do {
            return try LossyArray<Element>(from: superDecoder(forKey: key))
        } catch {
            DecodingIssueCollector.record(.unreadableValue, error, codingPath: codingPath + [key])
            return LossyArray(wrappedValue: [])
        }
    }

    func decode<Value: Decodable>(_: DefaultEmpty<Value>.Type, forKey key: Key) throws -> DefaultEmpty<Value> {
        if hasValue(forKey: key) {
            do {
                return try DefaultEmpty(wrappedValue: decode(Value.self, forKey: key))
            } catch {
                DecodingIssueCollector.record(.unreadableValue, error, codingPath: codingPath + [key])
            }
        }
        return try DefaultEmpty(wrappedValue: Value.decodedFromEmptyObject())
    }

    /// Decodes an array that must be present, such as a page's results, skipping elements that
    /// can't be decoded. A missing array still fails, so a response that isn't a page of results
    /// is never mistaken for an empty one.
    func decodeRequiredLossyArray<Element: Decodable>(
        _: Element.Type,
        forKey key: Key
    ) throws -> LossyArray<Element> {
        try LossyArray<Element>(from: superDecoder(forKey: key))
    }

    func decodeLeniently<Value: Decodable>(_: Value.Type, forKey key: Key) -> Value? {
        guard hasValue(forKey: key) else { return nil }
        if Value.self == Date.self {
            if let date = try? decodeAudiobookshelfDateIfPresent(forKey: key) {
                return date as? Value
            }
            DecodingIssueCollector.record(
                .unreadableValue,
                DecodingError.typeMismatch(Date.self, .init(
                    codingPath: codingPath + [key],
                    debugDescription: "Expected a date in milliseconds or a date string."
                )),
                codingPath: codingPath + [key]
            )
            return nil
        }
        do {
            return try decode(Value.self, forKey: key)
        } catch {
            if let value = (Value.self as? LenientlyCoercible.Type)?.coerced(from: self, forKey: key) as? Value {
                return value
            }
            DecodingIssueCollector.record(.unreadableValue, error, codingPath: codingPath + [key])
            return nil
        }
    }

    private func hasValue(forKey key: Key) -> Bool {
        contains(key) && (try? decodeNil(forKey: key)) == false
    }
}

extension KeyedEncodingContainer {
    mutating func encode<Value: Encodable>(_ value: Lenient<Value>, forKey key: Key) throws {
        try encodeIfPresent(value.wrappedValue, forKey: key)
    }
}

// MARK: - Coercion

/// Scalars that can be read from another JSON type the server sometimes sends instead.
private protocol LenientlyCoercible {
    static func coerced<Key>(from container: KeyedDecodingContainer<Key>, forKey key: Key) -> Self?
}

extension Bool: LenientlyCoercible {
    fileprivate static func coerced<Key>(from container: KeyedDecodingContainer<Key>, forKey key: Key) -> Bool? {
        if let number = try? container.decode(Int.self, forKey: key) {
            switch number {
            case 0: return false
            case 1: return true
            default: return nil
            }
        }
        switch (try? container.decode(String.self, forKey: key))?.lowercased() {
        case "true", "1": return true
        case "false", "0": return false
        default: return nil
        }
    }
}

extension String: LenientlyCoercible {
    fileprivate static func coerced<Key>(from container: KeyedDecodingContainer<Key>, forKey key: Key) -> String? {
        if let number = try? container.decode(Int64.self, forKey: key) {
            return String(number)
        }
        if let number = try? container.decode(Double.self, forKey: key) {
            return String(number)
        }
        return nil
    }
}

extension Int: LenientlyCoercible {
    fileprivate static func coerced<Key>(from container: KeyedDecodingContainer<Key>, forKey key: Key) -> Int? {
        integer(from: container, forKey: key)
    }
}

extension Int64: LenientlyCoercible {
    fileprivate static func coerced<Key>(from container: KeyedDecodingContainer<Key>, forKey key: Key) -> Int64? {
        integer(from: container, forKey: key)
    }
}

extension Double: LenientlyCoercible {
    fileprivate static func coerced<Key>(from container: KeyedDecodingContainer<Key>, forKey key: Key) -> Double? {
        (try? container.decode(String.self, forKey: key)).flatMap { Double($0) }
    }
}

/// Reads a whole number sent as a string, or as a number with a fractional part of zero.
private func integer<Integer: BinaryInteger, Key>(
    from container: KeyedDecodingContainer<Key>,
    forKey key: Key
) -> Integer? {
    let number = (try? container.decode(Double.self, forKey: key))
        ?? (try? container.decode(String.self, forKey: key)).flatMap { Double($0) }
    guard let number, number.rounded() == number else { return nil }
    return Integer(exactly: number)
}
