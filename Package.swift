// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "hummingbird-ratelimit",
  platforms: [
    .macOS(.v18)
  ],
  products: [
    .library(
      name: "RateLimit",
      targets: ["RateLimit"]
    ),
    .executable(
      name: "App",
      targets: ["App"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.0.0"),
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.3.0"),
  ],
  targets: [
    .executableTarget(
      name: "App",
      dependencies: [
        .target(name: "RateLimit"),
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]
    ),
    .target(
      name: "RateLimit",
      dependencies: [
        .product(name: "Hummingbird", package: "hummingbird")
      ]
    ),
    .testTarget(
      name: "RateLimitTests",
      dependencies: [
        .target(name: "RateLimit"),
        .product(name: "HummingbirdTesting", package: "hummingbird"),
      ]
    ),
  ]
)
