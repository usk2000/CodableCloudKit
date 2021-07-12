// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CodableCloudKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "CodableCloudKit",
            targets: ["CodableCloudKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CodableCloudKit",
            dependencies: []),
        .testTarget(
            name: "CodableCloudKitTests",
            dependencies: ["CodableCloudKit"]),
    ]
)
