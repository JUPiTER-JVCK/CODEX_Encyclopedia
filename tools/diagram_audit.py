#!/usr/bin/env python3
"""Check the ASCII diagrams that carry all of this codex's illustration.

The codex has no images — `_assets/` holds no picture files — so every diagram
is drawn with box characters inside a fenced code block. That works everywhere
the codex is read (GitHub, any markdown viewer, the macOS app's code-block
renderer) and stays reviewable in a diff, which an image does not.

Reports six faults:

  UNFENCED       box characters in prose, outside any code block
  TOO WIDE       a diagram line past the column limit, which wraps or scrolls
  UNTAGGED       a diagram fence with no ```text info string
  MISSING IMAGE  a reference to an image file that is not in the repository
  NO DIAGRAM     a file that should carry a diagram and does not
  BACKLOG STALE  a backlog entry that is no longer a real gap

Inline code spans are stripped before the unfenced check: `-3*[worker]` in
prose is a mention, not a drawing. `link_audit.py` strips the same way.

    python3 tools/diagram_audit.py

Exit status is 1 if anything is off, so this works as a CI gate.

## What this checks and what it deliberately does not

**Width is checked per diagram block, not per fence.** An earlier plan for
this script was to width-check every fenced line. Measured, that rule fires
on twelve lines and *all twelve are code* — a 111-column JSON object in
`07_Runtime_Environment/protocols/oci_runtime.md`, a 116-column `tcpdump`
invocation in `08_User_Applications/man_pages/network_tools.md`. Wrapping
either would break it, and neither is a drawing. The real gap was narrower
and is now closed: the old rule measured only lines that *themselves* held a
box character, so a plain label line inside a diagram escaped. Every line of
a block that contains a diagram is measured now, because a diagram's columns
line up across all of its lines, captions included.

**Two drawing styles count.** Box-drawing characters are the house style, but
the network protocol notes carry RFC-style headers ruled with `+-+-+-+-+`,
which held no box character at all and so scored as *no diagram* — seven
files' worth of real drawings, invisible to the check that existed to find
missing ones.

## The backlog

Requiring a diagram only in the 23 layer READMEs left 254 files unchecked,
which is how 173 diagram-free files and four wrong drawings accumulated
without a red build. Scope is now every codex file, and the gap that exists
today is written down in `tools/diagram_backlog.txt` rather than left
implicit.

The backlog is checked in both directions, the way `palette_audit.py` checks
its derived-colour counts. A file missing a diagram that is *not* listed
fails — the gap cannot grow. A listed file that now has one also fails — the
list cannot go stale and quietly re-exempt work already done. Drawing a
diagram therefore means deleting its line here, and every count in that file
— the total in its header and the `(N)` on each band heading — has to be
right too.

Layer READMEs are outside this arrangement: they are required to carry a
diagram unconditionally and cannot be backlogged.
"""

from __future__ import annotations

import argparse
import os
import re
import sys
import tempfile
from typing import NamedTuple

# Run as a script, sys.path[0] is tools/; imported by stats_audit,
# tools/ is already on the path. Either way this resolves.
import _common

# A fence opens with three or more backticks and closes only on a run at
# least as long. A shorter run inside is content -- which is how this repo's
# own STRUCTURE.md shows a ```text block inside a ````-fenced example.
FENCE_RE = re.compile(r"^\s*(`{3,})")

# Box drawing, block elements and the arrows the existing diagrams use.
BOX = set("─│┌┐└┘├┤┬┴┼━┃┏┓┗┛┣┫┳┻╋╔╗╚╝═║╠╣╦╩╬╭╮╰╯▶◀◄►▲▼")

# The other drawing style in the codex: an RFC-style ruled line, as in the
# TCP and IPv4 header layouts. Anchored and whole-line, so a `+` in prose or
# in an arithmetic expression cannot be mistaken for a rule.
ASCII_RULE_RE = re.compile(r"^\s*\+[-+]{2,}\+\s*$")

