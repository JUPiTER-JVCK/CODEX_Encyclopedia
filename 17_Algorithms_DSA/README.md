# 17 — Algorithms & Data Structures (Cross-cutting)

> The CS-interview / problem-solving layer. Patterns and data structures that
> recur in every layer above. Anchored on the
> [100 must-do problems list](topics/100_must_do.md), plus the canonical
> Blind 75 / NeetCode 150 tracks.

## Across the stack

```text
this layer cuts across the stack rather than sitting in one place

  15  AI / ML              ─┐
  08  User Applications    ─┤
  07  Runtime Environment  ─┤      ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  06  System Libraries     ─┼──────┃  17  Algorithms & DSA                 ◀── here   ┃
  05  OS Kernel            ─┤      ┃      complexity · structures · problems          ┃
  02  CPU                  ─┘      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

every layer that holds code holds algorithms
```

## At a glance

| Field | Value |
|-------|-------|
| Spans | 02 → 08, 15 (any layer with code) |
| Description | Algorithms, data structures, complexity, interview prep |
| Languages | Python / C++ / Java / Go (pick one and stick) |
| Resources | LeetCode, HackerRank, Codeforces, AtCoder, CSES, Project Euler |

## What lives here

- **Complexity** — Big-O, amortized, space-time tradeoffs
- **Data structures** — arrays, strings, linked lists, stacks, queues, heaps, hash maps, trees, tries, graphs, segment trees, union-find, BIT, skip lists, bloom filters
- **Algorithms** — sorting, searching, two pointers, sliding window, prefix sums, recursion + backtracking, DP, greedy, divide & conquer, graph (BFS/DFS/Dijkstra/Bellman-Ford/Floyd-Warshall/topological sort/MST/SCC), bit manipulation, math/number theory
- **Patterns** — Blind 75, NeetCode 150, Grind 75, Sean Prashad list
- **System design** (interview style) — separate from arch ([engineering:architecture](../14_Security/) — different)
- **Competitive programming** — Codeforces, ICPC topics

## Sub-sections

- [references/](references/INDEX.md) — books, judges, canonical lists
- [lessons/](lessons/INDEX.md) — ordered study path
- [languages/](languages/INDEX.md) — which language for interviews
- [man_pages/](man_pages/INDEX.md) — judges, runners, profilers
- [topics/](topics/INDEX.md) — pattern catalog with template solutions
- [protocols/](protocols/INDEX.md) — interview process conventions

## Anchor reference
- [topics/100_must_do.md](topics/100_must_do.md) — 100 problems, each mapped
  to its LeetCode number and title, organised by topic. It began as a
  transcription of Bosscoder Academy's *100 Must Do LeetCode Problems* PDF.
  The PDF itself is no longer in the repository: it carried no licence, so
  it could not be redistributed under this repository's terms.

## Cross-references
- Runtime / language performance → [07_Runtime_Environment](../07_Runtime_Environment/)
- ML algorithm choice → [15_AI_ML/topics](../15_AI_ML/topics/INDEX.md)
- Crypto primitives & algos → [14_Security/topics](../14_Security/topics/INDEX.md)
