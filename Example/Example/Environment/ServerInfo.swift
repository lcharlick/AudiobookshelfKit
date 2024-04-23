//
//  ServerInfo.swift
//  Example
//
//  Created by Lachlan Charlick on 23/4/2024.
//

import Foundation
import SwiftUI

@Observable class ServerInfo {
    var url: URL!
    var token: String!

    init(url: URL, token: String) {
        self.url = url
        self.token = token
    }

    init() {}

    static let mock = ServerInfo(url: URL(string: "https://abs.myserver.com")!, token: "12345")
}
