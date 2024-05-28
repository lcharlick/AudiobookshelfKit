//
//  Router.swift
//  Example
//
//  Created by Lachlan Charlick on 12/4/2024.
//

import Foundation
import Observation

@Observable class Router {
    var path = [Route]()
}

enum Route: Hashable {
    case libraries
    case library(id: String)
    case book(id: String, title: String)
}
