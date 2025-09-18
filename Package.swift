// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MouseControl",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "MouseControl",
            targets: ["MouseControl"]
        ),
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "MouseControl",
            dependencies: [],
            path: "Sources"
        ),
    ]
) 