import SwiftUI

// MARK: - Hex

extension Color {
    /// `Color("#1e1e2e")`. Invalid input yields magenta rather than crashing —
    /// a wrong colour is visible in a screenshot; a crash on launch is not.
    init(hex: String) {
        let s = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
        guard s.count == 6, let v = UInt32(s, radix: 16) else {
            self = Color(red: 1, green: 0, blue: 1)
            return
        }
        self.init(red:   Double((v >> 16) & 0xFF) / 255.0,
                  green: Double((v >>  8) & 0xFF) / 255.0,
                  blue:  Double( v        & 0xFF) / 255.0)
    }
}

// MARK: - Palette

/// One complete colour scheme.
///
/// The token names are Catppuccin's, because that is what the app was built
/// against and what its 292 `Theme.*` call sites already spell. Every other
/// scheme here is *mapped* onto those names rather than renaming anything —
/// which is the only reason a palette swap costs no call-site changes at all.
///
/// The mapping is a judgement call where a scheme has fewer accents than
/// Catppuccin's fourteen. Nord has nine usable accents, Gruvbox seven,
/// Solarized eight; in those schemes some tokens necessarily share a colour
/// (`red`/`maroon`, `mauve`/`pink`). That is a deliberate approximation, not
/// an oversight — the alternative is inventing colours the scheme's authors
/// never chose, which would look worse than a repeat.
struct Palette: Identifiable, Equatable {
    let id: String
    let name: String
    /// Drives `preferredColorScheme`, so macOS renders controls and the
    /// vibrancy materials to match rather than fighting the palette.
    let isDark: Bool

    // Surfaces, darkest to lightest on a dark scheme (inverted on a light one)
    let crust: Color, mantle: Color, base: Color
    let surface0: Color, surface1: Color, surface2: Color
    let overlay0: Color, overlay1: Color, overlay2: Color

    // Text
    let text: Color, subtext: Color, subtle: Color

    // Accents
    let blue: Color, lavender: Color, sapphire: Color, sky: Color
    let teal: Color, green: Color, yellow: Color, peach: Color
    let red: Color, maroon: Color, mauve: Color, pink: Color
    let flamingo: Color, rosewater: Color

    static func == (a: Palette, b: Palette) -> Bool { a.id == b.id }
}

// MARK: - OLED

extension Palette {
    /// True-black variant of a dark palette.
    ///
    /// A modifier rather than fourteen more palettes: OLED is orthogonal to
    /// which scheme you picked, so composing it keeps the list honest instead
    /// of doubling it. Only the three page-background tokens go to black; the
    /// surface and overlay steps keep the scheme's own values, because those
    /// are what separate a card from its page — flattening them too would make
    /// every border vanish.
    ///
    /// No-op on a light palette, where true black is not what anyone means.
    var oled: Palette {
        guard isDark else { return self }
        return Palette(
            id: id + "-oled", name: name + " (OLED)", isDark: true,
            crust: Color(hex: "#000000"),
            mantle: Color(hex: "#000000"),
            base: Color(hex: "#000000"),
            surface0: surface0, surface1: surface1, surface2: surface2,
            overlay0: overlay0, overlay1: overlay1, overlay2: overlay2,
            text: text, subtext: subtext, subtle: subtle,
            blue: blue, lavender: lavender, sapphire: sapphire, sky: sky,
            teal: teal, green: green, yellow: yellow, peach: peach,
            red: red, maroon: maroon, mauve: mauve, pink: pink,
            flamingo: flamingo, rosewater: rosewater
        )
    }
}

// MARK: - The schemes
//
// Licences are recorded in THIRD_PARTY.md at the repository root. All are
// permissive; every one is reproduced here as colour values only, which is
// the whole of what these projects publish.

extension Palette {

    // ── Catppuccin ─────────────────────────────────────────────────────
    // https://github.com/catppuccin/catppuccin — MIT

