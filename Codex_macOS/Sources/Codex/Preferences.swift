import SwiftUI

// MARK: - User preferences

/// Appearance preferences, persisted separately from bookmarks.
///
/// **Why a second file rather than a field on `Bookmarks`.** `Bookmarks.load()`
/// decodes with `try?` and falls back to an empty value on any error, and
/// Swift's synthesised `init(from:)` calls `decode`, not `decodeIfPresent` —
/// property defaults are *not* applied to missing keys. Adding a preference to
/// that struct would therefore make every `state.json` written by an earlier
/// build throw `keyNotFound`, and the user's pinned files and recents would be
/// silently replaced with empty arrays on the first launch after the update.
///
/// So preferences live in their own file, and both files decode tolerantly:
/// each key is read with `decodeIfPresent` and falls back to its default, so a
/// file written by any version — older or newer — loads without losing what it
/// does understand.
final class Preferences: ObservableObject {
    static let shared = Preferences()

    // MARK: Reading column width

    /// How wide the reading column is allowed to grow.
    ///
    /// The measure matters more than the window: prose is hard to read much
    /// past ~90 characters a line because the eye loses its place on the
    /// return sweep. `comfortable` is the previous hardcoded 920pt, kept as
    /// the default so nobody's layout changes without asking.
    enum ColumnWidth: String, CaseIterable, Identifiable {
        case narrow, comfortable, wide, full

        var id: String { rawValue }

        /// `nil` means "fill the pane" — no cap at all.
        var points: CGFloat? {
            switch self {
            case .narrow:      return 720
            case .comfortable: return 920
            case .wide:        return 1140
            case .full:        return nil
            }
        }

        var label: String {
            switch self {
            case .narrow:      return "Narrow"
            case .comfortable: return "Comfortable"
            case .wide:        return "Wide"
            case .full:        return "Full Width"
            }
        }
    }

    @Published var columnWidth: ColumnWidth = .comfortable { didSet { save() } }

    // MARK: Appearance

    /// Which colour scheme, by `Palette.id`.
    @Published var themeID: String = Palette.mocha.id {
        didSet { apply(); bump(); save() }
    }

    /// True-black backgrounds on whichever dark scheme is active.
    ///
    /// A modifier rather than a scheme of its own, so it composes with every
    /// dark palette instead of doubling the list. (Ten of the fourteen are
    /// dark; the count is not repeated in prose anywhere, because the last
    /// time it was it went stale.) No effect on a light palette, where true
    /// black is not what anyone means by OLED.
    @Published var oled: Bool = false {
        didSet { apply(); bump(); save() }
    }

    /// Text size multiplier. Icon glyphs deliberately do not follow it — see
    /// `Theme.size(_:)`.
    @Published var fontScale: Double = 1.0 {
        didSet { apply(); bump(); save() }
    }

    static let fontScaleRange: ClosedRange<Double> = 0.85...1.40
    static let fontScaleStep: Double = 0.05

    /// Bumped on every appearance change.
    ///
    /// **Why any of this is needed.** `Theme.base` is a plain computed
    /// property, not a `@Published` one, so SwiftUI has no dependency on it
    /// and no reason to believe a view reading it is stale when the palette
    /// changes. Something has to tell it.
    ///
    /// The first attempt keyed `.id()` on this counter at `RootView`, which
    /// did force the redraw — by discarding the identity of every descendant,
    /// and with it the sidebar's expanded rows, the inspector's selected tab
    /// and every scroll position. Correct colours, reset app.
    ///
    /// So instead each of the 40 views that reads `Theme.*` observes this
    /// object directly. Their bodies re-evaluate and re-read the tokens;
    /// their identities, and therefore their `@State`, survive untouched.
    /// The counter remains because a change to `themeID` alone would not
    /// notify observers when the *resolved* palette is what moved (an OLED
    /// toggle, for instance).
    @Published private(set) var revision: Int = 0

    /// The palette in effect, OLED applied.
    var palette: Palette {
        let scheme = Palette.named(themeID) ?? .mocha
        return oled ? scheme.oled : scheme
    }

    /// Push the current choices into `Theme`, which is where every view reads.
    private func apply() {
        Theme.palette = palette
        Theme.fontScale = CGFloat(fontScale)
    }

    private func bump() { revision &+= 1 }

    func nudgeFontScale(by delta: Double) {
        let next = (fontScale + delta)
        fontScale = min(max(next, Preferences.fontScaleRange.lowerBound),
                        Preferences.fontScaleRange.upperBound)
    }

    // MARK: Persistence

    private struct Stored: Codable {
        var columnWidth: String?
        var themeID: String?
        var oled: Bool?
        var fontScale: Double?
    }

    private static var storeURL: URL {
        let dir = FileManager.default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            .appendingPathComponent("Codex", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("preferences.json")
    }

    private init() {
        defer { apply() }
        guard let data = try? Data(contentsOf: Preferences.storeURL),
              let stored = try? JSONDecoder().decode(Stored.self, from: data) else { return }
        // Each key falls back on its own. A preferences file from a newer build
        // naming a width or a scheme this version does not have should cost
        // that one setting, not all of them — and never the whole file.
        if let raw = stored.columnWidth, let w = ColumnWidth(rawValue: raw) { columnWidth = w }
        if let raw = stored.themeID, Palette.named(raw) != nil { themeID = raw }
        if let flag = stored.oled { oled = flag }
        if let scale = stored.fontScale {
            fontScale = min(max(scale, Preferences.fontScaleRange.lowerBound),
                            Preferences.fontScaleRange.upperBound)
        }
    }

    private func save() {
        let stored = Stored(columnWidth: columnWidth.rawValue,
                            themeID: themeID,
                            oled: oled,
                            fontScale: fontScale)
        guard let data = try? JSONEncoder().encode(stored) else { return }
        // Atomic: a crash mid-write leaves the previous file intact rather
        // than a truncated one that fails to parse.
        try? data.write(to: Preferences.storeURL, options: .atomic)
    }
}