# Widest existing diagram line is 86 columns; p99 is 77. 90 leaves room
# without letting a new diagram grow past what a narrow pane can show.
MAX_WIDTH = 90

# STRUCTURE.md documents ```text for diagram fences. What is enforced is that
# a diagram fence carries *some* tag, not that it carries that one.
#
# The narrower rule would be wrong here, and measurably so:
# `04_Device_Drivers/man_pages/device_commands.md:198` is a ```bash block of
# real shell whose comments quote `lsblk` tree output, box characters and
# all. Retagging it ```text would be a lie about the block. A tag someone
# chose is a decision; an absent tag is the omission this check is for.

CODE_SPAN_RE = re.compile(r"`[^`\n]*`")

# A layer folder is one holding a README plus at least one sub-section.
SUBSECTIONS = {"references", "lessons", "languages", "man_pages", "topics",
               "protocols"}

# Directories that are not the codex: the two applications, the audit scripts
# themselves, GitHub templates, and the asset folder. Their markdown is
# authored documentation and every *other* audit checks it — but a diagram in
# a PR template or in `tools/` would be decoration, not illustration.
NON_CODEX_TOPS = {".github", "Codex_LMS", "Codex_macOS", "tools", "_assets"}

# Root documents that describe the codex and are expected to draw it.
# THIRD_PARTY.md is deliberately absent: it is an attribution record.
ROOT_DOCUMENTS = {"README.md", "LAYERS.md", "STRUCTURE.md", "CHANGELOG.md",
                  "CONTRIBUTING.md", "SECURITY.md"}

BACKLOG_PATH = os.path.join("tools", "diagram_backlog.txt")

# Frontmatter key naming a picture, and bare references to the asset folder
# in prose. Both are how this codex actually cited its four never-committed
# images: no `![](...)` link was ever written, so `link_audit.py` counted
# zero images and had nothing to check.
SOURCE_IMAGE_RE = re.compile(r"^\s*source_image:\s*(\S+)\s*$")
ASSET_REF_RE = re.compile(r"[\w./-]*_assets/[\w./-]+\.(?:png|jpg|jpeg|gif|svg)")
BARE_ASSET_RE = re.compile(r"`([\w-]+\.(?:png|jpg|jpeg|gif|svg))`")


class Block(NamedTuple):
    """One fenced block: where it opens, its info string, and its lines."""

    start: int
    info: str
    body: list[tuple[int, str]]


def fenced_blocks(lines: list[str]) -> tuple[list[Block], list[int]]:
    """Every fenced block, and the line numbers of unfenced box characters.

    One pass answers both questions, because both need the same fence state
    and a second parse would eventually disagree with this one.

    Unfenced detection strips inline code spans first, so a box character
    quoted inside backticks is a mention rather than a broken drawing.
    """
    blocks: list[Block] = []
    loose: list[int] = []
    current: Block | None = None
    fence_len = 0

    for i, raw in enumerate(lines, start=1):
        m = FENCE_RE.match(raw)
        if m:
            run = len(m.group(1))
            if not fence_len:
                fence_len = run
                current = Block(i, raw[m.end():].strip(), [])
                continue
            if run >= fence_len and raw[m.end():].strip() == "":
                fence_len = 0
                if current is not None:
                    blocks.append(current)
                current = None
                continue
        if fence_len:
            if current is not None:
                current.body.append((i, raw))
        elif BOX & set(CODE_SPAN_RE.sub("", raw)):
            loose.append(i)

    # An unterminated fence still holds real lines; keep them rather than
    # dropping a whole diagram because someone forgot a closing run.
    if current is not None:
        blocks.append(current)
    return blocks, loose


def is_diagram(block: Block) -> bool:
    """True if this block draws something, in either of the two styles."""
    return any(BOX & set(text) for _, text in block.body) or \
        any(ASCII_RULE_RE.match(text) for _, text in block.body)


