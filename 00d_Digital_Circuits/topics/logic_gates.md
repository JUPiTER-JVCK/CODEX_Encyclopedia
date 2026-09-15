---
title: Logic Gates Explained
layer: 00d_Digital_Circuits
section: topics
tags: [logic-gates, boolean, truth-tables, combinational]
updated: 2026-05-20
v1_source: v1 collection — Math/Logic/Data › Logic › Boolean logic gates (HTML)
---

# Logic Gates Explained

> Truth tables and symbols for the 8 basic Boolean gates. Together with their
> CMOS implementations these are the atomic units of every digital design
> above this layer.

## About the symbols

Gates are drawn here in the **IEC 60617-12 rectangular** notation: a box with
a qualifying symbol inside, and a bubble `○` on the output of a negated gate.
`1` means "pass through", `&` means AND, `≥1` means "one or more", `=1` means
"exactly one".

The distinctive ANSI/IEEE 91 shapes — the bullet for AND, the shield for OR —
are what most readers picture, and they are what an earlier version of this
file attempted. It drew AND with the buffer's triangle, so AND and YES were
the same picture; it drew NAND and NOR without their inversion bubbles, so
they were the same picture as AND and OR; and four of the eight gates had no
symbol at all. Those shapes turn on curves, which a monospace grid can only
approximate with a few ambiguous corners. The rectangles differ from each
other by characters that are either present or not, so they cannot quietly
collapse into each other the same way.

| Gate | Here | ANSI/IEEE 91 distinctive shape |
|------|------|--------------------------------|
| YES  | `1`    | triangle |
| NO   | `1` ○  | triangle with an output bubble |
| AND  | `&`    | flat back, semicircular front |
| NAND | `&` ○  | AND with an output bubble |
| OR   | `≥1`   | concave back, pointed front |
| NOR  | `≥1` ○ | OR with an output bubble |
| XOR  | `=1`   | OR with a second concave line behind the back |
| XNOR | `=1` ○ | XOR with an output bubble |

## Unary gates

### YES (buffer)

```text
        ┌─────┐
  A ────┤  1  ├──── Y
        └─────┘
```

| A | Y |
|---|---|
| 0 | 0 |
| 1 | 1 |

`Y = A`. A buffer is logically the identity, but electrically restores drive strength.

### NO (NOT / inverter)

```text
        ┌─────┐
  A ────┤  1  ├○─── Y
        └─────┘
```

| A | Y |
|---|---|
| 0 | 1 |
| 1 | 0 |

`Y = ¬A`.

## Binary gates

### AND

```text
        ┌─────┐
  A ────┤     │
        │  &  ├──── Y
  B ────┤     │
        └─────┘
```

| A | B | Y |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

`Y = A · B`. Output is 1 only when *all* inputs are 1.

### OR

```text
        ┌─────┐
  A ────┤     │
        │ ≥1  ├──── Y
  B ────┤     │
        └─────┘
```

| A | B | Y |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 1 |

`Y = A + B`. Output is 1 if *any* input is 1.

### XOR (exclusive OR)

```text
        ┌─────┐
  A ────┤     │
        │ =1  ├──── Y
  B ────┤     │
        └─────┘
```

| A | B | Y |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

`Y = A ⊕ B = A·¬B + ¬A·B`. Output is 1 if inputs differ. The arithmetic
bit-add primitive (carry handled separately).

### NAND

```text
        ┌─────┐
  A ────┤     │
        │  &  ├○─── Y
  B ────┤     │
        └─────┘
```

| A | B | Y |
|---|---|---|
| 0 | 0 | 1 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

`Y = ¬(A · B)`. **Functionally complete** — any Boolean function can be built
from NAND alone. Reason: invert + AND + OR can all be derived from NAND.

### NOR

```text
        ┌─────┐
  A ────┤     │
        │ ≥1  ├○─── Y
  B ────┤     │
        └─────┘
```

| A | B | Y |
|---|---|---|
| 0 | 0 | 1 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 0 |

`Y = ¬(A + B)`. Also functionally complete on its own.

### XNOR (equivalence)

```text
        ┌─────┐
  A ────┤     │
        │ =1  ├○─── Y
  B ────┤     │
        └─────┘
```

| A | B | Y |
|---|---|---|
| 0 | 0 | 1 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

`Y = ¬(A ⊕ B)`. Output is 1 if inputs are equal — useful for comparators.

## All eight at a glance

The six binary gates side by side. Read a row as one input combination and
follow it across — this is the whole of two-input Boolean logic in one table,
and it is what the never-committed reference image was going to show.

| A | B | AND | NAND | OR | NOR | XOR | XNOR |
|---|---|-----|------|----|-----|-----|------|
| 0 | 0 | 0 | 1 | 0 | 1 | 0 | 1 |
| 0 | 1 | 0 | 1 | 1 | 0 | 1 | 0 |
| 1 | 0 | 0 | 1 | 1 | 0 | 1 | 0 |
| 1 | 1 | 1 | 0 | 1 | 0 | 0 | 1 |

Each negated column is the bitwise complement of the one to its left, which is
the bubble in the symbol. AND and OR agree only on `0 0` and `1 1`; XOR is OR
with the `1 1` case taken back out.

The two unary gates, for completeness:

| A | YES | NO |
|---|-----|----|
| 0 | 0 | 1 |
| 1 | 1 | 0 |

## Algebraic identities (Boolean algebra)

| Identity | Form |
|----------|------|
| Identity | A + 0 = A ; A · 1 = A |
| Null | A + 1 = 1 ; A · 0 = 0 |
| Idempotent | A + A = A ; A · A = A |
| Complement | A + ¬A = 1 ; A · ¬A = 0 |
| Double negation | ¬¬A = A |
| Commutative | A + B = B + A ; A · B = B · A |
| Associative | (A+B)+C = A+(B+C) ; (A·B)·C = A·(B·C) |
| Distributive | A·(B+C) = A·B + A·C ; A+(B·C) = (A+B)·(A+C) |
| **De Morgan I** | ¬(A · B) = ¬A + ¬B |
| **De Morgan II** | ¬(A + B) = ¬A · ¬B |
| Absorption | A + A·B = A ; A · (A+B) = A |
| Consensus | A·B + ¬A·C + B·C = A·B + ¬A·C |

## CMOS implementation note

Every gate above is built from complementary pairs of NMOS and PMOS transistors
(see [00b_Devices/topics](../../00b_Devices/topics/INDEX.md)):

- **NMOS pulldown network** to GND
- **PMOS pullup network** to VDD
- Series PMOS / parallel NMOS = NAND
- Parallel PMOS / series NMOS = NOR

XOR/XNOR are more expensive (8 transistors) so synthesis tools often build
them as AND-OR-INVERT combinations.

## Functional completeness — what you actually need

Any Boolean function can be built using only:
- `{AND, OR, NOT}` (the textbook set), **or**
- `{NAND}` alone, **or**
- `{NOR}` alone

That's why NAND/NOR are the most common standard-cell library primitives.

## Cross-references

- Transistor-level construction → [00b_Devices/topics](../../00b_Devices/topics/INDEX.md) (CMOS section)
- Built into adders / multiplexers → [topics/INDEX.md](INDEX.md) (combinational logic)
- Synthesized from HDL → [languages/INDEX.md](../languages/INDEX.md)
- Migrated from the v1 *Boolean logic gates* HTML reference; the truth
  tables above are the full transcription, so the original is not needed
