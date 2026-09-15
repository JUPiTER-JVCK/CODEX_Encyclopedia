# Codex_macOS — Native SwiftUI Reader

A real macOS app that browses the codex. No Terminal, no Python — pure
SwiftUI rendering the markdown tree straight on the GPU.

## What you get

- **Translucent vibrancy sidebar** (`NSVisualEffectView`, `.sidebar` material)
  grouped into bands, with a pinned section
- **Top toolbar** — sidebar toggle, browser-style back/forward, clickable
  breadcrumb (`Codex › Layer › Section › File`), palette trigger, pin button,
  inspector toggle
- **Safari-style tab strip** with hover-close and smart titles (first H1,
  falling back to the filename)
- **Three-tab inspector** — Outline (the document's TOC), Info (size,
  modified, line count, YAML tags, reveal/copy-path/pin actions), Recents
- **Welcome screen** — hero, stats, quick-action cards, recents, and a
  "browse by band" grid tinted per band
- **Custom markdown renderer** — headings, fenced code with a language pill
  and hover-to-copy, lists, pipe tables, blockquotes, rules, inline images
- **Cross-document links** — `[text](path.md)` opens in a new in-app tab;
  `http(s)` opens in your browser
- **⌘P command palette** — fuzzy file matching across the whole codex
- **Right-click sidebar menu** — Open / Open in New Tab / Pin / Reveal in
  Finder / Copy Path
- **Nested lists** — sub-items keep their indentation, with the marker glyph
  cycling by depth and ordered lists restarting their count per level
- **Parsed once per revision** — `DocumentStore` caches read-and-parsed
  documents on path + modification date, so scrolling, switching tabs, and
  toggling panels don't re-read or re-parse anything
- **Bookmarks + recents** persisted to
  `~/Library/Application Support/Codex/state.json`
- **Portable bundle** — records the project path at build time, so the `.app`
  keeps working after you move it to `/Applications`

## Install it

**Double-click `Install Codex.command`, in this folder.** That is the whole
procedure. It checks for the Xcode command-line tools, then runs
`package_app.sh --icon --install`: compile, bundle, draw the icon, ad-hoc
sign, copy to `/Applications`. Afterwards Codex is an ordinary Mac app.

Expect two things on a fresh download:

- Gatekeeper refuses the first double-click of any file from the internet.
  Right-click → **Open** → **Open**, once.
- `/Applications` needs `sudo`, so Terminal asks for your password.

Requires macOS 13 or later.

## Build and run from a terminal

```sh
sudo xcodebuild -license accept     # if you haven't accepted Xcode's licence
xcode-select --install              # if Command Line Tools aren't installed

cd Codex_macOS
./package_app.sh --run              # build release, bundle, open
./package_app.sh                    # build and bundle, don't open
./package_app.sh --debug            # faster debug build
./package_app.sh --install          # also copy to /Applications
./package_app.sh --icon             # regenerate AppIcon.icns
```

`Install Codex.command` is a Finder entry point onto `--icon --install` and
has no build logic of its own, so neither route can drift from the other.

The bundle lands at `../Codex.app`, at the repository root. It's a build
artifact and is gitignored — regenerate it rather than committing it.

## Layout

```
Codex_macOS/
├── Package.swift          ← SwiftPM manifest (macOS 13+)
├── Info.plist             ← bundle metadata, copied into the .app
├── Install Codex.command  ← double-click this; calls package_app.sh
├── package_app.sh         ← build · bundle · sign · install
└── Sources/
    ├── Codex/             ← the app itself
    │   ├── CodexApp.swift     ← @main App, AppState, RootView, menu commands
    │   ├── Theme.swift        ← Catppuccin palette, font scale, radii, tints
    │   ├── VisualEffect.swift ← NSVisualEffectView wrapper for vibrancy
    │   ├── CodexTree.swift    ← filesystem → CodexNode tree, kinds, symbols
    │   ├── Markdown.swift     ← block parser + renderer, frontmatter, hero
    │   ├── Sidebar.swift      ← band groups, pinned section, context menu
    │   ├── Toolbar.swift      ← toolbar, breadcrumb, search trigger
    │   ├── TabStrip.swift     ← Safari-style horizontal tabs
    │   ├── Inspector.swift    ← Outline / Info / Recents tabs
    │   ├── Welcome.swift      ← hero + quick-action / recent / band grids
    │   ├── Palette.swift      ← command palette with badges and footer hint
    │   └── Util.swift         ← fuzzy match, bookmarks, history, links
    └── RenderIcon/        ← separate product, built only by package_app.sh
        └── main.swift         ← draws AppIcon.icns at build time
```

## Keyboard shortcuts

| Shortcut | Action |
|----------|--------|
| `⌘P` | Command palette |
| `⌘1` | Toggle sidebar |
| `⌘0` | Toggle inspector |
| `⌘W` | Close active tab |
| `⇧⌘W` | Close all tabs |
| `⌘[` / `⌘]` | Back / forward |
| `⌘H` | Open README |
| `⌘R` | Reload tree |
| `⌘D` | Pin / unpin current file |
| `⇧⌘R` | Reveal current file in Finder |
| `↑` / `↓` | Move selection in the palette |
| `⏎` | Open the selected palette result |
| `⎋` | Dismiss the palette |

## Architecture notes

- **`AppState`** is a single `ObservableObject` owning open tabs, selection,
  panel visibility, bookmarks, and navigation history.