    static let mocha = Palette(
        id: "mocha", name: "Catppuccin Mocha", isDark: true,
        crust: Color(hex: "#11111b"), mantle: Color(hex: "#181825"), base: Color(hex: "#1e1e2e"),
        surface0: Color(hex: "#313244"), surface1: Color(hex: "#45475a"), surface2: Color(hex: "#585b70"),
        overlay0: Color(hex: "#6c7086"), overlay1: Color(hex: "#7f849c"), overlay2: Color(hex: "#9399b2"),
        text: Color(hex: "#cdd6f4"), subtext: Color(hex: "#a6adc8"), subtle: Color(hex: "#bac2de"),
        blue: Color(hex: "#89b4fa"), lavender: Color(hex: "#b4befe"), sapphire: Color(hex: "#74c7ec"), sky: Color(hex: "#89dceb"),
        teal: Color(hex: "#94e2d5"), green: Color(hex: "#a6e3a1"), yellow: Color(hex: "#f9e2af"), peach: Color(hex: "#fab387"),
        red: Color(hex: "#f38ba8"), maroon: Color(hex: "#eba0ac"), mauve: Color(hex: "#cba6f7"), pink: Color(hex: "#f5c2e7"),
        flamingo: Color(hex: "#f2cdcd"), rosewater: Color(hex: "#f5e0dc"))

    static let macchiato = Palette(
        id: "macchiato", name: "Catppuccin Macchiato", isDark: true,
        crust: Color(hex: "#181926"), mantle: Color(hex: "#1e2030"), base: Color(hex: "#24273a"),
        surface0: Color(hex: "#363a4f"), surface1: Color(hex: "#494d64"), surface2: Color(hex: "#5b6078"),
        overlay0: Color(hex: "#6e738d"), overlay1: Color(hex: "#8087a2"), overlay2: Color(hex: "#939ab7"),
        text: Color(hex: "#cad3f5"), subtext: Color(hex: "#a5adcb"), subtle: Color(hex: "#b8c0e0"),
        blue: Color(hex: "#8aadf4"), lavender: Color(hex: "#b7bdf8"), sapphire: Color(hex: "#7dc4e4"), sky: Color(hex: "#91d7e3"),
        teal: Color(hex: "#8bd5ca"), green: Color(hex: "#a6da95"), yellow: Color(hex: "#eed49f"), peach: Color(hex: "#f5a97f"),
        red: Color(hex: "#ed8796"), maroon: Color(hex: "#ee99a0"), mauve: Color(hex: "#c6a0f6"), pink: Color(hex: "#f5bde6"),
        flamingo: Color(hex: "#f0c6c6"), rosewater: Color(hex: "#f4dbd6"))

    static let frappe = Palette(
        id: "frappe", name: "Catppuccin Frappé", isDark: true,
        crust: Color(hex: "#232634"), mantle: Color(hex: "#292c3c"), base: Color(hex: "#303446"),
        surface0: Color(hex: "#414559"), surface1: Color(hex: "#51576d"), surface2: Color(hex: "#626880"),
        overlay0: Color(hex: "#737994"), overlay1: Color(hex: "#838ba7"), overlay2: Color(hex: "#949cbb"),
        text: Color(hex: "#c6d0f5"), subtext: Color(hex: "#a5adce"), subtle: Color(hex: "#b5bfe2"),
        blue: Color(hex: "#8caaee"), lavender: Color(hex: "#babbf1"), sapphire: Color(hex: "#85c1dc"), sky: Color(hex: "#99d1db"),
        teal: Color(hex: "#81c8be"), green: Color(hex: "#a6d189"), yellow: Color(hex: "#e5c890"), peach: Color(hex: "#ef9f76"),
        red: Color(hex: "#e78284"), maroon: Color(hex: "#ea999c"), mauve: Color(hex: "#ca9ee6"), pink: Color(hex: "#f4b8e4"),
        flamingo: Color(hex: "#eebebe"), rosewater: Color(hex: "#f2d5cf"))

