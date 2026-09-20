import Foundation

// MARK: - Version

/// One place for the version the app shows itself as.
///
/// It was previously spelled "v3" in the window title and the Welcome
/// subtitle, "3.2" in Info.plist, and "Computing Stack v3" in the sidebar —
/// four literals, none agreeing, all stale against the released 3.6.
///
/// Collapsing those to a Swift constant left two (constant + plist). Reading
/// `CFBundleShortVersionString` from `Bundle.main` fixed packaged `.app`
/// runs, but unpackaged `swift run` still showed SPM's synthetic "1.0" and
/// never reached a "0.0-dev" fallback — nil coalescing does not fire when
/// the key is present with the wrong value.
///
/// This file is the single source of truth. `package_app.sh` stamps
/// `CFBundleShortVersionString` and `CFBundleVersion` in the assembled
/// Info.plist from `CodexInfo.version`. Bump **here** when cutting a
/// release; do not reintroduce a second hand-edited marketing version
/// elsewhere in the tree.
enum CodexInfo {
    static let version = "3.6.25"
}