def classify(lines: list[str]) -> tuple[list[int], list[int]]:
    """Line numbers of fenced diagram lines, and of unfenced ones.

    Kept as the shape the fence self-test asserts against, now expressed in
    terms of the block parse rather than a second loop of its own.
    """
    blocks, loose = fenced_blocks(lines)
    fenced = [ln for block in blocks for ln, text in block.body
              if BOX & set(text)]
    return sorted(fenced), loose


def image_faults(root: str, path: str, lines: list[str],
                 blocks: list[Block]) -> list[tuple[int, str, str]]:
    """References to image files that are not under `root`.

    Scoped to frontmatter and to prose outside fences. A `plt.savefig(...)`
    call inside a Python block names a file the *reader* will create, not one
    this repository ships — and neither does a ` ```yaml ` block showing what
    a `source_image:` key looks like. The fence check comes first for exactly
    that reason; frontmatter is never fenced, so nothing real is skipped.

    `root` is the tree being audited, not the tree this script lives in. They
    are the same for every real run and differ under `--root`, where resolving
    `_assets/…` against the script's own checkout would pass a missing image
    or fail a present one.
    """
    here = os.path.dirname(os.path.abspath(path))
    fenced = {ln for block in blocks for ln, _ in block.body}
    faults = []

    def check(lineno: int, ref: str, target: str) -> None:
        if not os.path.exists(target):
            faults.append((lineno, "MISSING IMAGE",
                           f"{ref} is referenced but not in the repository"))

    for i, raw in enumerate(lines, start=1):
        if i in fenced:
            continue
        m = SOURCE_IMAGE_RE.match(raw)
        if m:
            check(i, m.group(1), os.path.normpath(os.path.join(here, m.group(1))))
            continue
        for ref in ASSET_REF_RE.findall(raw):
            tail = ref[ref.index("_assets/"):]
            check(i, ref, os.path.join(root, tail))
        for name in BARE_ASSET_RE.findall(raw):
            check(i, name, os.path.join(root, "_assets", name))

    return faults


def audit_file(path: str,
               root: str | None = None) -> tuple[list[tuple[int, str, str]], bool]:
    """Faults in one file, and whether it contains a diagram.

    `root` defaults to this script's own repository, which is what every
    caller outside `--root` means.
    """
    if root is None:
        root = _common.repo_root()
    with open(path, encoding="utf-8") as fh:
        lines = fh.read().split("\n")

    blocks, loose = fenced_blocks(lines)
    diagrams = [block for block in blocks if is_diagram(block)]

    faults = [(ln, "UNFENCED", "box characters outside a code block")
              for ln in loose]

    # Every line of a diagram block, not only the lines holding a box
    # character: a caption that wraps moves the drawing under it just as
    # surely as a rule that wraps.
    faults += [(ln, "TOO WIDE", f"{len(text)} columns, limit {MAX_WIDTH}")
               for block in diagrams for ln, text in block.body
               if len(text) > MAX_WIDTH]

    faults += [(block.start, "UNTAGGED", "diagram fence has no info string, "
                "expected ```text")
               for block in diagrams if not block.info]

    faults += image_faults(root, path, lines, blocks)

    return faults, bool(diagrams)


def layer_readmes(root: str) -> list[str]:
    """Every layer folder's README.md, found by shape rather than by name."""
    found = []
    for dirpath, dirnames, filenames in _common.walk_dirs(root):
        if "README.md" in filenames and SUBSECTIONS & set(dirnames):
            found.append(os.path.join(dirpath, "README.md"))
    return sorted(found)


def wants_diagram(rel: str) -> bool:
    """Whether this file is one the codex expects to illustrate itself."""
    parts = rel.split(os.sep)
    if len(parts) == 1:
        return rel in ROOT_DOCUMENTS
    return parts[0] not in NON_CODEX_TOPS


class Backlog(NamedTuple):
    """The listed gaps, the total the header claims, and the band counts."""

    entries: set[str]
    claimed: int | None
    bands: list[tuple[str, int, int]]      # label, claimed, actual


