# Version SSOT

Marketing version single source of truth:

- **`Codex_macOS/Sources/Codex/Version.swift`** — `CodexInfo.version`
- **`package_app.sh`** stamps `CFBundleShortVersionString` / `CFBundleVersion` from that constant when assembling the `.app`

`Info.plist` is stamped, not hand-edited SSOT.

The v3.6.25 section of `CHANGELOG.md` still has one outdated sentence claiming `CFBundleShortVersionString` is the SSOT; correct it to point here when convenient.
