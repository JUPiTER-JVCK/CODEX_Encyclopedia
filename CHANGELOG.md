# CHANGELOG

## What is in this section

```text
  Version history for the CODEX Encyclopedia repository.

  ┌─── release history ────────────────────────────────────────────────┐
  │  v3.6.25 (2026-09-16) — reader overhaul; diagrams on every index   │
  │  v3.6    (2026-09-09) — first tagged release; licensing; audits    │
  │  v3.5 and earlier     — untagged history (licensing gaps noted)    │
  └────────────────────────────────────────────────────────────────────┘
```

## v3.6.25 — 2026-09-16

A ten-stage pass over the macOS reader and the codex's diagram coverage,
shipped as PRs #16–#25. The version number is the release's, not the app's
alone: `Version.swift` (`CodexInfo.version`) is now the single source of truth; `package_app.sh` stamps `CFBundleShortVersionString` from it.

### Fixed — the reader's controls

The app had been *seen running* exactly once before this work, and that one
look found four defects that review, CI and a release had all passed. A survey
found eleven more. They shared a shape: each looked live and was not.

- Inspector outline rows had hover highlights and no tap action.
- Anchor navigation was parsed end to end and dropped in two places, so every
  cross-file `file.md#section` link opened at the top of its target.
- The breadcrumb was a bare `Text`; the README advertised it as clickable.
- The toolbar "search field" was a `Button` — typing did nothing.
- The pin button rendered enabled while disabled.
- The unpin `×` was a `Button` nested in another `Button`'s label.
- Traffic lights were not given a leading inset and overlapped the sidebar
  toggle.

Vibrancy was not merely suspect but actively defeated: two surfaces sampled
behind the window while an opaque fill was painted over both.

### Fixed — 48 documents with colliding anchors

Wiring the outline up was the first thing ever to *consume* heading anchors,
and it proved the scheme had never been unique — worst case nine `synopsis`
in one man-page file. Scroll ids are now resolved once in `DocumentStore`,
deduplicated the way GitHub does it, which also retired the outline's separate
and disagreeing second parse of every document.

### Added — reading column, themes, text scale

A centred column with a width control, replacing a layout that pinned prose
left and collected all its slack in one dead zone. Fourteen colour schemes
(Catppuccin ×4, Nord, Gruvbox, Solarized, Tokyo Night, Dracula, Rosé Pine),
an OLED modifier that composes with any dark theme rather than doubling the
list, and a text scale — reached through a new Appearance panel (⌘,) that
persists to its own `preferences.json`, never `state.json`.

### Changed — tabs are your pins

Tabs previously accumulated without bound: every open appended one. They are
now your pinned files plus the single thing you are reading.

### Added — a diagram in every section index

