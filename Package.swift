// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlaydateSwift",
    platforms: [.custom("Playdate", versionString: "1.12.3"), .macOS(.v12)],
    products: [
        .library(
            name: "PlaydateSwift",
            targets: ["PlaydateSwift"]
        ),
        .plugin(name: "PDC", targets: ["PDC"]),
        .plugin(name: "BootablePlugin", targets: ["BootablePlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/noppefoxwolf/Playdate", from: "1.12.3"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.4"),
    ],
    targets: [
        .target(
            name: "PlaydateSwift",
            dependencies: [
                "Playdate"
            ]
        ),
        .plugin(
            name: "PDC",
            capability: .command(
                intent: .custom(verb: "pdc", description: "builds a pdex from resources")
            )
        ),
        
        .plugin(
            name: "BootablePlugin",
            capability: .buildTool(),
            exclude: ["Boot.swift"]
        ),
    ]
)