- **`CodexTree`** turns the filesystem into a `CodexNode` tree. It knows the
  band groupings, the sub-section ordering, and — in `nonContentDirs` — which
  root directories are apps rather than codex content. **Adding a non-layer
  directory to the repository root means adding it to that set**, or it shows
  up as a phantom layer and its markdown floods the palette.

- **`MarkdownParser`** is a hand-rolled block-level parser. It skips YAML
  frontmatter, then walks line by line emitting `MDBlock` cases. Inline
  styling is handed to Apple's `AttributedString(markdown:)`, which handles
  `**bold**`, `*italic*`, `` `code` ``, and `[text](url)`.

- **`LinkResolver`** resolves a markdown href against the source file's
  directory, then against the project root, and resolves a directory target
  to its `README.md` or `INDEX.md`.

- **Project-root discovery** tries, in order: `$CODEX_ROOT`, the bundled
  `project_path` resource, a six-level walk up looking for a directory with
  both `README.md` and `STRUCTURE.md`, then the working directory.

- **Ad-hoc signing** (`codesign -s -`) is enough to launch locally.
  Distribution would need a Developer ID and notarization, which this script
  does not attempt.

## Known issues

`swift.yml` answers "does it compile" on every PR, but nothing automated
exercises the UI, so anything about how a thing *looks* or whether a control
*responds* is unverified until someone opens that screen.

**What one launch found.** The Welcome screen has been seen on a Mac once. In
a single screenshot it turned up a Quick Start card offering "14 standalone
network & security utilities" from a `Tools/` directory that does not exist, a
layer count of 27 against the 23 that `LAYERS.md` states, a subtitle naming a
`Codex_v2` directory, and a version string three point-releases behind. Every
one had survived review, CI and a release.

**What one survey found.** Reading the UI layer against that lesson turned up
eleven more controls that a compiler cannot see, since each one compiles
perfectly and simply does nothing:

| Control | Was |
|---|---|
| Inspector outline rows | Hover highlight and a `contentShape`, no tap action |
| Anchor navigation | Parsed, carried through two views, then dropped — headings never carried their anchor as a scroll id |
| Breadcrumb | Plain text, though this README called it "clickable" |
| Toolbar search field | A `Button` styled as a text field; typing went nowhere |
| Traffic lights | No leading inset reserved under `.hiddenTitleBar`, so they sat over the sidebar toggle |
| Pin button | `.disabled()` without `enabled:`, so it rendered at full opacity while dead |
| Unpin `x` | A `Button` nested inside another `Button`'s label — unreliable on macOS |
| Pinned row titles | Rolled its own naming, so a pinned `INDEX.md` read "Index" and matched nothing else on screen |
| Inspector tag layout | `sizeThatFits` and `placeSubviews` used different wrap conditions, clipping the last row |
| Palette placeholder | Promised headings, which are not indexed |
| Palette arrow keys | `min(count - 1, …)` selected index −1 when nothing matched |

All eleven are now fixed, along with the vibrancy defeat below. **None of the
fixes have been seen running.** They are reasoned and they compile; that is
exactly the standard the eleven defects above also met.

**Vibrancy.** The sidebar and inspector use `.behindWindow` blending, which
samples what is behind the *window*. `RootView` painted an opaque `Theme.base`
across the whole window and the window itself was opaque by default, so both
surfaces rendered flat. The blanket background is gone and the window is now
non-opaque with a clear background. This is the change most likely to look
wrong in practice — if any region reads as transparent onto the desktop, that
is why.

**Not verified on a Mac.** Section indexes take their name from the file's
first H1 in the command palette, tab strip, recents and inspector, and read
`Overview` in the sidebar. That the result reads well — and that a long title
like `Industrial & Automotive Protocols — Protocols` does not overflow a 200pt
tab — has only been reasoned about, not seen.

**Still open.**

- `closeTab` selects `openTabs.last` rather than the adjacent tab.
- `allFiles` is a plain `lazy var`, not `@Published`, so `⌘R` reloads the tree
  without refreshing the palette index in the UI.
- `Palette.results` is a computed property read six times per `body`
  evaluation, so the full ranking runs several times per keystroke.
- The inspector reads and re-parses the current file three times per redraw,
  bypassing `DocumentStore`.
- Sidebar hover threads one `hoveredId` binding through every row, so every
  row redraws on every hover; expansion state is `@State` and lost on reload.
- `Bookmarks.touch()` writes `state.json` synchronously on every file open.
- `NavigationHistory` grows without a cap.
- `String(contentsOf:)` is called without an encoding argument in
  `findProjectRoot()` — deprecated on recent SDKs.
- `prettyFilename`'s `"Ip"→"IP"` rule also turns `Ipc` into `IPc`.
- A `Tools` band tint survives in `Theme.swift` with no corresponding
  directory.
- The palette does not search headings, only file paths.
- Code blocks put `.frame(maxWidth: .infinity)` on `Text` inside a horizontal
  `ScrollView`. Whether that wraps or scrolls depends on how SwiftUI resolves
  `.infinity` against a nil width proposal. The widest fenced line in the
  codex is 116 characters, in
  `08_User_Applications/man_pages/network_tools.md` — check there first.
- The reading column is capped at 920pt but pinned to the leading edge, so the
  slack collects on the right rather than as even margins.
- The last shipped binary was host-arch-only, with no universal slice, so it
  ran under Rosetta on Apple Silicon.
