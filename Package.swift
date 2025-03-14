// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TBBillKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "TBBillKit",
            targets: ["TBBillKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "TBBillKit",
            dependencies: [
                .product(name: "OrderedCollections", package: "swift-collections")
            ]
        ),
        .testTarget(
            name: "TBBillKitTests",
            dependencies: ["TBBillKit"]
        ),
    ]
)

