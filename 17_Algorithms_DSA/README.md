# 17 — Algorithms & Data Structures (Cross-cutting)

> The CS-interview / problem-solving layer. Patterns and data structures that
> recur in every layer above. Anchored on the
> [100 must-do problems list](100_must_do.md), plus the canonical
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

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | books, judges, canonical lists |
| [Lessons](#lessons) | [Interactive labs](dsa_labs.md) | ordered study path |
| [Languages](#languages) | — | which language for interviews |
| [Manual Pages](#manual-pages) | — | judges, runners, profilers |
| [Topics](#topics) | [100 Must Do LeetCode Problems](100_must_do.md) · [Canonical 100-problem study list](canonical_lists.md) | pattern catalog with template solutions |
| [Protocols](#protocols) | — | interview process conventions |

## Anchor reference
- [100 Must Do LeetCode Problems](100_must_do.md) — 100 problems, each mapped
  to its LeetCode number and title, organised by topic. It began as a
  transcription of Bosscoder Academy's *100 Must Do LeetCode Problems* PDF.
  The PDF itself is no longer in the repository: it carried no licence, so
  it could not be redistributed under this repository's terms.

## Cross-references
- Runtime / language performance → [07_Runtime_Environment](../07_Runtime_Environment/)
- ML algorithm choice → [AI / ML › Topics](../15_AI_ML/README.md#topics)
- Crypto primitives & algos → [Security › Topics](../14_Security/README.md#topics)

---

## References

### What is in this section

```text
  Books, problem sets, and canonical study lists for DSA prep.

  ┌─── foundational books ────────────────────────────────────────────────┐
  │  CLRS (reference) · Skiena (approachable) · Sedgewick (Java)         │
  │  Competitive Programming Handbook (free PDF)                          │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── interview books ───────────────────────────────────────────────────┐
  │  Cracking the Coding Interview (CTCI) · EPI (Python/Java/C++)        │
  │  Grokking Algorithms · Grokking the Coding Interview                  │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── online & canonical lists ──────────────────────────────────────────┐
  │  LeetCode · Codeforces · AtCoder · CSES · Advent of Code             │
  │  Blind 75 · NeetCode 150 · Grind 75 · Striver SDE Sheet              │
  └──────────────────────────────────────────────────────────────────────┘
```

### Anchor list
- **[100 Must Do LeetCode Problems](100_must_do.md)** — the 100 problems to work through,
  mapped to LeetCode numbers. Pair with [Canonical 100-problem study list](canonical_lists.md).
  Source: Bosscoder Academy's *100 Must Do LeetCode Problems*. Their PDF is not kept
  here; it carried no licence, so this repository could not redistribute it.

### Books — foundational
- *Introduction to Algorithms* (CLRS) — Cormen, Leiserson, Rivest, Stein. The reference.
- *Algorithm Design Manual* — Steven Skiena. More approachable.
- *Algorithms* — Sedgewick & Wayne. Java-flavored, online course companion.
- *Algorithms, 4th ed.* — Robert Sedgewick (also online).
- *Competitive Programming Handbook* — Antti Laaksonen (free PDF).

### Books — interview-focused
- *Cracking the Coding Interview* — Gayle Laakmann McDowell.
- *Elements of Programming Interviews* (Python / Java / C++ versions) — Aziz, Lee, Prakash.
- *Grokking Algorithms* — Aditya Bhargava (visual, gentle).
- *Grokking the Coding Interview* + *Grokking Dynamic Programming* — DesignGurus.

### Online problem sets
- **LeetCode** — `https://leetcode.com/`
- **HackerRank** — `https://www.hackerrank.com/`
- **Codeforces** — competitive
- **AtCoder** — Japanese competitive (beginner contests excellent)
- **CSES Problem Set** — `https://cses.fi/problemset/`
- **Project Euler** — math-heavy
- **Advent of Code** — annual, narrative
- **USACO Guide** — structured by skill level

### Canonical study lists
- **Blind 75** — Yangshun's curated 75-problem list (foundational patterns)
- **NeetCode 150 / 250 / All** — Navdeep Singh's expanded set with video solutions
- **Grind 75 / Grind 169** — adjustable timeline version of Blind 75
- **Sean Prashad's Leetcode Patterns** — pattern-tagged list
- **Striver's SDE Sheet** — Indian-interview popular
- **LeetCode Top Interview 150** — LC's own curated list

### Algo viz
- VisuAlgo (`https://visualgo.net/`)
- Algorithm Visualizer
- BigOcheatsheet (`https://www.bigocheatsheet.com/`)

---

## Lessons

### What is in this section

```text
  Lesson ladder: pre-flight → patterns → mocks → system design.

  ┌─── dedicated module ──────────────────────────────────────────────────┐
  │  dsa_labs.md (Big-O measurement · binary search · graph BFS/DFS · DP)│
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── pattern ladder (3–20) ─────────────────────────────────────────────┐
  │  arrays/hashing · two pointers · sliding window · stack · binary search│
  │  linked list · trees · tries · heap · backtracking · graphs           │
  │  Dijkstra/MST/Union-Find · 1-D DP · 2-D DP · greedy · intervals      │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── beyond the 100 (21–24) ────────────────────────────────────────────┐
  │  mock interviews · system design · OOP design · behavioral (STAR)     │
  └──────────────────────────────────────────────────────────────────────┘
```

### Dedicated Lesson Modules

| File | Covers |
|------|--------|
| [Algorithms & DSA — Interactive Labs](dsa_labs.md) | Big-O measurement, binary search, graph BFS/DFS, DP |

### Lesson ladder

Ordered ladder. Goal: complete one bucket per week, write a notes file after each.

### Pre-flight
0. **Pick a language** — see [Languages](#languages). Python is most ergonomic for LC; C++/Java if you compete.
1. **Re-learn Big-O** — read the complexity part of [Topics](#topics). Drill 5 examples.
2. **Master the workflow** — clarify → examples → brute force → optimize → code → test → complexity. Practice the script aloud.

### Pattern ladder (matches `canonical_lists.md`)
3. **Arrays & Hashing** — 5–8 problems
4. **Two Pointers** — 5 problems
5. **Sliding Window** — 5–6 problems
6. **Stack** — 5–7 problems
7. **Binary Search** — 5–7 problems
8. **Linked List** — 8–10 problems (LRU is a milestone)
9. **Trees** — 10–15 problems (level order, recursion patterns, BST)
10. **Tries** — 3 problems (build one from scratch)
11. **Heap / Priority Queue** — 5–7 problems (median streams; Top K patterns)
12. **Backtracking** — 7–10 problems (subsets/permutations/combinations + word search)
13. **Graphs** — 10–13 problems (BFS/DFS, islands, topo sort)
14. **Advanced Graphs** — Dijkstra, Bellman-Ford, MST (Kruskal/Prim), Union-Find
15. **1-D DP** — 10–12 problems (climbing stairs → LIS)
16. **2-D DP** — 10–12 problems (LCS, edit distance, knapsack family)
17. **Greedy** — 6–8 problems
18. **Intervals** — 5 problems
19. **Math & Geometry** — 5–7 problems (Pow(x,n), bit tricks)
20. **Bit Manipulation** — 5–7 problems

### After the 100
21. **Mock interviews** — Pramp, Interviewing.io, friends; 5 mocks minimum.
22. **System design** — Grokking the System Design, ByteByteGo (Alex Xu).
23. **OOP design** — design patterns + LC tagged "design" problems (LRU, Twitter, Snake, Iterator).
24. **Behavioral** — STAR stories, 8–10 ready.

### Daily practice (steady state)
- 1 LeetCode medium / day
- Friday: 1 hard from a pattern you're weakest in
- Sunday: re-solve 3 last-week problems from memory

### Suggested external
- NeetCode YouTube — pattern walkthroughs
- Errichto (competitive) — for tricks beyond interviews
- William Lin (competitive)
- *Algorithms* (Sedgewick) free Coursera courses

---

## Languages

### What is in this section

```text
  Language picks for interview and competitive programming.

  ┌─── language choice by goal ───────────────────────────────────────────┐
  │  most companies → Python  ·  competitive → C++ (STL)                 │
  │  FAANG systems  → Go/C++  ·  personal     → whichever you type blind  │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── what you actually need per language ───────────────────────────────┐
  │  Python: collections · heapq · bisect · functools · itertools         │
  │  C++: bits/stdc++.h · map/set/unordered · priority_queue (min-heap)  │
  │  Java: ArrayList · HashMap · PriorityQueue · int[] vs Integer[]       │
  │  Go: container/heap · sort.Slice · map zero-value awareness           │
  └──────────────────────────────────────────────────────────────────────┘
```

Pick one and stay with it — fluency in a single language beats breadth once
the clock is running.

### Quick recommendation
| Goal | Pick |
|------|------|
| Get hired (most companies) | **Python** |
| FAANG-style + system design | **Python** or **Java** |
| Competitive programming | **C++** (STL is unbeatable) |
| Big Tech systems roles | **Go** or **C++** |
| Personal preference + speed | whichever you can code without thinking |

### Python — what you actually need
```python
from collections import Counter, defaultdict, deque, OrderedDict
from heapq import heappush, heappop, heapify, nlargest, nsmallest
from bisect import bisect_left, bisect_right, insort
from functools import lru_cache, cache, reduce, cmp_to_key
from itertools import combinations, permutations, product, accumulate, chain, groupby
from math import inf, gcd, lcm, isqrt, comb, perm
from typing import List, Dict, Optional
```

- `dict` is ordered (3.7+)
- `set` literals: `{1,2,3}`
- f-strings + walrus operator (`:=`)
- `sorted(...)` stable, `lambda x: (x[0], -x[1])` for compound keys
- `nonlocal` for closure mutation
- For DFS recursion past depth ~1000: `sys.setrecursionlimit(10**6)`

### C++ — what you actually need
```cpp
#include <bits/stdc++.h>          // catch-all (GCC)
using namespace std;
using ll = long long;
using vi = vector<int>;
```

- `unordered_map` / `unordered_set` for O(1) avg
- `map` / `set` for ordered (lower_bound, upper_bound)
- `priority_queue<int, vector<int>, greater<>>` for min-heap
- `gcc-specific`: `__builtin_popcount`, `__builtin_clz`, `__lg`
- `auto& [k, v] : map` structured bindings
- `ios_base::sync_with_stdio(false); cin.tie(nullptr);` for fast I/O

### Java — what you actually need
```java
import java.util.*;
import java.util.stream.*;
```

- `ArrayList` / `LinkedList` / `ArrayDeque` (NOT `Stack` — it's synchronized)
- `HashMap` / `LinkedHashMap` / `TreeMap`
- `PriorityQueue` (min-heap by default)
- `int[]` is faster than `Integer[]` for primitives
- `String.toCharArray()` for char ops

### Go — what you actually need
- `container/heap` + `container/list` (less ergonomic than C++/Python)
- `sort.Slice` for inline sort
- `map[K]V` zero value is nil — careful
- No generics in old code; modern code uses Go 1.18+ generics
- Verbose but very readable; few "gotchas"

### Other
- **Rust** — best for the discipline, slower in interview clock
- **Kotlin** — Java with less noise
- **JavaScript / TypeScript** — fine on LC, less common in interviews outside web
- **Swift** — fine but small interview audience

### Cross-link
- Runtime characteristics → [Runtime Environment › Topics](../07_Runtime_Environment/README.md#topics)
- Why CPython is slow → [CPU › Topics](../02_CPU/README.md#topics) + GIL note in [07](../07_Runtime_Environment/)

---

## Manual Pages

### What is in this section

```text
  Practice tooling: local runners, visualizers, and interview rehearsal.

  ┌─── local practice ────────────────────────────────────────────────────┐
  │  leetcode-cli · vscode-leetcode · competitive-companion               │
  │  pytest/cargo test/go test · hyperfine · valgrind/py-spy/pprof       │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── visualization & rehearsal ─────────────────────────────────────────┐
  │  VisuAlgo · Algorithm Visualizer · Graphviz (dot)                    │
  │  Pramp / Interviewing.io · CoderPad · rubber-duck the approach aloud  │
  └──────────────────────────────────────────────────────────────────────┘
```

Practice tooling rather than system utilities — CLIs and editor extensions for
working problems locally.

### Local practice
| Tool | Purpose |
|------|---------|
| `leetcode-cli` (npm) | Submit / fetch problems from terminal |
| `vscode-leetcode` (extension) | Solve in editor |
| `competitive-companion` browser ext | Auto-import problem to local |
| `cpbooster` / `competitive-helper` | Sample tests + auto-run |
| `pytest`, `cargo test`, `go test`, `mvn test` | Local unit tests for your solutions |
| `hyperfine` | Microbenchmark different solutions |
| `time` (shell builtin) | Quick timing |
| `valgrind --tool=callgrind` | C/C++ profiling |
| `py-spy` | Python sampling profiler |
| `pprof` (Go) | Profile + flamegraph |

### Visualization
| Tool | Purpose |
|------|---------|
| VisuAlgo (web) | Animated algorithm viz |
| Algorithm Visualizer (web) | Step-through |
| `python -m heapq_showtree`-style scripts | Custom DS viz |
| Graphviz (`dot`) | Render graphs / trees |

### Interview rehearsal
- Pramp, Interviewing.io, Tech Mock Interview
- ChatGPT / Claude as a rubber-duck (explain your approach aloud)
- `coderpad.io` — practice in a shared whiteboard env

### Setup scripts
- `~/.leetcode/` config — auth + language preset
- snippets per language in your editor (template main + I/O)
- `~/bin/lc` — wrapper script to scaffold new problem dir

---

## Topics

### What is in this section

```text
  Pattern cheatsheet: complexity → data structures → algorithms.

  ┌─── complexity & data structures ──────────────────────────────────────┐
  │  O(1)/O(log n)/O(n)/O(n log n)/O(n²)/O(2ⁿ)/O(n!) · amortized       │
  │  array · linked list · stack/queue/deque · hash map/set               │
  │  heap · tree (BST/AVL/seg tree/Fenwick) · trie · union-find · graph  │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── algorithm patterns ────────────────────────────────────────────────┐
  │  sorting · binary search · two-pointer · sliding window               │
  │  recursion/backtracking · DP (top-down/bottom-up) · greedy           │
  │  graph (BFS/DFS/Dijkstra/MST/topo) · bit manipulation · strings      │
  └──────────────────────────────────────────────────────────────────────┘
```

> Companion to [Canonical 100-problem study list](canonical_lists.md). Pattern cheatsheet.

### Complexity (Big-O)
- **O(1)** — hash lookup, array index
- **O(log n)** — binary search, balanced tree op
- **O(n)** — linear scan
- **O(n log n)** — comparison sort, divide-and-conquer
- **O(n²)** — nested loops, naive sort
- **O(n³)** — Floyd-Warshall, matrix multiply (naive)
- **O(2ⁿ)** — subsets, naive recursion
- **O(n!)** — permutations
- **Amortized** — dynamic array push = O(1) amortized
- **Space-time tradeoff** — memoization, hash maps

### Data structures
- **Array, dynamic array, string**
- **Linked list** — singly/doubly/circular; sentinel nodes
- **Stack, queue, deque, monotonic stack/queue**
- **Hash map / set** — open addressing vs chaining; load factor
- **Heap / priority queue** — binary heap, d-ary, Fibonacci (theoretical)
- **Tree** — BST, AVL, Red-Black, B/B+, segment tree, Fenwick (BIT)
- **Trie** — prefix tree; suffix tree/array
- **Union-Find (DSU)** — path compression + union by rank/size
- **Graph** — adjacency list / matrix; weighted; directed
- **Bloom filter, Cuckoo filter, HyperLogLog** — approximate
- **Skip list** — probabilistic balanced
- **Disjoint set** = union-find synonym

### Sorting
- **Comparison** — merge sort, quicksort (intro/quick3), heapsort, Timsort (Python/Java)
- **Linear-time** — counting sort, radix sort, bucket sort
- **Stable vs unstable**
- **In-place vs not**

### Searching
- **Linear**, **binary**, **ternary**, **exponential**, **interpolation**
- **Binary search on the answer** (parametric search) — a power pattern

### Two-pointer / sliding window patterns
- Fixed-size window
- Variable window (shrink while condition violated)
- Fast/slow pointers (cycle detection — Floyd)
- Opposite-end pointers (Two Sum II, 3Sum)

### Recursion & backtracking
- Decision tree: include/exclude, pick-next
- Pruning: early return on infeasible
- Permutations vs combinations vs subsets

### Dynamic programming
- **Recipe**: state, transition, base, order
- **Top-down (memo)** vs **bottom-up (tabulation)**
- **Space optimization** — keep only last row(s)
- **Common patterns** — knapsack 0/1, unbounded, LIS, LCS, edit distance, partition, interval, bitmask DP, tree DP, digit DP

### Greedy
- Local optimum → global; prove with exchange argument
- Often paired with sorting

### Graph algorithms
- **Traversal** — BFS, DFS (iterative + recursive)
- **Shortest path** — Dijkstra (positive weights), Bellman-Ford (neg ok), Floyd-Warshall (all pairs), 0-1 BFS, A*
- **MST** — Kruskal (with DSU), Prim
- **Topological sort** — Kahn's BFS, DFS post-order
- **SCC** — Tarjan, Kosaraju
- **Bridges / articulation points** — Tarjan
- **Max flow** — Ford-Fulkerson / Edmonds-Karp / Dinic
- **Bipartite matching** — Hungarian, Hopcroft-Karp
- **Eulerian path** — Hierholzer

### Bit manipulation
- `x & (x-1)` clears lowest set bit
- `x & -x` isolates lowest set bit
- Popcount, parity
- Bitmask DP
- XOR tricks (Single Number, swap without temp)

### Strings
- KMP / Z-function for pattern matching
- Rabin-Karp (rolling hash)
- Aho-Corasick (multi-pattern)
- Manacher's (longest palindrome)
- Suffix array / suffix automaton

### Math / number theory
- GCD/LCM, Euclidean
- Sieve of Eratosthenes; segmented sieve
- Modular exponentiation, modular inverse
- Combinatorics — nCr mod p
- Matrix exponentiation (Fibonacci in O(log n))
- FFT/NTT (advanced)

### Interview workflow
1. **Clarify** — input range, constraints, output format, edge cases
2. **Examples** — work 1–2 by hand
3. **Brute force** — state it, note O(...)
4. **Optimize** — pattern match, ID DS that gives better complexity
5. **Code** — clean, named vars, test as you go
6. **Test** — example + edge cases (empty, single, max)
7. **Complexity** — time & space, clearly stated

---

## Protocols

### What is in this section

```text
  Conventions of the interview and competitive programming process.

  ┌─── interview process ─────────────────────────────────────────────────┐
  │  recruiter screen → phone/OA → onsite (coding + design + behavioral) │
  │  rubric: communication · problem-solving · coding · verification      │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── competitive programming ───────────────────────────────────────────┐
  │  Codeforces / AtCoder / ICPC · Elo/band rating systems                │
  │  verdicts: AC · WA · TLE · MLE · RE · CE                             │
  │  constraint → algorithm: n≤20 bitmask · n≤1e5 n log n · n≤1e9 log  │
  └──────────────────────────────────────────────────────────────────────┘
```

Not network protocols — these are the *conventions* of the algorithmic
interview / competition process.

### Interview process (standard FAANG-style)
1. **Recruiter screen** — basic fit + scheduling
2. **Phone / online screen** — 1 medium LC, sometimes 2 easies
3. **Onsite / virtual onsite** — 4–6 rounds:
   - 2–4 × coding (LC medium/hard)
   - 1 × system design (senior+)
   - 1 × behavioral / values
   - 1 × domain deep-dive (sometimes)
4. **Debrief & offer** — hiring committee

### Common rubric dimensions
- **Communication** — think out loud, clarify, narrate decisions
- **Problem solving** — pattern recognition, decomposition, brute → optimal progression
- **Coding** — clean, idiomatic, no syntax errors, named vars
- **Verification** — your own test cases, dry-run, edge cases
- **Complexity analysis** — correct Big-O time + space, justified

### Competitive programming conventions
- **Online judges** — Codeforces, AtCoder, ICPC Live Archive, SPOJ
- **Rating systems** — Codeforces Elo-like; AtCoder colored bands
- **Contest format** — short (90 min × 4–6 problems) vs long (≥3 h × 6–12)
- **Submission verdicts** — AC (Accepted), WA (Wrong Answer), TLE, MLE, RE, CE
- **Constraints inform algorithm** — `n ≤ 20` → bitmask; `n ≤ 1e5` → n log n; `n ≤ 1e9` → log/math

### Etiquette during the interview
- Repeat the problem in your own words
- Ask about input/output format & ranges
- State assumptions explicitly
- If stuck, say so — interviewer may hint
- Don't grab the brute force and quit; show you can iterate
- Test before declaring done

### Cross-link
- Behavioral / soft skills → [Embedded Systems › Topics](../18_Embedded_Systems/README.md#topics) (general soft-skills section also applies)
