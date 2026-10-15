// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-international-system-of-units",
    platforms: [.macOS(.v27), .iOS(.v27), .tvOS(.v27), .watchOS(.v27), .visionOS(.v27)],
    products: [.library(name: "International System of Units", targets: ["International System of Units"])],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-rational.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-radical.git", branch: "main")
    ],
    targets: [
        .target(
            name: "International System of Units",
            dependencies: [
                .product(name: "Radical", package: "swift-radical"),
                .product(name: "Rational", package: "swift-rational")
            ]
        ),
        .testTarget(
            name: "International System of Units Tests",
            dependencies: [
                .target(name: "International System of Units"),
                .product(name: "Radical", package: "swift-radical"),
                .product(name: "Rational", package: "swift-rational"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
    ]
}
