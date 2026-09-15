# CPU — References

## What is in this section

```text
  Four kinds of source, and at this layer the manuals matter more than the
  books — an ISA is defined by its vendor document, not by a textbook.

  ┌─ books — how to think about it ──────────────────────────────────────┐
  │  Hennessy & Patterson, Quantitative Approach — the standard          │
  │  Patterson & Hennessy, Computer Organization — undergrad             │
  │  Stokes, Inside the Machine — accessible microarch tour              │
  │  Patterson & Waterman, The RISC-V Reader — concise                   │
  │  Warren, Hacker's Delight — bit-manipulation idioms                  │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─ the ISA itself — what is actually guaranteed ───────────────────────┐
  │  Intel SDM (multi-volume) · AMD64 APM (five volumes)                 │
  │  Arm ARM — A, M and R profiles                                       │
  │  RISC-V manual — Vol. I unprivileged, Vol. II privileged             │
  │  Power ISA — OpenPOWER                                               │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─ optimization guides — what is fast, which no ISA manual says ───────┐
  │  Agner Fog's manuals · uops.info — latency and throughput per        │
  │  instruction, measured rather than specified                         │
  │  Intel Optimization Reference Manual                                 │
  │  Arm Cortex-A Software Optimization Guides                           │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─ papers — what turned out to be wrong ───────────────────────────────┐
  │  Spectre (Kocher et al.) · Meltdown (Lipp et al.)            → 14    │
  │  Nagarajan et al., A Primer on Memory Consistency and Cache          │
  │  Coherence                                                           │
  └──────────────────────────────────────────────────────────────────────┘
```

## Books
- *Computer Architecture: A Quantitative Approach* — Hennessy & Patterson. The standard.
- *Computer Organization and Design (RISC-V Edition)* — Patterson & Hennessy. Undergrad foundation.
- *Inside the Machine* — Jon Stokes. Accessible microarch tour of Intel/AMD/PowerPC.
- *The RISC-V Reader* — Patterson & Waterman. Concise RISC-V intro.
- *Hacker's Delight* — Henry Warren. Bit-manipulation idioms.

## Official ISA manuals (the canonical references)
- **Intel® 64 and IA-32 Architectures Software Developer's Manual** — multi-volume PDF set.
- **AMD64 Architecture Programmer's Manual** — five volumes.
- **Arm Architecture Reference Manual (ARM ARM)** — A-profile, M-profile, R-profile.
- **RISC-V Instruction Set Manual** — Volume I (unprivileged), Volume II (privileged).
- **Power ISA** — OpenPOWER Foundation.

## Microarchitecture / optimization
- **Agner Fog's optimization manuals** — `https://www.agner.org/optimize/`. Microarch + instruction tables.
- **uops.info** — instruction latency/throughput database.
- **Intel Optimization Reference Manual**
- **Arm Cortex-A series Software Optimization Guides**

## Papers worth knowing
- Spectre (Kocher et al.), Meltdown (Lipp et al.) — speculative execution attacks
- "A Primer on Memory Consistency and Cache Coherence" — Nagarajan et al.
