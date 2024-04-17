// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "ExamplePackage",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ExamplePackage",
            targets: ["ExamplePackage"]
        ),
    ],
    dependencies: [
        .package(path: "../.."),
    ],
    targets: [
        .target(
            name: "ExamplePackage",
            dependencies: [
                "AudiobookshelfKit",
            ]
        ),
    ]
)
