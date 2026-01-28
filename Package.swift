// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Store",
    targets: [
        .executableTarget(
            name: "Store",
            path: "Sources/Store"),
        .testTarget(
            name: "StoreTests",
            dependencies: ["Store"],
            path: "Tests/StoreTests"),
    ]
)
