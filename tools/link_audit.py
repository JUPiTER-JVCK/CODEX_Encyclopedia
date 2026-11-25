#!/usr/bin/env python3
"""Check every relative markdown link and image in the codex.

Walks the repository, resolves each relative link against the file that
contains it, and reports the ones that do not exist. Inline code spans are
stripped first, so a syntax example like `[text](path.md)` in prose is not
mistaken for a real link.

A link carrying an anchor -- `#topics`, `../05_OS_Kernel/README.md#topics` --
must also land on a heading that exists, slugged the way GitHub slugs it.
Every layer keeps its six sections on one page, so cross-links target
sections by anchor; without this check a renamed heading would leave every
one of them silently opening the top of the page instead.

    python3 tools/link_audit.py            # summary + any breakages
    python3 tools/link_audit.py --verbose  # also list every external link

Exit status is 1 if anything is broken, so this works as a CI gate.
"""

from __future__ import annotations

import argparse
import os
import re
import sys
import urllib.parse

# Run as a script, sys.path[0] is tools/; imported by stats_audit,
# tools/ is already on the path. Either way this resolves.
import _common

# There was a tolerance list here: four image filenames the codex referenced
# but did not ship, excused so the build would not fail over "a known,
# deliberate gap". It was dead code — the codex contains zero `![](...)`
# links, so `stats["images"]` is 0 and the branch reading this never ran. The
# four references were in prose and frontmatter, where this audit could not
# see them at all, and they outlived the tolerance by a year.
#
# `diagram_audit.py` checks those forms now, and the four are drawn rather
# than promised. A broken image link is simply broken here.

# GitHub templates are fragments pasted into a pull request or issue body,
# not documents. An H1 in one renders as a full-width heading on every PR
# that uses it, so they conventionally start at "##". They are still checked
# for links and tables; only the H1 requirement is lifted.
#
# Exactly two things are exempt: that one file, and files inside the issue
# template directory. This was a `startswith` test over both names until
# review pointed out what that also swallowed — `pull_request_template.md.backup.md`
# and `ISSUE_TEMPLATE-old.md` are neither templates nor exempt, but both
# carry the prefix. Hence an equality test and an explicit separator, and
# H1_EXEMPT_CASES below so the boundary is asserted rather than described.
H1_EXEMPT_FILE = os.path.join(".github", "pull_request_template.md")
H1_EXEMPT_DIR = os.path.join(".github", "ISSUE_TEMPLATE") + os.sep


def needs_h1(rel: str) -> bool:
    return rel != H1_EXEMPT_FILE and not rel.startswith(H1_EXEMPT_DIR)


# (path, does it still need an H1). The three True rows next to a template
# name are the regression: each one was exempt before the fix above.
H1_EXEMPT_CASES = [
    (os.path.join(".github", "pull_request_template.md"), False),
    (os.path.join(".github", "ISSUE_TEMPLATE", "bug.md"), False),
    (os.path.join(".github", "ISSUE_TEMPLATE", "feature_request.md"), False),
    (os.path.join(".github", "pull_request_template.md.backup.md"), True),
    (os.path.join(".github", "ISSUE_TEMPLATE-old.md"), True),
    (os.path.join(".github", "pull_request_template.md.orig"), True),
    ("README.md", True),
    (os.path.join("00_Physics", "topics", "energy.md"), True),
]


def self_test() -> int:
    """Assert the H1 exemption boundary and the heading slugs."""
    bad = 0
    for rel, want in H1_EXEMPT_CASES:
        got = needs_h1(rel)
        ok = got == want
        bad += not ok
        print(f"  {'ok  ' if ok else 'FAIL'}  needs_h1={got!s:5s}  {rel}")
    for heading, want in SLUG_CASES:
        got = slugify(heading)
        ok = got == want
        bad += not ok
        print(f"  {'ok  ' if ok else 'FAIL'}  slug={got!r:32s} {heading!r}")
    total = len(H1_EXEMPT_CASES) + len(SLUG_CASES)
    print(f"\n{total - bad}/{total} H1 exemption and slug cases pass")
    return 1 if bad else 0


LINK_RE = re.compile(r"(?<!!)\[([^\]]*)\]\(([^)]+)\)")
IMAGE_RE = re.compile(r"!\[([^\]]*)\]\(([^)]+)\)")
FENCE_RE = re.compile(r"^```", re.M)
CODE_SPAN_RE = re.compile(r"`[^`\n]*`")


def strip_code(text: str) -> str:
    """Blank out fenced blocks and inline spans, preserving line structure."""
    out, fenced = [], False
    for line in text.split("\n"):
        if line.lstrip().startswith("```"):
            fenced = not fenced
            out.append("")
            continue
        out.append("" if fenced else CODE_SPAN_RE.sub("", line))
    return "\n".join(out)


HEADING_RE = re.compile(r"^(#{1,6})\s+(.*?)\s*#*\s*$")
HTML_ANCHOR_RE = re.compile(r"""<a\s+(?:id|name)=["']([^"']+)["']""")
INLINE_LINK_RE = re.compile(r"\[([^\]]*)\]\([^)]*\)")


