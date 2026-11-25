#!/usr/bin/env python3
"""Check that every layer is one folder with one page, and that the page works.

Each layer is a single folder at the repository root holding a README.md --
the layer's page -- and its notes, side by side. There are no sub-section
folders. The page carries the layer's six sections (References, Lessons,
Languages, Manual Pages, Topics, Protocols) as `##` headings, and opens with
an *In this layer* table linking every note, so any note is one click from
its layer page and two from the front page.

That promise is what this audit holds the tree to:

  BAD TITLE      H1 is not "<NN> — <Layer name>", or is not first in the file
  FRONTMATTER    the page carries YAML frontmatter (entry points carry none)
  NO TABLE       the page has no "## In this layer" heading
  SECTIONS       the six section headings are missing, duplicated or out of
                 order -- their anchors are what every cross-link targets
  UNLISTED       a note in the folder is not linked from the In this layer
                 table, so a reader of the page cannot find it
  STRAY FOLDER   a layer folder holds a sub-directory other than _archive/;
                 notes sit beside the page, never one level down

    python3 tools/layer_audit.py

Exit status is 1 if anything is off, so this works as a CI gate.
"""

from __future__ import annotations

import argparse
import os
import re
import sys

# Run as a script, sys.path[0] is tools/; imported by stats_audit,
# tools/ is already on the path. Either way this resolves.
import _common

# The six sections, in page order, with the anchor each heading produces.
# Mirrors the "In this layer" table and STRUCTURE.md; changing a name here
# means changing every layer page and every link to its anchor.
SECTIONS = [
    ("References", "references"),
    ("Lessons", "lessons"),
    ("Languages", "languages"),
    ("Manual Pages", "manual-pages"),
    ("Topics", "topics"),
    ("Protocols", "protocols"),
]

# Where archived notes go (STRUCTURE.md, Status and lifecycle). Retired on
# purpose, so not listed on the page and not a stray folder.
ARCHIVE = "_archive"

EM_DASH = "—"
TITLE_RE = re.compile(r"^# (\d\d[b-d]?) " + EM_DASH + r" \S")
LINK_RE = re.compile(r"\]\(([^)#\s]+)(?:#[^)]*)?\)")


def read_lines(path: str) -> list[str]:
    # Split on "\n" rather than splitlines(): line numbers are reported for a
    # person to look up in an editor, and splitlines() also breaks on \v, \f
    # and U+2028, which no editor treats as a line end.
    with open(path, encoding="utf-8") as fh:
        return fh.read().split("\n")


def headings(lines: list[str]) -> list[tuple[int, str]]:
    """(line index, text) of every `## ` heading outside fenced blocks."""
    out, fenced = [], False
    for i, line in enumerate(lines):
        if line.lstrip().startswith("```"):
            fenced = not fenced
        elif not fenced and line.startswith("## "):
            out.append((i, line[3:].strip()))
    return out


def audit_layer(layer_dir: str) -> list[tuple[str, str]]:
    """Faults for one layer folder, as (kind, detail) pairs."""
    faults: list[tuple[str, str]] = []
    name = os.path.basename(layer_dir)
    page = os.path.join(layer_dir, "README.md")
    lines = read_lines(page)

    if lines and lines[0].strip() == "---":
        faults.append(("FRONTMATTER", "the layer page is navigation, not a note"))

    first = next((i for i, l in enumerate(lines) if l.strip()), 0)
    m = TITLE_RE.match(lines[first]) if lines else None
    if not m:
        faults.append(("BAD TITLE",
                       f"line {first + 1} should be '# <NN> {EM_DASH} <Layer>'"))
    elif not name.startswith(m.group(1) + "_"):
        faults.append(("BAD TITLE",
                       f"title number {m.group(1)} does not match folder {name}"))

    heads = headings(lines)
    texts = [t for _, t in heads]

    # Section headings: each exactly once, in canonical order.
    want = [s for s, _ in SECTIONS]
    seen = [t for t in texts if t in want]
    if seen != want:
        faults.append(("SECTIONS", f"found {seen}, want {want}"))

    # The In this layer table, and every note linked from it.
    table_at = next((i for i, t in heads if t == "In this layer"), None)
    if table_at is None:
        faults.append(("NO TABLE", "no '## In this layer' heading"))
    else:
        end = next((i for i, _ in heads if i > table_at), len(lines))
        linked = {os.path.normpath(href)
                  for line in lines[table_at:end]
                  for href in LINK_RE.findall(line)}
        for entry in sorted(os.listdir(layer_dir)):
            path = os.path.join(layer_dir, entry)
            if entry == ARCHIVE:
                continue
            if os.path.isdir(path):
                faults.append(("STRAY FOLDER", f"{entry}/ — notes sit beside the page"))
            elif entry != "README.md" and not entry.startswith(".") \
                    and entry not in linked:
                faults.append(("UNLISTED",
                               f"{entry} is not linked from 'In this layer'"))

    return faults


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", default=_common.repo_root())
    args = parser.parse_args()

    layers = _common.layer_dirs(args.root)
    faults = [(os.path.relpath(d, args.root), kind, detail)
              for d in layers for kind, detail in audit_layer(d)]

    print(f"layer pages      {len(layers)}")
    print(f"layer faults     {len(faults)}")

    if faults:
        print()
        for rel, kind, detail in faults:
            print(f"  {kind:13s} {rel}  ({detail})")
        return 1

    print("\nevery layer is one folder, one page, every note one click away")
    return 0


if __name__ == "__main__":
    sys.exit(main())
