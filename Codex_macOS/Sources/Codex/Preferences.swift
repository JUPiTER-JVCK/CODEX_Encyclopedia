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

    // MARK: Persistence

    private struct Stored: Codable {
        var columnWidth: String?
    }

    private static var storeURL: URL {
        let dir = FileManager.default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            .appendingPathComponent("Codex", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("preferences.json")
    }

    private init() {
        guard let data = try? Data(contentsOf: Preferences.storeURL),
              let stored = try? JSONDecoder().decode(Stored.self, from: data) else { return }
        // Unknown values fall back rather than failing the whole load — a
        // preferences file from a newer build naming a width this version does
        // not have should cost that one setting, not all of them.
        if let raw = stored.columnWidth, let w = ColumnWidth(rawValue: raw) {
            columnWidth = w
        }
    }

    private func save() {
        let stored = Stored(columnWidth: columnWidth.rawValue)
        guard let data = try? JSONEncoder().encode(stored) else { return }
        // Atomic: a crash mid-write leaves the previous file intact rather
        // than a truncated one that fails to parse.
        try? data.write(to: Preferences.storeURL, options: .atomic)
    }
}
