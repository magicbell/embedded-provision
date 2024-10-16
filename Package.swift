// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EmbeddedProvision",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "EmbeddedProvision",
            targets: ["EmbeddedProvision"]
        ),
    ],
    targets: [
        .target(
            name: "EmbeddedProvision",
            path: "Source"
        ),
        .testTarget(name: "EmbeddedProvisionTests",
                    dependencies: [ "EmbeddedProvision" ],
                    path: "Tests")
    ]
)