# `# 142 files remain.` and `# Compute — 02 CPU through 08 … (65)`.
TOTAL_RE = re.compile(r"^#\s*(\d+)\s+files? remain")
BAND_RE = re.compile(r"^#\s*(.+?)\s*\((\d+)\)\s*$")


def read_backlog(root: str) -> Backlog:
    """Parse the backlog, including the per-band counts in its headings.

    Every number in this file is checked against the entries under it, for
    the same reason the entries are checked against the tree: a number in
    prose that nothing verifies is a number that goes stale. The band counts
    were not parsed at first, and a PR description claimed they were — which
    is precisely the failure this file exists to prevent, one level up.
    """
    path = os.path.join(root, BACKLOG_PATH)
    entries: set[str] = set()
    claimed: int | None = None
    bands: list[tuple[str, int, int]] = []
    try:
        with open(path, encoding="utf-8") as fh:
            for line in fh:
                line = line.strip()
                if not line:
                    continue
                if line.startswith("#"):
                    total = TOTAL_RE.search(line)
                    if total:
                        claimed = int(total.group(1))
                        continue
                    band = BAND_RE.match(line)
                    if band:
                        bands.append((band.group(1), int(band.group(2)), 0))
                    continue
                entries.add(line.replace("/", os.sep))
                if bands:
                    label, want, seen = bands[-1]
                    bands[-1] = (label, want, seen + 1)
    except FileNotFoundError:
        pass
    return Backlog(entries, claimed, bands)


def coverage_faults(root: str,
                    drawn: dict[str, bool]) -> list[tuple[str, int, str, str]]:
    """NO DIAGRAM and BACKLOG STALE, across the whole codex.

    `drawn` maps every relative path to whether it holds a diagram, taken
    from the caller's pass over the tree. Re-deriving it here would mean
    parsing — and re-`stat`ing every image reference in — all 278 files a
    second time, for an answer already in hand.
    """
    listed = read_backlog(root)
    backlog, claimed = listed.entries, listed.claimed
    faults: list[tuple[str, int, str, str]] = []

    # A layer README is the one file that cannot be backlogged: it is the
    # overview of a whole layer, and requiring one is the check this audit
    # has always made. It is held to that unconditionally below, so it is
    # excluded here — covered by both passes it would report NO DIAGRAM
    # twice and count against the backlog header it may not appear in.
    layers = {os.path.relpath(p, root) for p in layer_readmes(root)}

    in_scope = {rel for rel in drawn if wants_diagram(rel)} - layers
    has = {rel for rel in in_scope if drawn[rel]}

    for rel in sorted(in_scope - has):
        if rel not in backlog:
            faults.append((rel, 1, "NO DIAGRAM",
                           "no diagram, and not listed in " + BACKLOG_PATH))

    for rel in sorted(backlog):
        if rel in layers:
            faults.append((BACKLOG_PATH, 1, "BACKLOG STALE",
                           f"{rel} is a layer README and cannot be backlogged"))
        elif rel not in in_scope:
            faults.append((BACKLOG_PATH, 1, "BACKLOG STALE",
                           f"{rel} is not a file this audit checks"))
        elif rel in has:
            faults.append((BACKLOG_PATH, 1, "BACKLOG STALE",
                           f"{rel} has a diagram now — delete its line"))

    real = len(in_scope - has)
    if claimed is None:
        faults.append((BACKLOG_PATH, 1, "BACKLOG STALE",
                       "header does not state how many files remain"))
    elif claimed != real:
        faults.append((BACKLOG_PATH, 1, "BACKLOG STALE",
                       f"header claims {claimed} files remain, really {real}"))

    for label, want, seen in listed.bands:
        if want != seen:
            faults.append((BACKLOG_PATH, 1, "BACKLOG STALE",
                           f"band \"{label}\" claims {want}, lists {seen}"))

    for rel in sorted(layers):
        if not drawn.get(rel):
            faults.append((rel, 1, "NO DIAGRAM",
                           "a layer overview should show where the layer sits"))

    return faults


