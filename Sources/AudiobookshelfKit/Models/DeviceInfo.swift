//
//  DeviceInfo.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/4/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

public struct DeviceInfo: Codable, Hashable, Identifiable, Sendable {
    /// Unique identifier.
    public let id: String?
    /// User identifier.
    public let userId: String?
    /// Device identifier, as provided in the request.
    public let deviceId: String?
    /// The IP address that the request came from.
    public let ipAddress: String?
    /// The browser name, taken from the user agent.
    public let browserName: String?
    /// The browser version, taken from the user agent.
    public let browserVersion: String?
    /// The name of OS, taken from the user agent.
    public let osName: String?
    /// The version of the OS, taken from the user agent.
    public let osVersion: String?
    /// The device name, constructed automatically from other attributes.
    public let deviceName: String?
    /// The device type, taken from the user agent.
    public let deviceType: String?
    /// The client device's manufacturer, as provided in the request.
    public let manufacturer: String?
    /// The client device's model, as provided in the request.
    public let model: String?
    /// Name of the client, as provided in the request.
    public let clientName: String?
    /// Version of the client, as provided in the request.
    public let clientVersion: String?

    public init(
        id: String? = nil,
        userId: String? = nil,
        deviceId: String,
        ipAddress: String? = nil,
        browserName: String? = nil,
        browserVersion: String? = nil,
        osName: String? = nil,
        osVersion: String? = nil,
        deviceName: String? = nil,
        deviceType: String? = nil,
        manufacturer: String? = nil,
        model: String? = nil,
        clientName: String,
        clientVersion: String
    ) {
        self.id = id
        self.userId = userId
        self.deviceId = deviceId
        self.ipAddress = ipAddress
        self.browserName = browserName
        self.browserVersion = browserVersion
        self.osName = osName
        self.osVersion = osVersion
        self.deviceName = deviceName
        self.deviceType = deviceType
        self.manufacturer = manufacturer
        self.model = model
        self.clientName = clientName
        self.clientVersion = clientVersion
    }
}
