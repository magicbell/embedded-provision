// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EmbeddedProvision",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "EmbeddedProvision",
            targets: ["EmbeddedProvision"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/filom/ASN1Decoder", from: "1.10.0")
    ],
    targets: [
        .target(
            name: "EmbeddedProvision",
            dependencies: ["ASN1Decoder"],
            path: "Source"
        ),
        .testTarget(
            name: "EmbeddedProvisionTests",
            dependencies: [
                "EmbeddedProvision",
                "ASN1Decoder",
            ],
            path: "Tests",
            resources: [.copy("embedded.mobileprovision")]),
    ]
)
