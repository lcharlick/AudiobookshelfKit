// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "AudiobookshelfKit",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .watchOS(.v9),
        .tvOS(.v16),
    ],
    products: [
        .library(
            name: "AudiobookshelfKit",
            targets: ["AudiobookshelfKit"]
        ),
    ],
    targets: [
        .target(
            name: "AudiobookshelfKit"),
        .testTarget(
            name: "AudiobookshelfKitTests",
            dependencies: ["AudiobookshelfKit"],
            resources: [.process("Resources")]
        ),
    ]
)
