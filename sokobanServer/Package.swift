// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sokobanServer",
    dependencies: [
        .package(url: "https://github.com/Kitura/BlueSocket.git", from:"1.0.8"),
    ],
    targets: [
        Target
        .executableTarget(
            name: "sokobanServer",
            dependencies: [.product(name: "Socket", package: "BlueSocket")],
            resources: [.process("Resources")]
            ),
        .testTarget(
            name: "sokobanServerTests",
            dependencies: ["sokobanServer"]),
    ]
)
