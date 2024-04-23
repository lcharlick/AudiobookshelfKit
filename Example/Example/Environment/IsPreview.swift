//
//  IsPreview.swift
//  Example
//
//  Created by Lachlan Charlick on 23/4/2024.
//

import SwiftUI

private struct IsPreviewKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var isPreview: Bool {
        get { self[IsPreviewKey.self] }
        set { self[IsPreviewKey.self] = newValue }
    }
}
