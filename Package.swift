// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "UNetwork",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "UNetwork",
            targets: ["UNetwork"]
        ),
        .library(
            name: "UNetworkMocks",
            targets: ["UNetworkMocks"]
        )
    ],
    targets: [
        .target(
            name: "UNetwork",
            path: "Sources/UNetwork"
        ),
        .target(
            name: "UNetworkMocks",
            dependencies: ["UNetwork"],
            path: "Sources/Mocks"
        )
    ]
)