    static let latte = Palette(
        id: "latte", name: "Catppuccin Latte", isDark: false,
        crust: Color(hex: "#dce0e8"), mantle: Color(hex: "#e6e9ef"), base: Color(hex: "#eff1f5"),
        surface0: Color(hex: "#ccd0da"), surface1: Color(hex: "#bcc0cc"), surface2: Color(hex: "#acb0be"),
        overlay0: Color(hex: "#9ca0b0"), overlay1: Color(hex: "#8c8fa1"), overlay2: Color(hex: "#7c7f93"),
        text: Color(hex: "#4c4f69"), subtext: Color(hex: "#6c6f85"), subtle: Color(hex: "#5c5f77"),
        blue: Color(hex: "#1e66f5"), lavender: Color(hex: "#7287fd"), sapphire: Color(hex: "#209fb5"), sky: Color(hex: "#04a5e5"),
        teal: Color(hex: "#179299"), green: Color(hex: "#40a02b"), yellow: Color(hex: "#df8e1d"), peach: Color(hex: "#fe640b"),
        red: Color(hex: "#d20f39"), maroon: Color(hex: "#e64553"), mauve: Color(hex: "#8839ef"), pink: Color(hex: "#ea76cb"),
        flamingo: Color(hex: "#dd7878"), rosewater: Color(hex: "#dc8a78"))

    // ── Nord ───────────────────────────────────────────────────────────
    // https://github.com/nordtheme/nord — MIT
    // Nine accents (frost ×4, aurora ×5), so maroon repeats red and
    // pink/flamingo/rosewater fall back to the snow-storm greys.

    static let nord = Palette(
        id: "nord", name: "Nord", isDark: true,
        crust: Color(hex: "#242933"), mantle: Color(hex: "#2e3440"), base: Color(hex: "#323844"),
        surface0: Color(hex: "#3b4252"), surface1: Color(hex: "#434c5e"), surface2: Color(hex: "#4c566a"),
        overlay0: Color(hex: "#616e88"), overlay1: Color(hex: "#6e7d9b"), overlay2: Color(hex: "#7b8bad"),
        text: Color(hex: "#eceff4"), subtext: Color(hex: "#d8dee9"), subtle: Color(hex: "#e5e9f0"),
        blue: Color(hex: "#81a1c1"), lavender: Color(hex: "#b48ead"), sapphire: Color(hex: "#5e81ac"), sky: Color(hex: "#88c0d0"),
        teal: Color(hex: "#8fbcbb"), green: Color(hex: "#a3be8c"), yellow: Color(hex: "#ebcb8b"), peach: Color(hex: "#d08770"),
        red: Color(hex: "#bf616a"), maroon: Color(hex: "#bf616a"), mauve: Color(hex: "#b48ead"), pink: Color(hex: "#b48ead"),
        flamingo: Color(hex: "#d8dee9"), rosewater: Color(hex: "#eceff4"))

    // ── Gruvbox ────────────────────────────────────────────────────────
    // https://github.com/morhetz/gruvbox — MIT
    // Seven accents; aqua serves teal and sky, orange serves peach.

    static let gruvboxDark = Palette(
        id: "gruvbox-dark", name: "Gruvbox Dark", isDark: true,
        crust: Color(hex: "#1d2021"), mantle: Color(hex: "#242526"), base: Color(hex: "#282828"),
        surface0: Color(hex: "#3c3836"), surface1: Color(hex: "#504945"), surface2: Color(hex: "#665c54"),
        overlay0: Color(hex: "#7c6f64"), overlay1: Color(hex: "#928374"), overlay2: Color(hex: "#a89984"),
        text: Color(hex: "#ebdbb2"), subtext: Color(hex: "#bdae93"), subtle: Color(hex: "#d5c4a1"),
        blue: Color(hex: "#83a598"), lavender: Color(hex: "#d3869b"), sapphire: Color(hex: "#458588"), sky: Color(hex: "#8ec07c"),
        teal: Color(hex: "#8ec07c"), green: Color(hex: "#b8bb26"), yellow: Color(hex: "#fabd2f"), peach: Color(hex: "#fe8019"),
        red: Color(hex: "#fb4934"), maroon: Color(hex: "#cc241d"), mauve: Color(hex: "#d3869b"), pink: Color(hex: "#d3869b"),
        flamingo: Color(hex: "#d5c4a1"), rosewater: Color(hex: "#ebdbb2"))

