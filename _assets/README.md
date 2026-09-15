# `_assets/` — and why it is empty

**This folder holds no images, and that is the convention rather than an
oversight.** Every illustration in the codex is drawn in the markdown itself,
with box characters inside a ` ```text ` fence. A drawing in the source is
reviewable in a diff, searchable, correctable by editing a line, renderable
in any markdown viewer, and copy-pasteable into a terminal. A PNG of the same
drawing is none of those.

## The four that were promised

For over a year this file listed four images as *expected*, and four notes
across the codex each carried a *"drop the image here"* line for a file
nobody was going to drop. The last section of this file simultaneously
asserted that "the codex's markdown content already includes text
equivalents of each image". That was the honest half, and it is now the
whole of it: each of the four is drawn.

| What it showed | Where it lives now |
|---|---|
| A 9-layer hardware ladder | [`00_Physics/README.md`](../00_Physics/README.md) — *Layer ladder* |
| The 8 logic gates with truth tables | [`00d_Digital_Circuits/topics/logic_gates.md`](../00d_Digital_Circuits/topics/logic_gates.md) |
| A DSLogic/sigrok decoder catalog | [`01_Circuit_Board/protocols/embedded_bus_protocols_lookup.md`](../01_Circuit_Board/protocols/embedded_bus_protocols_lookup.md) |
| The Embedded Systems Roadmap v1.2.3 | [`18_Embedded_Systems/README.md`](../18_Embedded_Systems/README.md) |

Two of the four were third-party works in any case — the roadmap poster is
Meysam Parvizi's, CC BY-SA 4.0, and the decoder list was a screenshot of
somebody's application window. Transcribing their content and crediting the
source is both more useful here and cleaner than vendoring a copy.

## If you do need an image

Some things genuinely cannot be drawn in text: a photograph of a board, a die
shot, an oscilloscope capture. Those belong here.

1. Save the file here as `lowercase_with_underscores.ext`. PNG, JPG and SVG
   are all fine.
2. Reference it relatively, from a sub-section note:

   ```markdown
   ![Alt text](../../_assets/your_file.png)
   ```

3. Pair it with a text equivalent — an ASCII diagram or a markdown table —
   so the note stands on its own.

`tools/diagram_audit.py` fails the build on a reference to an image file that
is not in the repository, in prose or in `source_image:` frontmatter. The
four above went unnoticed for a year because nothing checked; a fifth cannot.

## Not here

PDFs live in the relevant layer's `references/` folder, not in this one —
`17_Algorithms_DSA/references/100_leetcode_problems.pdf` and
`18_Embedded_Systems/references/embedded_systems_full_roadmap_book.pdf`. See
[`THIRD_PARTY.md`](../THIRD_PARTY.md) for their terms.