# Fence handling has been wrong twice: first by toggling on any run of three
# backticks (which broke on a ````-fenced example containing ```text), then by
# treating a run with an info string as a close. Both were found by review
# rather than by running anything, so the cases live here now.
FENCE_CASES = [
    (
        "info string cannot close a fence",
        ["```", "┌───┐", "```text", "│ x │", "└───┘", "```"],
        [2, 4, 5], [],
    ),
    (
        "a longer fence nests a shorter one",
        ["````", "```text", "│ x │", "```", "````"],
        [3], [],
    ),
    (
        "a shorter run cannot close a longer fence",
        ["````", "```", "│ x │", "````"],
        [3], [],
    ),
    (
        "box characters in prose are unfenced",
        ["not fenced ─── at all"],
        [], [1],
    ),
    (
        "an inline code span is a mention, not a drawing",
        ["prose with `─3*[worker]` inside it"],
        [], [],
    ),
    (
        "trailing whitespace still closes",
        ["```", "│ x │", "```   "],
        [2], [],
    ),
]

# Each case is a small document and the fault kinds it must produce. The
# point of the pairs is the *negative* half: a rule that fires on everything
# is no better than one that fires on nothing, and the twelve over-wide code
# lines this audit deliberately ignores are exactly that distinction.
FAULT_CASES = [
    (
        "an RFC-ruled header is a diagram",
        ["```text", "+-+-+-+-+", "| Port  |", "+-+-+-+-+", "```"],
        [],
    ),
    (
        "a plus in prose inside a fence is not a rule",
        ["```python", "x = a + b + c", "```"],
        [],
    ),
    (
        "an over-wide code line is not a diagram fault",
        ["```bash", "tcpdump " + "-" * 120, "```"],
        [],
    ),
    (
        "an over-wide caption inside a diagram is",
        ["```text", "┌─┐", "└─┘", "caption " + "x" * 120, "```"],
        ["TOO WIDE"],
    ),
    (
        "a box line over the limit is still caught",
        ["```text", "┌" + "─" * 120 + "┐", "```"],
        ["TOO WIDE"],
    ),
    (
        "an untagged diagram fence is a fault",
        ["```", "┌─┐", "└─┘", "```"],
        ["UNTAGGED"],
    ),
    (
        "a tagged diagram fence is not",
        ["```text", "┌─┐", "└─┘", "```"],
        [],
    ),
    (
        "an untagged block with no drawing is left alone",
        ["```", "just some words", "```"],
        [],
    ),
    (
        "a tag someone chose is left alone, drawing or not",
        ["```bash", "lsblk", "# └─nvme0n1p3   crypto_LUKS", "```"],
        [],
    ),
    (
        "a source_image pointing nowhere is a fault",
        ["---", "source_image: ../../_assets/nothing_here.png", "---"],
        ["MISSING IMAGE"],
    ),
    (
        "a missing asset named in prose is a fault",
        ["See `_assets/never_committed.png` for the original."],
        ["MISSING IMAGE"],
    ),
    (
        "the same name inside a code block is not",
        ["```python", 'plt.savefig("never_committed.png")', "```"],
        [],
    ),
    (
        "a source_image line shown as an example is not",
        ["```yaml", "source_image: ../../_assets/example.png", "```"],
        [],
    ),
]


DIAGRAM = "```text\n┌───┐\n│ x │\n└───┘\n```\n"
PLAIN = "# Heading\n\nProse only.\n"

