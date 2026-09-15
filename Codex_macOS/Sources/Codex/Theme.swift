import SwiftUI

/// Design tokens, resolved against whichever palette is active.
///
/// **Why these are `static var` and not `static let`.** They used to be 292
/// compile-time constants — a flat namespace of literal `Color(red:green:blue:)`
/// values referenced across ten files. Nothing was observable, so nothing could
/// change at runtime, and adding a theme picker looked like it meant editing
/// every one of those 292 call sites.
///
/// It doesn't. Only what `Theme.base` *means* has to change, not how it is
/// spelled. Each token is now a computed property reading the current
/// `Palette`, so every existing call site keeps working untouched and the whole
/// diff stays inside this file and `Palettes.swift`.
///
/// The raw accent names (`Theme.mauve`, `Theme.peach`) survive deliberately.
/// A semantic rename was on the plan for this stage and turned out to be
/// unnecessary: every palette defines all fourteen accent tokens, so
/// `Theme.mauve` resolves to *that scheme's* purple rather than to a
/// Catppuccin colour stranded in a Nord window. The names would only be
/// arbitrary if some palette left them undefined, and none does.
enum Theme {

    // MARK: Active palette

    /// The palette every token below reads from.
    ///
    /// Plain mutable state rather than an `ObservableObject`, because these
    /// tokens are read as `Theme.base` from inside view bodies — a form with
    /// nowhere to hang an `@ObservedObject`. `Preferences` owns the choice and
    /// writes it here; `Preferences.revision` is what tells SwiftUI to redraw.
    static var palette: Palette = .mocha

    /// Multiplier applied to every text size. See `size(_:)`.
    static var fontScale: CGFloat = 1.0

    // MARK: Surfaces
    static var crust: Color    { palette.crust }
    static var mantle: Color   { palette.mantle }
    static var base: Color     { palette.base }
    static var surface0: Color { palette.surface0 }
    static var surface1: Color { palette.surface1 }
    static var surface2: Color { palette.surface2 }
    static var overlay0: Color { palette.overlay0 }
    static var overlay1: Color { palette.overlay1 }
    static var overlay2: Color { palette.overlay2 }

    // MARK: Text
    static var text: Color    { palette.text }
    static var subtext: Color { palette.subtext }
    static var subtle: Color  { palette.subtle }

    // MARK: Accent palette
    static var blue: Color      { palette.blue }
    static var lavender: Color  { palette.lavender }
    static var sapphire: Color  { palette.sapphire }
    static var sky: Color       { palette.sky }
    static var teal: Color      { palette.teal }
    static var green: Color     { palette.green }
    static var yellow: Color    { palette.yellow }
    static var peach: Color     { palette.peach }
    static var red: Color       { palette.red }
    static var maroon: Color    { palette.maroon }
    static var mauve: Color     { palette.mauve }
    static var pink: Color      { palette.pink }
    static var flamingo: Color  { palette.flamingo }
    static var rosewater: Color { palette.rosewater }

    // MARK: Semantic
    static var accent: Color       { blue }
    static var accentSoft: Color   { blue.opacity(0.18) }
    static var accentSofter: Color { blue.opacity(0.08) }
    static var separator: Color    { surface0.opacity(0.65) }
    static var hairline: Color     { surface1.opacity(0.45) }

    // MARK: Band tints (sidebar section accents)
    static func bandTint(_ band: String) -> Color {
        switch band {
        case "Foundations":    return teal
        case "Compute":        return blue
        case "Network":        return mauve
        case "Cross-cutting":  return peach
        case "Top-level":      return rosewater
        // A "Tools" case lived here for months with no matching directory and
        // no entry in CodexTree.bands — a tint for a band that never existed.
        default:               return overlay1
        }
    }

    // MARK: Type scale

    /// Scale a text size by the user's font preference.
    ///
    /// **Text only.** Of this app's 84 inline `.system(size:)` calls, exactly
    /// half set the size of an SF Symbol rather than of type — and those
    /// glyphs sit inside fixed frames (`.frame(width: 14, height: 14)` around
    /// a 9pt `xmark`, for instance). Scaling them would push the icon against
    /// a box that did not grow with it. "Adjust the font" means the text you
    /// read, so the chrome iconography keeps its literal sizes and only type
    /// moves.
    static func size(_ points: CGFloat) -> CGFloat { points * fontScale }

    /// Typography (SF Pro via `.system`, monospaced via `.monospaced`).
    ///
    /// Computed rather than stored, so a scale change reaches them. Every
    /// entry routes through `size(_:)`.
    enum FontStyle {
        static var appTitle: Font     { .system(size: Theme.size(28), weight: .bold,     design: .default) }
        static var displayLarge: Font { .system(size: Theme.size(36), weight: .bold,     design: .default) }
        static var display: Font      { .system(size: Theme.size(24), weight: .bold,     design: .default) }
        static var title: Font        { .system(size: Theme.size(19), weight: .semibold, design: .default) }
        static var headline: Font     { .system(size: Theme.size(15), weight: .semibold, design: .default) }
        static var subhead: Font      { .system(size: Theme.size(13), weight: .medium,   design: .default) }
        static var body: Font         { .system(size: Theme.size(14), weight: .regular,  design: .default) }
        static var callout: Font      { .system(size: Theme.size(13), weight: .regular,  design: .default) }
        static var footnote: Font     { .system(size: Theme.size(11), weight: .regular,  design: .default) }
        static var caption: Font      { .system(size: Theme.size(10), weight: .medium,   design: .default) }
        static var mono: Font         { .system(size: Theme.size(12.5), design: .monospaced) }
        static var monoSmall: Font    { .system(size: Theme.size(11), design: .monospaced) }

        // Heading scale for the markdown renderer
        static var h1: Font { .system(size: Theme.size(28), weight: .bold,     design: .default) }
        static var h2: Font { .system(size: Theme.size(22), weight: .semibold, design: .default) }
        static var h3: Font { .system(size: Theme.size(18), weight: .semibold, design: .default) }
        static var h4: Font { .system(size: Theme.size(15), weight: .semibold, design: .default) }
        static var h5: Font { .system(size: Theme.size(13), weight: .semibold, design: .default) }
        static var h6: Font { .system(size: Theme.size(12), weight: .semibold, design: .default) }
    }

    // MARK: Page geometry
    //
    // The document pane and the Welcome screen each carried their own numbers
    // — 920pt wide with 48pt gutters against 980pt with 40pt — so the two
    // screens never lined up with each other. One source now; the width
    // itself is a user preference (Preferences.ColumnWidth).
    enum Layout {
        /// Space between the column edge and the text inside it.
        static let gutter: CGFloat = 48
        /// Space above and below the column's content.
        static let vertical: CGFloat = 32
    }

    // MARK: Radii
    enum Radius {
        static let small:  CGFloat = 6
        static let medium: CGFloat = 10
        static let large:  CGFloat = 14
        static let xlarge: CGFloat = 20
    }
}