    static let gruvboxLight = Palette(
        id: "gruvbox-light", name: "Gruvbox Light", isDark: false,
        crust: Color(hex: "#f2e5bc"), mantle: Color(hex: "#f9f5d7"), base: Color(hex: "#fbf1c7"),
        surface0: Color(hex: "#ebdbb2"), surface1: Color(hex: "#d5c4a1"), surface2: Color(hex: "#bdae93"),
        overlay0: Color(hex: "#a89984"), overlay1: Color(hex: "#928374"), overlay2: Color(hex: "#7c6f64"),
        text: Color(hex: "#3c3836"), subtext: Color(hex: "#504945"), subtle: Color(hex: "#665c54"),
        blue: Color(hex: "#076678"), lavender: Color(hex: "#8f3f71"), sapphire: Color(hex: "#427b58"), sky: Color(hex: "#427b58"),
        teal: Color(hex: "#427b58"), green: Color(hex: "#79740e"), yellow: Color(hex: "#b57614"), peach: Color(hex: "#af3a03"),
        red: Color(hex: "#9d0006"), maroon: Color(hex: "#cc241d"), mauve: Color(hex: "#8f3f71"), pink: Color(hex: "#8f3f71"),
        flamingo: Color(hex: "#665c54"), rosewater: Color(hex: "#504945"))

    // ── Solarized ──────────────────────────────────────────────────────
    // https://github.com/altercation/solarized — MIT
    // Eight accents, shared between the light and dark variants by design —
    // only the eight monotones swap.

    static let solarizedDark = Palette(
        id: "solarized-dark", name: "Solarized Dark", isDark: true,
        crust: Color(hex: "#00212b"), mantle: Color(hex: "#002731"), base: Color(hex: "#002b36"),
        surface0: Color(hex: "#073642"), surface1: Color(hex: "#0d4653"), surface2: Color(hex: "#265866"),
        overlay0: Color(hex: "#586e75"), overlay1: Color(hex: "#657b83"), overlay2: Color(hex: "#839496"),
        text: Color(hex: "#93a1a1"), subtext: Color(hex: "#839496"), subtle: Color(hex: "#eee8d5"),
        blue: Color(hex: "#268bd2"), lavender: Color(hex: "#6c71c4"), sapphire: Color(hex: "#2aa198"), sky: Color(hex: "#2aa198"),
        teal: Color(hex: "#2aa198"), green: Color(hex: "#859900"), yellow: Color(hex: "#b58900"), peach: Color(hex: "#cb4b16"),
        red: Color(hex: "#dc322f"), maroon: Color(hex: "#cb4b16"), mauve: Color(hex: "#6c71c4"), pink: Color(hex: "#d33682"),
        flamingo: Color(hex: "#d33682"), rosewater: Color(hex: "#eee8d5"))

    static let solarizedLight = Palette(
        id: "solarized-light", name: "Solarized Light", isDark: false,
        crust: Color(hex: "#e8e2cf"), mantle: Color(hex: "#eee8d5"), base: Color(hex: "#fdf6e3"),
        surface0: Color(hex: "#eee8d5"), surface1: Color(hex: "#ddd6c1"), surface2: Color(hex: "#c9c3ae"),
        overlay0: Color(hex: "#93a1a1"), overlay1: Color(hex: "#839496"), overlay2: Color(hex: "#657b83"),
        text: Color(hex: "#586e75"), subtext: Color(hex: "#657b83"), subtle: Color(hex: "#073642"),
        blue: Color(hex: "#268bd2"), lavender: Color(hex: "#6c71c4"), sapphire: Color(hex: "#2aa198"), sky: Color(hex: "#2aa198"),
        teal: Color(hex: "#2aa198"), green: Color(hex: "#859900"), yellow: Color(hex: "#b58900"), peach: Color(hex: "#cb4b16"),
        red: Color(hex: "#dc322f"), maroon: Color(hex: "#cb4b16"), mauve: Color(hex: "#6c71c4"), pink: Color(hex: "#d33682"),
        flamingo: Color(hex: "#d33682"), rosewater: Color(hex: "#073642"))

