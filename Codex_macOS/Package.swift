// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Codex",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "Codex", targets: ["Codex"]),
        .executable(name: "RenderIcon", targets: ["RenderIcon"]),
    ],
    targets: [
        .executableTarget(
            name: "Codex",
            path: "Sources/Codex",
            resources: [],
            swiftSettings: [
                .unsafeFlags(["-parse-as-library"]),
            ]
        ),
        // Draws the AppIcon for package_app.sh. A target rather than a shell
        // heredoc so `swift build` type-checks it on every pull request —
        // the icon generator it replaced was never compiled by anything, and
        // shipped a blank square for months.
        //
        // No -parse-as-library here: main.swift is top-level script code.
        .executableTarget(
            name: "RenderIcon",
            path: "Sources/RenderIcon"
        ),
    ]
)
