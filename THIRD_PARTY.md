# Third-party attribution

This project's own code is MIT (`LICENSE`) and its prose is CC BY-SA 4.0
(`LICENSE-docs`). This file records everything here that came from somewhere
else.

## Colour schemes

`Codex_macOS/Sources/Codex/Palettes.swift` ships fourteen palettes drawn from
six open-source colour schemes. What is reproduced is **colour values only** —
a set of hex triples per scheme — which is the whole of what these projects
publish. No code, assets, or configuration from any of them is included.

All six are MIT-licensed.

| Scheme | Palettes here | Upstream |
|---|---|---|
| Catppuccin | Latte, Frappé, Macchiato, Mocha | <https://github.com/catppuccin/catppuccin> |
| Nord | Nord | <https://github.com/nordtheme/nord> |
| Gruvbox | Gruvbox Light, Gruvbox Dark | <https://github.com/morhetz/gruvbox> |
| Solarized | Solarized Light, Solarized Dark | <https://github.com/altercation/solarized> |
| Tokyo Night | Tokyo Night | <https://github.com/enkia/tokyo-night-vscode-theme> |
| Rosé Pine | Dawn, Moon, Main | <https://github.com/rose-pine/rose-pine-theme> |
| Dracula | Dracula | <https://github.com/dracula/dracula-theme> |

**A note on fidelity.** Codex's design tokens are named after Catppuccin's,
because that is the scheme the app was built against. Every other scheme is
*mapped* onto those names, and the mapping is a judgement call wherever a
scheme publishes fewer accents than Catppuccin's fourteen — Nord has nine,
Solarized eight, Gruvbox seven, Rosé Pine six. In those schemes some tokens
necessarily share a colour (`red` and `maroon`, `mauve` and `pink`).

That is deliberate. The alternative is inventing colours the scheme's authors
never chose, which would misrepresent their work more than a repeat does. If
a mapping reads wrong to you against the upstream scheme, it is a bug in this
repository and not in theirs.

## MIT licence text

All six schemes above are distributed under the MIT licence, whose terms are:

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
