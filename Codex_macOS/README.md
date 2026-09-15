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
- **Fourteen colour schemes** — Catppuccin (Latte / Frappé / Macchiato /
  Mocha), Nord, Tokyo Night, Dracula, Gruvbox, Solarized and Rosé Pine, with a
  **true-black OLED** toggle that composes with any of the dark ones
- **Adjustable text size** — 85%–140%, applied to type only; icon glyphs keep
  their size so they cannot outgrow the frames they sit in
- **Adjustable reading width** — Narrow / Comfortable / Wide / Full Width,
  centred, shared by the document pane and the Welcome screen
- **Appearance panel** (⌘,) — theme swatches, OLED, text size, reading width
- **Bookmarks + recents** persisted to
  `~/Library/Application Support/Codex/state.json`, with appearance
  preferences in `preferences.json` beside it — deliberately a separate file,
  since `Bookmarks` decoding is all-or-nothing and a new key in it would wipe
  existing pins
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
    │   ├── Theme.swift        ← design tokens, resolved against the palette
    │   ├── Palettes.swift     ← the fourteen colour schemes + OLED modifier
    │   ├── Appearance.swift   ← the ⌘, settings panel
    │   ├── VisualEffect.swift ← NSVisualEffectView wrapper for vibrancy
    │   ├── CodexTree.swift    ← filesystem → CodexNode tree, kinds, symbols
    │   ├── Markdown.swift     ← block parser + renderer, frontmatter, hero
    │   ├── Sidebar.swift      ← band groups, pinned section, context menu
    │   ├── Toolbar.swift      ← toolbar, breadcrumb, search trigger
    │   ├── TabStrip.swift     ← Safari-style horizontal tabs
    │   ├── Inspector.swift    ← Outline / Info / Recents tabs
    │   ├── Welcome.swift      ← hero + quick-action / recent / band grids
    │   ├── Palette.swift      ← command palette with badges and footer hint
    │   ├── Preferences.swift  ← reading width, persisted to preferences.json
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
| `⌘,` | Appearance — theme, OLED, text size, width |
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

And three of the repairs were themselves pointer-only on the first attempt —
outline rows, breadcrumb crumbs and pinned rows all used `onTapGesture` on a
plain view, which cannot be focused or activated with Return. In `PinnedRow`
that was a straight trade: a `Button` was removed to fix the nested-button bug
and the keyboard went with it. All three are plain-styled `Button`s now,
siblings rather than nested, matching what the sidebar rows already did.

All eleven are now fixed, along with the vibrancy defeat below. **None of the
fixes have been seen running.** They are reasoned and they compile; that is
exactly the standard the eleven defects above also met.

**What fixing them exposed.** Making the outline rows clickable was the first
time anything in this app consumed a heading anchor — and it immediately
showed that the anchors were never unique. `MarkdownParser` derives them from
heading text, and heading text repeats: **48 files carry 469 colliding
anchors**, worst `06_System_Libraries/man_pages/linker_commands.md` with 26,
because the man-page notes repeat `Synopsis`, `Description` and `Examples`
once per documented command. Twenty-six of that file's outline rows would have
jumped to the wrong heading.

Two related mismatches surfaced with it. `DocumentStore` drops the first H1
from the body because the hero card renders it, while the outline pane
re-parsed the raw file and listed it anyway — so the first row addressed an id
nothing carried. And `LinkResolver` had been parsing the fragment out of
`file.md#section` and discarding it for as long as it has existed, so every
cross-file section link opened at the top of its target.

The fix is one thing rather than three: `DocumentStore` resolves the outline
once, assigning occurrence-suffixed ids (`examples`, `examples-2`, …) the way
GitHub does, gives the hero the first H1's id, and both the renderer and the
outline read that one list. The inspector stops being a second, disagreeing
parse of the same document — which also retires the three-reads-per-redraw
cost it carried. Verified by mirroring the resolver against all 277 documents:
469 collisions before, 0 after.

A control that works for the first time is the first real test of everything
beneath it.

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

**Reading column.** It was capped at 920pt and pinned to the leading edge by
`.frame(maxWidth: .infinity, alignment: .topLeading)`, so every spare pixel
collected in one dead gap on the right — while the Welcome screen, which
passes no alignment and therefore centres, used different numbers again (980pt
with 40pt gutters against 920/48). Both now share `Theme.Layout` and one width
preference, and both centre. Code blocks use `.fixedSize(horizontal: true)`
rather than resolving `.infinity` against an unbounded proposal, so a wide
fenced line scrolls instead of maybe-wrapping; the widest in the codex is 116
characters, in `08_User_Applications/man_pages/network_tools.md`. Unverified on
a Mac, like everything else here.

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
- The last shipped binary was host-arch-only, with no universal slice, so it
  ran under Rosetta on Apple Silicon.