# Coverage rules need a tree, not a document, so these build one. Both of the
# first two assert something this file's prose claimed before anything
# checked it — that a layer README is held to its diagram unconditionally and
# is not part of the backlog arrangement — which is exactly the kind of claim
# that turns out to be untrue.
# Each expectation is a `KIND | text the fault must contain` pair, matched
# against "<path> <detail>". Kinds alone are not enough, and review caught
# that: under the original defect a backlogged layer README still produced
# one BACKLOG STALE and one NO DIAGRAM — the header count noticing a gap it
# should never have counted, and the unconditional check — which is the same
# pair of kinds the fix produces for entirely different reasons. Comparing
# categories, the case passed either way. The detail is what separates them.
COVERAGE_CASES = [
    (
        "a layer README with no diagram faults once, not twice",
        {"L/README.md": PLAIN, "L/topics/INDEX.md": DIAGRAM},
        "# 0 files remain.\n",
        ["NO DIAGRAM | L/README.md a layer overview should show"],
    ),
    (
        "a layer README cannot be backlogged out of that",
        {"L/README.md": PLAIN, "L/topics/INDEX.md": DIAGRAM},
        "# 0 files remain.\nL/README.md\n",
        ["BACKLOG STALE | L/README.md is a layer README and cannot be backlogged",
         "NO DIAGRAM | L/README.md a layer overview should show"],
    ),
    (
        "an ordinary file's gap is excused by a backlog line",
        {"L/README.md": DIAGRAM, "L/topics/INDEX.md": PLAIN},
        "# 1 files remain.\nL/topics/INDEX.md\n",
        [],
    ),
    (
        "an unlisted gap is not",
        {"L/README.md": DIAGRAM, "L/topics/INDEX.md": PLAIN},
        "# 1 files remain.\n",
        ["NO DIAGRAM | L/topics/INDEX.md no diagram, and not listed in"],
    ),
    (
        "and the header count is checked against it",
        {"L/README.md": DIAGRAM, "L/topics/INDEX.md": PLAIN},
        "# 0 files remain.\nL/topics/INDEX.md\n",
        ["BACKLOG STALE | header claims 0 files remain, really 1"],
    ),
    (
        "a backlog line for a file that has one is stale",
        {"L/README.md": DIAGRAM, "L/topics/INDEX.md": DIAGRAM},
        "# 1 files remain.\nL/topics/INDEX.md\n",
        ["BACKLOG STALE | L/topics/INDEX.md has a diagram now",
         "BACKLOG STALE | header claims 1 files remain, really 0"],
    ),
    (
        "a band heading's own count is checked too",
        {"L/README.md": DIAGRAM, "L/topics/INDEX.md": PLAIN},
        "# 1 files remain.\n\n# Band (2)\nL/topics/INDEX.md\n",
        ["BACKLOG STALE | band \"Band\" claims 2, lists 1"],
    ),
    (
        "and passes when it agrees",
        {"L/README.md": DIAGRAM, "L/topics/INDEX.md": PLAIN},
        "# 1 files remain.\n\n# Band (1)\nL/topics/INDEX.md\n",
        [],
    ),
    (
        "an image present under the audited root is found there",
        {"L/README.md": DIAGRAM + "\nSee `_assets/present.png`.\n",
         "L/topics/INDEX.md": DIAGRAM, "_assets/present.png": "not really a png"},
        "# 0 files remain.\n",
        [],
    ),
]


def coverage_self_test() -> int:
    """Assert the coverage and backlog rules against small built trees."""
    failed = 0
    for name, files, backlog, want in COVERAGE_CASES:
        with tempfile.TemporaryDirectory(prefix="diagram-audit-tree-") as root:
            for rel, body in {**files, BACKLOG_PATH: backlog}.items():
                dest = os.path.join(root, rel)
                os.makedirs(os.path.dirname(dest), exist_ok=True)
                with open(dest, "w", encoding="utf-8") as fh:
                    fh.write(body)

            drawn = {rel: audit_file(path, root)[1]
                     for path, rel in _common.walk_markdown(root)}
            got = [(kind, f"{rel} {detail}")
                   for rel, _, kind, detail in coverage_faults(root, drawn)]
            got += [(kind, f"{rel} {detail}")
                    for path, rel in _common.walk_markdown(root)
                    for _, kind, detail in audit_file(path, root)[0]]

        unmatched = list(got)
        missing = []
        for expectation in want:
            kind, _, needle = expectation.partition(" | ")
            hit = next((g for g in unmatched
                        if g[0] == kind and needle.strip() in g[1]), None)
            if hit is None:
                missing.append(expectation)
            else:
                unmatched.remove(hit)

        ok = not missing and not unmatched
        print(f"  {'ok  ' if ok else 'FAIL'} {name}")
        if not ok:
            for expectation in missing:
                print(f"       missing  {expectation}")
            for kind, detail in unmatched:
                print(f"       extra    {kind} | {detail}")
            failed += 1
    return failed


