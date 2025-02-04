// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "quiches-ios-sdk",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "QuichesCore",
            targets: ["QuichesCore"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            name: "KeychainSwift",
            url: "https://github.com/evgenyneu/keychain-swift.git",
            .exact("19.0.0")),
        .package(
            name: "JWTDecode",
            url: "https://github.com/auth0/JWTDecode.swift.git",
            .exact("2.6.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "QuichesCore",
            dependencies: ["KeychainSwift", "JWTDecode"]),
        .testTarget(
            name: "quiches-ios-sdkTests",
            dependencies: ["QuichesCore"]),
    ]
)