def slugify(text: str) -> str:
    """A heading's anchor, as GitHub generates it.

    Link syntax keeps only its text; then lowercase, drop everything that is
    not a letter, mark, number, connector, space or hyphen, and turn spaces
    into hyphens. Python's \\w covers letters, numbers and the underscore.
    """
    text = INLINE_LINK_RE.sub(r"\1", text).lower()
    text = "".join(c for c in text if c.isalnum() or c in "_- ")
    return text.replace(" ", "-")


# Headings that exist in this codex, and the anchors GitHub gives them.
SLUG_CASES = [
    ("Manual Pages", "manual-pages"),
    ("In this layer", "in-this-layer"),
    ("Firmware / BIOS — Topics", "firmware--bios--topics"),
    ("Algorithms & Data Structures", "algorithms--data-structures"),
    ("`perf` and [eBPF](x.md)", "perf-and-ebpf"),
    ("I²C / SPI", "i²c--spi"),
]


_anchor_cache: dict[str, set[str]] = {}


def anchors_in(path: str) -> set[str]:
    """Every anchor a file defines: heading slugs (with GitHub's -1, -2
    suffixes for repeats) plus explicit <a id> / <a name> targets."""
    if path in _anchor_cache:
        return _anchor_cache[path]
    with open(path, encoding="utf-8") as fh:
        raw = fh.read()
    found: set[str] = set()
    counts: dict[str, int] = {}
    fenced = False
    for line in raw.split("\n"):
        if line.lstrip().startswith("```"):
            fenced = not fenced
            continue
        if fenced:
            continue
        found.update(HTML_ANCHOR_RE.findall(line))
        m = HEADING_RE.match(line)
        if not m:
            continue
        slug = slugify(m.group(2))
        n = counts.get(slug, 0)
        counts[slug] = n + 1
        found.add(slug if n == 0 else f"{slug}-{n}")
    _anchor_cache[path] = found
    return found


def markdown_files(root: str) -> list[str]:
    return sorted(path for path, _ in _common.walk_markdown(root))


def audit(root: str) -> tuple[dict, list, list]:
    stats = {"files": 0, "links": 0, "images": 0, "external": 0, "anchors": 0}
    broken, no_h1 = [], []

    for path in markdown_files(root):
        stats["files"] += 1
        with open(path, encoding="utf-8") as fh:
            raw = fh.read()
        rel = os.path.relpath(path, root)
        if needs_h1(rel) and not re.search(r"^# ", raw, re.M):
            no_h1.append(rel)

        body = strip_code(raw)
        for regex, is_image in ((LINK_RE, False), (IMAGE_RE, True)):
            for match in regex.finditer(body):
                href = match.group(2).strip().split(" ")[0]

                if href.startswith(("http://", "https://", "mailto:")):
                    stats["external"] += 1
                    continue
                if href.startswith("#"):
                    stats["anchors"] += 1
                    if urllib.parse.unquote(href[1:]) not in anchors_in(path):
                        broken.append((rel, href + "  (no such heading)"))
                    continue

                stats["images" if is_image else "links"] += 1
                target, _, anchor = href.partition("#")
                target = urllib.parse.unquote(target)
                if not target:
                    continue

                resolved = os.path.normpath(
                    os.path.join(os.path.dirname(path), target)
                )
                if not os.path.exists(resolved):
                    broken.append((rel, href))
                    continue
                if anchor:
                    if os.path.isdir(resolved):
                        resolved = os.path.join(resolved, "README.md")
                    if (resolved.endswith(".md") and os.path.isfile(resolved)
                            and urllib.parse.unquote(anchor)
                            not in anchors_in(resolved)):
                        broken.append((rel, href + "  (no such heading)"))

    return stats, broken, no_h1


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", default=os.path.dirname(os.path.dirname(
        os.path.abspath(__file__))))
    parser.add_argument("--verbose", action="store_true")
    parser.add_argument("--self-test", action="store_true",
                        help="assert the H1 exemption boundary, then exit")
    args = parser.parse_args()

    if args.self_test:
        return self_test()

    stats, broken, no_h1 = audit(args.root)

    print(f"markdown files   {stats['files']}")
    print(f"internal links   {stats['links']}")
    print(f"images           {stats['images']}")
    print(f"external links   {stats['external']}")
    print(f"anchor links     {stats['anchors']}")
    print(f"files without H1 {len(no_h1)}")

    if no_h1:
        print(f"\nmissing an H1 heading ({len(no_h1)}):")
        for rel in no_h1:
            print(f"  {rel}")

    if broken:
        print(f"\nBROKEN ({len(broken)}):")
        for src, href in broken:
            print(f"  {src}  ->  {href}")
        return 1

    print("\nno broken links")
    return 1 if no_h1 else 0


if __name__ == "__main__":
    sys.exit(main())