    // ── Tokyo Night ────────────────────────────────────────────────────
    // https://github.com/enkia/tokyo-night-vscode-theme — MIT

    static let tokyoNight = Palette(
        id: "tokyo-night", name: "Tokyo Night", isDark: true,
        crust: Color(hex: "#16161e"), mantle: Color(hex: "#1a1b26"), base: Color(hex: "#1f2335"),
        surface0: Color(hex: "#292e42"), surface1: Color(hex: "#3b4261"), surface2: Color(hex: "#414868"),
        overlay0: Color(hex: "#565f89"), overlay1: Color(hex: "#6e7aa5"), overlay2: Color(hex: "#8a94bd"),
        text: Color(hex: "#c0caf5"), subtext: Color(hex: "#a9b1d6"), subtle: Color(hex: "#b4c2f0"),
        blue: Color(hex: "#7aa2f7"), lavender: Color(hex: "#bb9af7"), sapphire: Color(hex: "#2ac3de"), sky: Color(hex: "#7dcfff"),
        teal: Color(hex: "#73daca"), green: Color(hex: "#9ece6a"), yellow: Color(hex: "#e0af68"), peach: Color(hex: "#ff9e64"),
        red: Color(hex: "#f7768e"), maroon: Color(hex: "#db4b4b"), mauve: Color(hex: "#bb9af7"), pink: Color(hex: "#ff007c"),
        flamingo: Color(hex: "#ffc777"), rosewater: Color(hex: "#c0caf5"))

    // ── Dracula ────────────────────────────────────────────────────────
    // https://github.com/dracula/dracula-theme — MIT

    static let dracula = Palette(
        id: "dracula", name: "Dracula", isDark: true,
        crust: Color(hex: "#191a21"), mantle: Color(hex: "#21222c"), base: Color(hex: "#282a36"),
        surface0: Color(hex: "#343746"), surface1: Color(hex: "#44475a"), surface2: Color(hex: "#565a70"),
        overlay0: Color(hex: "#6272a4"), overlay1: Color(hex: "#7482b5"), overlay2: Color(hex: "#8b96c4"),
        text: Color(hex: "#f8f8f2"), subtext: Color(hex: "#d4d4cf"), subtle: Color(hex: "#e8e8e3"),
        blue: Color(hex: "#8be9fd"), lavender: Color(hex: "#bd93f9"), sapphire: Color(hex: "#62d6e8"), sky: Color(hex: "#8be9fd"),
        teal: Color(hex: "#50fa7b"), green: Color(hex: "#50fa7b"), yellow: Color(hex: "#f1fa8c"), peach: Color(hex: "#ffb86c"),
        red: Color(hex: "#ff5555"), maroon: Color(hex: "#e35a5a"), mauve: Color(hex: "#bd93f9"), pink: Color(hex: "#ff79c6"),
        flamingo: Color(hex: "#ffb8d1"), rosewater: Color(hex: "#f8f8f2"))

    // ── Rosé Pine ──────────────────────────────────────────────────────
    // https://github.com/rose-pine/rose-pine-theme — MIT
    // Six accents (love, gold, rose, pine, foam, iris), so several tokens
    // share by design; this scheme is deliberately narrow.