def self_test(root: str) -> int:
    """Assert the rules directly, including that they can fail.

    `python3 tools/diagram_audit.py --self-test`
    """
    failed = 0
    print("fence rules")
    for name, doc, want_fenced, want_loose in FENCE_CASES:
        fenced, loose = classify(doc)
        ok = fenced == want_fenced and loose == want_loose
        print(f"  {'ok  ' if ok else 'FAIL'} {name}")
        if not ok:
            print(f"       fenced {fenced} want {want_fenced}")
            print(f"       loose  {loose} want {want_loose}")
            failed += 1

    print("\nfault rules")
    # A private directory rather than a fixed name in the repository: the
    # first version of this wrote `.diagram_audit_selftest.md` at the root
    # and deleted it afterwards, which would have destroyed a real file of
    # that name. `root` is still passed as the audit root so `_assets/…`
    # references resolve against the tree under test, not the scratch dir.
    with tempfile.TemporaryDirectory(prefix="diagram-audit-") as tmp:
        scratch = os.path.join(tmp, "case.md")
        for name, doc, want in FAULT_CASES:
            with open(scratch, "w", encoding="utf-8") as fh:
                fh.write("\n".join(doc) + "\n")
            got = sorted({kind for _, kind, _ in audit_file(scratch, root)[0]})
            ok = got == sorted(want)
            print(f"  {'ok  ' if ok else 'FAIL'} {name}")
            if not ok:
                print(f"       got {got} want {sorted(want)}")
                failed += 1

    print("\ncoverage rules")
    failed += coverage_self_test()

    total = len(FENCE_CASES) + len(FAULT_CASES) + len(COVERAGE_CASES)
    print(f"\n{total - failed}/{total} cases pass")
    return 1 if failed else 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", default=_common.repo_root())
    parser.add_argument("--self-test", action="store_true",
                        help="check the rules against known cases and exit")
    args = parser.parse_args()

    if args.self_test:
        return self_test(args.root)

    faults: list[tuple[str, int, str, str]] = []
    drawn: dict[str, bool] = {}

    # One parse per file. `coverage_faults` reads the result rather than
    # walking the tree again.
    for path, rel in _common.walk_markdown(args.root):
        file_faults, has = audit_file(path, args.root)
        drawn[rel] = has
        faults.extend((rel, ln, kind, detail)
                      for ln, kind, detail in file_faults)

    faults.extend(coverage_faults(args.root, drawn))
    faults.sort()

    backlog = read_backlog(args.root).entries
    scoped = sum(1 for rel in drawn if wants_diagram(rel))

    print(f"markdown files   {len(drawn)}")
    print(f"with a diagram   {sum(drawn.values())}")
    print(f"needing one      {scoped}")
    print(f"still to draw    {len(backlog)}")
    print(f"layer READMEs    {len(layer_readmes(args.root))}")
    print(f"diagram faults   {len(faults)}")

    if faults:
        counts: dict[str, int] = {}
        for _, _, kind, _ in faults:
            counts[kind] = counts.get(kind, 0) + 1
        print()
        for kind in sorted(counts):
            print(f"  {counts[kind]:3d}  {kind}")
        print()
        for rel, line, kind, detail in faults:
            print(f"  {kind:13s} {rel}:{line}  ({detail})")
        return 1

    print("\nevery diagram fenced, tagged, sized, and where it is needed")
    return 0


if __name__ == "__main__":
    sys.exit(main())
