// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "hummingbird-ratelimit",
  platforms: [
    .macOS(.v26),
  ],
  products: [
    .library(
      name: "RateLimit",
      targets: ["RateLimit"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.0.0"),
  ],
  targets: [
    .target(
      name: "RateLimit",
      dependencies: [
        .product(name: "Hummingbird", package: "hummingbird"),
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
