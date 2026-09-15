# Third-party attribution

This project's own code is MIT (`LICENSE`) and its prose is CC BY-SA 4.0
(`LICENSE-docs`). This file records everything here that came from somewhere
else.

## Colour schemes

`Codex_macOS/Sources/Codex/Palettes.swift` ships fourteen palettes drawn from
seven open-source colour schemes. What is reproduced is **colour values only**
— hex triples — and no code, assets, or configuration from any of them.

All seven are MIT-licensed.

| Scheme | Palettes here | Upstream |
|---|---|---|
| Catppuccin | Latte, Frappé, Macchiato, Mocha | <https://github.com/catppuccin/catppuccin> |
| Nord | Nord | <https://github.com/nordtheme/nord> |
| Gruvbox | Gruvbox Light, Gruvbox Dark | <https://github.com/morhetz/gruvbox> |
| Solarized | Solarized Light, Solarized Dark | <https://github.com/altercation/solarized> |
| Tokyo Night | Tokyo Night | <https://github.com/enkia/tokyo-night-vscode-theme> |
| Rosé Pine | Dawn, Moon, Main | <https://github.com/rose-pine/rose-pine-theme> |
| Dracula | Dracula | <https://github.com/dracula/dracula-theme> |

### Fidelity: 41 of 364 values are derived, not published

Codex needs **26 tokens** per scheme — a nine-step surface/overlay ramp, three
text tones, and fourteen accents — named after Catppuccin's, because that is
what the app was built against. Every other scheme is *mapped* onto those
names.

Two things follow, and both are worth stating rather than glossing.

**Accents repeat where a scheme has fewer than fourteen.** Nord publishes nine
usable accents, Solarized eight, Gruvbox seven, Rosé Pine six. In those schemes
some tokens necessarily share a colour — in Nord, `maroon` repeats `red` and
`pink` repeats `mauve`. That is better than the alternative.

**Some surface steps are interpolated.** Nord publishes four polar-night
shades; the ramp needs nine. So five Nord greys here were derived by
interpolating between published steps — they are *not* Nord colours, and an
earlier version of this file claimed otherwise. Review caught it. The honest
count, per scheme:

| Scheme | Derived | Scheme | Derived |
|---|---|---|---|
| Catppuccin ×4 | **0** | Solarized Dark | 4 |
| Gruvbox Light | **0** | Rosé Pine ×3 | 5–6 |
| Gruvbox Dark | 1 | Nord | 5 |
| Tokyo Night | 3 | Dracula | 9 |
| Solarized Light | 3 | | |

**41 of 364 values — 11%.** Catppuccin and Gruvbox Light are exact.

`tools/palette_audit.py` enforces this. Each palette declares how many values
it may derive, and the audit fails if the real count differs in either
direction — too many means a new invention slipped in, too few means the
declaration went stale. It runs in CI, and `--self-test` proves it can fail by
planting an invented colour and checking it is caught. Prose cannot enforce
itself; that is the whole reason this section has a tool behind it.

If a mapping reads wrong against the upstream scheme, it is a bug here and not
in theirs.

## MIT licence text

All seven schemes above are distributed under the MIT licence, whose terms are:

```
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

Copyright is held by each scheme's respective authors, per the upstream
repositories linked above.

## Reference material

Two PDFs are vendored as reference material rather than authored here:

- `17_Algorithms_DSA/references/100_leetcode_problems.pdf`
- `18_Embedded_Systems/references/embedded_systems_full_roadmap_book.pdf`

These are third-party documents retained for study. They are not covered by
this repository's licences, and their own terms apply.

## Fonts

None are bundled. The macOS reader uses the system faces (SF Pro, SF Mono) via
`.system`, and the CORE web app loads Poppins, Lora and JetBrains Mono from
Google Fonts at runtime — all three are SIL Open Font License 1.1.