`diagram_audit.py` had been green while checking 23 of 277 files. Widened to
section indexes and content notes, to recognise the ASCII style already in
use, to width-check every fenced line rather than only those already
containing a box character, and to enforce the ```` ```text ```` tag that
`STRUCTURE.md` documents and 223 blocks omitted.

Then the gap it exposed was filled: ~170 diagrams across all four bands. Each
section index maps its own notes and how they relate, derived from the files
actually present, rather than carrying a decorative box.

Four existing diagrams were wrong, which is worse than absent, and were fixed
— including a logic-gate diagram that promised eight gates, drew four, and
drew AND with the buffer triangle, making it indistinguishable from YES.

### Fixed — performance and correctness

The command palette ranked every file six times per keystroke from a computed
property. The inspector read and re-parsed the open document three times per
redraw. The sidebar threaded one hover binding through every row, so all rows
redrew on any hover, and `CodexNode.id` was a fresh `UUID()` per build, which
discarded every expansion state on reload. `NavigationHistory` had no cap.
`package_app.sh` built host-arch only, so the shipped app ran under Rosetta
on Apple Silicon.

## v3.6 — 2026-09-09

First tagged release. The version history below describes v1 through v3.5,
but none of it was ever tagged — no release existed, and the only entry in
the Releases tab was one named `Main` pointing five merges into the past.
This is the first version that exists as far as git is concerned.

### Added — licensing

The repository had no LICENSE, which meant all rights reserved: legally
unusable by anyone, including for the purpose it was written for. Two
licenses now, split by what a file *is*:

- **MIT** — `Codex_macOS/`, `Codex_LMS/`, `tools/`. See `LICENSE`.
- **CC BY-SA 4.0** — the markdown codex. See `LICENSE-docs`.

ShareAlike on the codex is not a preference. `18_Embedded_Systems/` draws on
Meysam Parvizi's Embedded Systems Engineering Roadmap, which is CC BY-SA 4.0,
and that is what it requires of anything derived from it.

**Third-party material under any `references/` folder is covered by neither**
and retains its original authors' rights. `100_leetcode_problems.pdf` is the
one to know about: a 4.9 MB compilation with no stated license, which this
repository cannot relicense because it does not hold the rights to. Recorded
in README.md rather than quietly shipped.

### Added — `stats_audit.py`, and a shared tree walk

README.md quotes numbers about itself. Nothing checked them, so they drifted:
the diagram count read 101 against a real 102. Every other convention here is
enforced by a script for exactly this reason, so this is the fifth.

The design point is how it fails. A regex checker has a failure mode worse
than the drift it prevents — someone rewords the sentence, the pattern stops
matching, and it reports success forever while checking nothing. So a claim
it cannot *find* is a fault too, and rewording that section turns the build
red. Both modes were verified by breaking them deliberately.

It earned its keep before it was finished: adding the Licensing section above
put two new links in README, and the audit caught the count going stale
within minutes of the file being edited.

The five audits now share one tree walk (`tools/_common.py`), replacing four
copy-pasted `SKIP_DIRS` constants across six walk sites. This is what lets
the stats audit count the same set the other audits count — a second, subtly
different walk would not report drift, it would invent it.

That sentence was false when first written, and review caught it. The initial
change shared the *constant* and left three audits calling `os.walk`
themselves across four sites; the guarantee was published in this file, the
README and the commit message while half the work was missing. It is true
now: `grep "os\\.walk" tools/*.py` matches one line, in `_common.py`, and the
refactor is verified byte-identical against every audit's prior output.

### Added — contributor scaffolding

`CONTRIBUTING.md` (how to run the six checks — the conventions were written
down, the way to verify them was not), `.github/pull_request_template.md`,
and `SECURITY.md` scoped to what could actually go wrong in a repository with
no server, no accounts, and no stored data.

One narrow exemption came with the template: GitHub templates carry no H1,
because a template is a fragment pasted into a pull request body and an H1
renders as a full-width heading on every PR that uses it. `link_audit.py`
lifts the H1 requirement for `.github/` templates and nothing else.

"Nothing else" also needed review to become true. The first version tested
`startswith` over two prefixes, which exempted `pull_request_template.md.backup.md`
and `ISSUE_TEMPLATE-old.md` as well — and the check offered as proof only
probed an ordinary file, never an adjacent name. It is an equality test and
an explicit separator now, pinned by `link_audit.py --self-test` in CI, which
asserts all eight boundary cases including the three that used to slip
through.

### Fixed — eight review findings on the release itself

Review of the release PR returned eight findings and every one was real. Five
were overclaims: guarantees written into the README, the CHANGELOG and the
commit message that the code did not deliver. They are recorded above and in
the sections they belong to rather than collected here, because a changelog
that hides its corrections in a footnote is the same failure again.

Two were licensing errors in the release whose purpose was licensing:
`CONTRIBUTING.md`, `SECURITY.md`, `.github/` and `_assets/README.md` fell
under neither license, and a directory-wide `references/` carve-out would
have swept 23 repository-authored index files out of the CC BY-SA grant. Both
are fixed by making CC BY-SA a default rather than a list, and by naming the
two genuinely third-party files instead of a folder.

The last was `SECURITY.md` claiming the LMS "sends nothing anywhere" one
sentence before describing its network request. Progress genuinely never
leaves the browser; loading Google Fonts genuinely discloses IP and
user-agent. Both are now stated separately.

### Fixed — three widgets were unusable without a mouse

Review caught `onClick` attached to a `<th>` in `CompareGrid`, and to a
`<div>` in `TreeExplorer` and `PhishingInspector`. None of those is
focusable, none responds to Enter or Space, and none is announced as a
control. The point of the previous release was that every topic has something
to *manipulate* — for a keyboard or screen-reader user, in those three the
interactive part was the only part that did not work.

Sweeping the file found three more of the same shape that predate this work:
`MemoryHierarchyVisualizer`, `InlineTerm`, and `TopicMap`. All six are fixed
rather than the three that were reported, since leaving identical defects in
the same file would have been worse than either extreme.

Each is a real `<button type="button">` now, with `aria-pressed` or
`aria-expanded` where it applies, and a shared `wReset` style so a control
can still look like a table header, a tree row or a word in a sentence.
`TopicMap` is the exception: `<svg>` cannot contain a `<button>`, so its
nodes take `role="button"`, `tabIndex` and a key handler instead.

### Added — a keyboard check in `test/smoke.mjs`

`onClick` may only appear on a `<button>`, a component, or an element with
`role="button"` plus `tabIndex` and a key handler. Verified by reintroducing
the original `<div onClick>`, which fails the run naming the line.

The sweep now also Tabs to a `CompareGrid` header and presses Enter, so the
guard proves the control is *operable* and not merely spelled correctly.

**Not verified:** how it sounds. Focusable and operable are checked; whether
a screen reader announces any of it sensibly is not, and is recorded as a
known limit rather than claimed.

## v3.5 — 2026-09-07

### Added — something to manipulate in every topic

CORE was built around learning by manipulation, but only **17 of 43 topics**
had anything to interact with. CLI and Web sat at 1 of 6. Now every topic
does.

Four reusable primitives carry most of it, driven by data declared beside the
topic that uses them, so giving a topic something to manipulate is a data
change rather than another component:

| Primitive | Shape |
|---|---|
| `StepThrough` | a process one phase at a time, with state per step |
| `CompareGrid` | hold one dimension still and read it down every row |
| `TreeExplorer` | expand a nested structure, inspect one node |
| `TruthTableBuilder` | pick an expression, read every case |

Eleven topics whose subject has a shape of its own got a bespoke widget
instead: a signed 32-bit clock walking into its sign bit, a vim mode machine,
the shell's expansion order, a call stack pushing and popping frames, the
event loop showing why `A D C B` is not the order it was written, a pipeline
composer, a value inspector, a query builder, a topology explorer, a VLAN
lab, and a phishing inspector.

<!-- CHANGELOG_RESTORE_IN_PROGRESS: remainder follows in subsequent commits -->
