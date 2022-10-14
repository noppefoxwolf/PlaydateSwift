// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Example",
    platforms: [.custom("Playdate", versionString: "1.12.3"), .macOS(.v12)],
    products: [.library(name: "Example", type: .dynamic, targets: ["Example"])],
    dependencies: [
        .package(path: "../")
    ],
    targets: [
        .target(
            name: "Example",
            dependencies: [
                "PlaydateSwift"
            ],
            plugins: [
                .plugin(name: "BootablePlugin", package: "PlaydateSwift")
            ]
        )
    ]
)
