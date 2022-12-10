// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AKForm",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "AKForm",
            targets: ["AKForm"]),
    ],
    targets: [
        .target(
            name: "AKForm",
            dependencies: [],
            resources: [
                .copy("Views/TextFieldTableViewCell/TextFieldTableViewCell.xib"),
                .copy("Views/ButtonFieldTableViewCell/ButtonFieldTableViewCell.xib"),
                .copy("Views/OptionTableViewCell/OptionTableViewCell.xib")
            ]),
        .testTarget(
            name: "AKFormTests",
            dependencies: ["AKForm"]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