    static let rosePine = Palette(
        id: "rose-pine", name: "Rosé Pine", isDark: true,
        crust: Color(hex: "#16141f"), mantle: Color(hex: "#1f1d2e"), base: Color(hex: "#191724"),
        surface0: Color(hex: "#26233a"), surface1: Color(hex: "#312e45"), surface2: Color(hex: "#403d55"),
        overlay0: Color(hex: "#6e6a86"), overlay1: Color(hex: "#807c9a"), overlay2: Color(hex: "#908caa"),
        text: Color(hex: "#e0def4"), subtext: Color(hex: "#908caa"), subtle: Color(hex: "#cdcbe0"),
        blue: Color(hex: "#9ccfd8"), lavender: Color(hex: "#c4a7e7"), sapphire: Color(hex: "#31748f"), sky: Color(hex: "#9ccfd8"),
        teal: Color(hex: "#31748f"), green: Color(hex: "#31748f"), yellow: Color(hex: "#f6c177"), peach: Color(hex: "#ebbcba"),
        red: Color(hex: "#eb6f92"), maroon: Color(hex: "#b4637a"), mauve: Color(hex: "#c4a7e7"), pink: Color(hex: "#ebbcba"),
        flamingo: Color(hex: "#ebbcba"), rosewater: Color(hex: "#e0def4"))

    static let rosePineMoon = Palette(
        id: "rose-pine-moon", name: "Rosé Pine Moon", isDark: true,
        crust: Color(hex: "#1f1d2e"), mantle: Color(hex: "#2a273f"), base: Color(hex: "#232136"),
        surface0: Color(hex: "#393552"), surface1: Color(hex: "#44415f"), surface2: Color(hex: "#56526e"),
        overlay0: Color(hex: "#6e6a86"), overlay1: Color(hex: "#817c9c"), overlay2: Color(hex: "#908caa"),
        text: Color(hex: "#e0def4"), subtext: Color(hex: "#908caa"), subtle: Color(hex: "#cdcbe0"),
        blue: Color(hex: "#9ccfd8"), lavender: Color(hex: "#c4a7e7"), sapphire: Color(hex: "#3e8fb0"), sky: Color(hex: "#9ccfd8"),
        teal: Color(hex: "#3e8fb0"), green: Color(hex: "#3e8fb0"), yellow: Color(hex: "#f6c177"), peach: Color(hex: "#ea9a97"),
        red: Color(hex: "#eb6f92"), maroon: Color(hex: "#b4637a"), mauve: Color(hex: "#c4a7e7"), pink: Color(hex: "#ea9a97"),
        flamingo: Color(hex: "#ea9a97"), rosewater: Color(hex: "#e0def4"))

    static let rosePineDawn = Palette(
        id: "rose-pine-dawn", name: "Rosé Pine Dawn", isDark: false,
        crust: Color(hex: "#f2e9e1"), mantle: Color(hex: "#fffaf3"), base: Color(hex: "#faf4ed"),
        surface0: Color(hex: "#f2e9e1"), surface1: Color(hex: "#e5ded5"), surface2: Color(hex: "#d7d0c7"),
        overlay0: Color(hex: "#9893a5"), overlay1: Color(hex: "#8a8598"), overlay2: Color(hex: "#797593"),
        text: Color(hex: "#575279"), subtext: Color(hex: "#797593"), subtle: Color(hex: "#4a4460"),
        blue: Color(hex: "#56949f"), lavender: Color(hex: "#907aa9"), sapphire: Color(hex: "#286983"), sky: Color(hex: "#56949f"),
        teal: Color(hex: "#286983"), green: Color(hex: "#286983"), yellow: Color(hex: "#ea9d34"), peach: Color(hex: "#d7827e"),
        red: Color(hex: "#b4637a"), maroon: Color(hex: "#9c4f65"), mauve: Color(hex: "#907aa9"), pink: Color(hex: "#d7827e"),
        flamingo: Color(hex: "#d7827e"), rosewater: Color(hex: "#575279"))

    /// Every scheme, in the order the picker shows them.
    static let all: [Palette] = [
        mocha, macchiato, frappe, latte,
        nord, tokyoNight, dracula,
        gruvboxDark, gruvboxLight,
        solarizedDark, solarizedLight,
        rosePine, rosePineMoon, rosePineDawn,
    ]

    static func named(_ id: String) -> Palette? { all.first { $0.id == id } }
}
