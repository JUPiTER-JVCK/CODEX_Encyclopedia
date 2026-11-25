# 02 — CPU

> The instruction executor. Reads opcodes, manipulates registers and memory,
> talks to the rest of the board over buses. Everything in software eventually
> compiles down to what this layer understands: machine code.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  03  Firmware / BIOS                         │
└───────────────────────┬──────────────────────┘
                        │  instruction set, microcode, MSRs
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  02  CPU                          ◀── here   ┃
┃      ISA · microarchitecture · caches · MMU  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  electrical signals, serial & parallel buses
┌───────────────────────┴──────────────────────┐
│  01  Circuit Board                           │
└──────────────────────────────────────────────┘
```

## At a glance

| Field | Value |
|-------|-------|
| Description | Executes machine instructions and computations |
| Languages | Machine code, Assembly (x86/x86-64, ARM/AArch64, RISC-V, PowerPC, MIPS) |
| Medium / Interface | Instruction Set Architecture (ISA), microcode, electrical signals |
| Example | Executes BIOS instructions at startup |
| Adjacent layers | ↑ [03_Firmware_BIOS](../03_Firmware_BIOS/), ↓ [01_Circuit_Board](../01_Circuit_Board/) |

## What lives here

- ISA families: x86/x86-64, ARM/AArch64, RISC-V, POWER, MIPS, SPARC, z/Architecture
- Microarchitecture: pipelines, OoO execution, superscalar, SIMD, branch prediction
- Caches (L1/L2/L3), TLBs, MMUs, virtualization extensions
- Privilege rings, protection modes, secure enclaves (SGX, TrustZone, SEV)
- Microcode, control registers, MSRs
- Performance counters (PMU)

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | ISA manuals, microarch papers, Agner Fog |
| [Lessons](#lessons) | [Interactive labs](cpu_labs.md) | from "hello assembly" to OoO microarch |
| [Languages](#languages) | [AArch64 (ARM64) Assembly](arm64_asm.md) · [RISC-V Assembly](riscv_asm.md) · [x86-64 Assembly](x86_64_asm.md) | assembly dialects + ISA-aware C/Rust |
| [Manual Pages](#manual-pages) | [CPU Inspection Commands](cpu_inspection.md) | `gdb`, `objdump`, `perf`, `nm`, `readelf` |
| [Topics](#topics) | [CPU Pipeline](cpu_pipeline.md) | pipelines, caches, MMU, vector extensions |
| [Protocols](#protocols) | — | calling conventions, ABIs, exception models |

## Cross-references

- Kernel uses privilege rings → [OS Kernel › Topics](../05_OS_Kernel/README.md#topics)
- CPU-side crypto (AES-NI, SHA-NI) → [Security › Topics](../14_Security/README.md#topics)
- Spectre/Meltdown/L1TF side channels → [Security › Topics](../14_Security/README.md#topics)
- ML inference on CPU vs GPU → [AI / ML › Topics](../15_AI_ML/README.md#topics)

---

## References

### What is in this section

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

### Books
- *Computer Architecture: A Quantitative Approach* — Hennessy & Patterson. The standard.
- *Computer Organization and Design (RISC-V Edition)* — Patterson & Hennessy. Undergrad foundation.
- *Inside the Machine* — Jon Stokes. Accessible microarch tour of Intel/AMD/PowerPC.
- *The RISC-V Reader* — Patterson & Waterman. Concise RISC-V intro.
- *Hacker's Delight* — Henry Warren. Bit-manipulation idioms.

### Official ISA manuals (the canonical references)
- **Intel® 64 and IA-32 Architectures Software Developer's Manual** — multi-volume PDF set.
- **AMD64 Architecture Programmer's Manual** — five volumes.
- **Arm Architecture Reference Manual (ARM ARM)** — A-profile, M-profile, R-profile.
- **RISC-V Instruction Set Manual** — Volume I (unprivileged), Volume II (privileged).
- **Power ISA** — OpenPOWER Foundation.

### Microarchitecture / optimization
- **Agner Fog's optimization manuals** — `https://www.agner.org/optimize/`. Microarch + instruction tables.
- **uops.info** — instruction latency/throughput database.
- **Intel Optimization Reference Manual**
- **Arm Cortex-A series Software Optimization Guides**

### Papers worth knowing
- Spectre (Kocher et al.), Meltdown (Lipp et al.) — speculative execution attacks
- "A Primer on Memory Consistency and Cache Coherence" — Nagarajan et al.

---

## Lessons

### What is in this section

```text
  Ten exercises. The file states no prerequisites between them, so the
  grouping is editorial — by what you are working on, not by order.

  ┌─────────────────────────────────────────────────────────────────────┐
  │  reading what is already there                                      │
  │                                                                     │
  │   1  Number systems & bit-twiddling   two's complement · masks      │
  │   2  Hello, assembly                  "exit 42", x86-64 and AArch64 │
  │   3  Calling conventions              SysV · MS x64 · AAPCS         │
  │   4  Disassembly literacy             objdump -d, prologue/epilogue │
  └──────────────────────────────────┬──────────────────────────────────┘
                                     │
  ┌──────────────────────────────────┴──────────────────────────────────┐
  │  measuring the microarchitecture — the part no manual tells you      │
  │                                                                     │
  │   5  Caches & locality                stride-access benchmarks      │
  │   6  Branch prediction                defeat it, then read counters │
  │   7  SIMD intro                       SSE/AVX or NEON — a dot       │
  │                                       product, vectorised           │
  │   8  Memory model                     atomics · fences · CAS lock   │
  └──────────────────────────────────┬──────────────────────────────────┘
                                     │
                 ┌───────────────────┴───────────────────┐
                 ▼                                       ▼
  ┌──────────────────────────────┐      ┌──────────────────────────────┐
  │  build one                   │      │  break one                   │
  │                              │      │                              │
  │   9  A tiny RISC-V core      │      │  10  Microarch attack and    │
  │      single-cycle ─▶         │      │      defence — Spectre v1    │
  │      pipelined     ──▶ 00d   │      │      PoC, then mitigations   │
  │                              │      │                     ──▶ 14   │
  └──────────────────────────────┘      └──────────────────────────────┘

  Lab: cpu_labs.md — three modules: an assembly hello world, register
  inspection under GDB, and a pipeline hazard demo.
```

### Dedicated lesson modules

| Topic | File |
|-------|------|
| CPU interactive labs | [CPU interactive labs](cpu_labs.md) — Assembly hello world, register inspection, pipeline hazards |

---

1. **Number systems & bit-twiddling** — binary, hex, two's complement, masks, shifts.
2. **Hello, assembly** — write & run "exit 42" in x86-64 and AArch64.
3. **Calling conventions** — System V AMD64, Microsoft x64, AAPCS — pass args, return values.
4. **Disassembly literacy** — read `objdump -d` for a small C program; identify prologue/epilogue.
5. **Caches & locality** — measure cache effects with stride-access microbenchmarks.
6. **Branch prediction & speculation** — write code that defeats the predictor; observe perf counters.
7. **SIMD intro** — SSE/AVX intrinsics or NEON; vectorize a dot product.
8. **Memory model** — atomics, fences, acquire/release; build a lock from CAS.
9. **Implement a tiny RISC-V core** — single-cycle → pipelined in Verilog/Chisel.
10. **Microarch attack & defense** — reproduce Spectre v1 PoC, then mitigations.

### Suggested external courses
- MIT 6.004 *Computation Structures* — RISC-V from gates to OS interface.
- Carnegie Mellon 15-213 *CSAPP* lectures — bridges arch to systems.
- Nand2Tetris Part 1 — build a CPU from logic.

---

## Languages

### What is in this section

```text
  Three ISAs have a profile of their own in this folder. Each box is one of
  them: the syntaxes it is written in, and where a call puts its arguments.

  ┌──────────────────────────┐ ┌────────────────────┐ ┌───────────────────┐
  │  x86-64                  │ │  AArch64           │ │  RISC-V           │
  │  x86_64_asm.md           │ │  arm64_asm.md      │ │  riscv_asm.md     │
  ├──────────────────────────┤ ├────────────────────┤ ├───────────────────┤
  │  Intel syntax            │ │  as · LLVM         │ │  GNU · LLVM       │
  │    NASM · MASM           │ │                    │ │  RV32 / RV64      │
  │  AT&T syntax             │ │                    │ │                   │
  │    gas · as              │ │                    │ │                   │
  ├──────────────────────────┤ ├────────────────────┤ ├───────────────────┤
  │  SysV AMD64              │ │  AAPCS64           │ │  psABI            │
  │    rdi rsi rdx rcx r8 r9 │ │    x0 … x7         │ │    a0 … a7        │
  │    ──▶ rax               │ │    ──▶ x0          │ │    ──▶ a0 / a1    │
  │  Microsoft x64           │ │                    │ │                   │
  │    rcx rdx r8 r9         │ │                    │ │                   │
  │    + 32B shadow space    │ │                    │ │                   │
  └──────────────────────────┘ └────────────────────┘ └───────────────────┘

  The comparison table below adds the ones with no profile here: 32-bit ARM
  (Thumb/Thumb-2, AAPCS r0…r3), PowerPC, MIPS — and two rows that nobody
  writes by hand. Machine code is what the assemblers above produce, and
  microcode arrives as a vendor-signed update.

  C and Rust are in that table because both can embed assembly rather than
  replace it — `__asm__` and `asm!`.
```

### Per-architecture assembly profiles

| ISA | Profile |
|-----|---------|
| x86-64 (Intel + AT&T syntax, SysV + MS ABIs) | [x86-64 Assembly](x86_64_asm.md) |
| AArch64 (ARM64, AAPCS64) | [AArch64 (ARM64) Assembly](arm64_asm.md) |
| RISC-V (RV32 / RV64, psABI) | [RISC-V Assembly](riscv_asm.md) |

---

### Quick comparison

| Language | Type | Use at this layer | Toolchain |
|----------|------|-------------------|-----------|
| Machine code | Native binary | What the CPU actually executes | n/a (output of assemblers/compilers) |
| x86 / x86-64 asm (Intel syntax) | Assembly | Hand-tuned routines, bootloaders, OS entry | NASM, MASM |
| x86 / x86-64 asm (AT&T syntax) | Assembly | GNU toolchain default | `gas`, `as` |
| AArch64 asm (ARMv8-A) | Assembly | ARM kernels, iOS/Android low-level | `as`, LLVM |
| ARM (32-bit Thumb/Thumb-2) | Assembly | Embedded, Cortex-M firmware | `arm-none-eabi-as` |
| RISC-V asm (RV32 / RV64) | Assembly | RISC-V cores, education, custom silicon | GNU, LLVM |
| PowerPC / POWER asm | Assembly | IBM Power, older Apple, PS3/Wii | GNU |
| MIPS asm | Assembly | Embedded routers, MARS/SPIM teaching | GNU, MARS |
| Microcode | Vendor-internal | Patches CPU behavior (Intel `microcode_ctl`) | Vendor-signed updates |
| C (with inline asm) | Systems | Bridges high-level to ISA via `__asm__` | GCC, Clang |
| Rust (with `asm!`) | Systems | Modern alternative to C for inline asm | rustc |

### Calling convention quick refs
- **System V AMD64** (Linux/macOS): args in `rdi, rsi, rdx, rcx, r8, r9`, return in `rax`.
- **Microsoft x64**: args in `rcx, rdx, r8, r9`, 32-byte shadow space, return in `rax`.
- **AAPCS64** (ARM): args in `x0..x7`, return in `x0`.
- **RISC-V**: args in `a0..a7`, return in `a0/a1`.

### Related
- Compiler frontends/backends → [System Libraries › Languages](../06_System_Libraries/README.md#languages)
- Assembly for boot code → [Firmware / BIOS › Languages](../03_Firmware_BIOS/README.md#languages)

---

## Manual Pages

### What is in this section

```text
  Every tool here points at one of three things. The file's own words for
  what they do are inspection, disassembly and profiling — which is this,
  read top to bottom.

                      ┌────────────────────────────┐
                      │  the machine               │◀── lscpu · cpuid
                      │  model · cache · flags     │    rdmsr · wrmsr
                      └─────────────┬──────────────┘
                                    │  executes
                      ┌─────────────▼──────────────┐
                      │  the binary on disk        │◀── objdump · readelf
                      │  sections · symbols · ELF  │    nm · strings · ar
                      └─────────────┬──────────────┘    addr2line · as · ld
                                    │  becomes
                      ┌─────────────▼──────────────┐
                      │  the running process       │◀── perf stat
                      │  cycles · misses · stalls  │    perf record/report
                      └─────────────┬──────────────┘    cachegrind (simulated
                                    │                   rather than measured)
                    ┌───────────────┴───────────────┐
                    ▼                               ▼
              gdb · lldb                   strace · dtrace
              stop it and look             watch it cross into the
              at the registers             kernel            ──▶ 05

  taskset and numactl are the exception: they do not observe anything, they
  decide which core and which memory the process gets.

  Reverse engineering — radare2 · rizin · Binary Ninja · IDA · Ghidra — sits
  at the end of the file as its own workflow. Detail on the inspection
  tools: cpu_inspection.md.
```

### Dedicated man page references

| Topic | File |
|-------|------|
| CPU inspection & profiling | [CPU Inspection Commands](cpu_inspection.md) — lscpu, cpuid, turbostat, likwid, perf stat |

---

Inspection, disassembly, profiling.

| Command | Section | Purpose |
|---------|---------|---------|
| `lscpu` | 1 | CPU model, cores, cache, flags, vulnerability status |
| `cpuid` | 1 | Decode raw CPUID leaves (x86) |
| `nm` | 1 | List symbols in object files |
| `objdump` | 1 | Disassemble, dump sections, view headers |
| `readelf` | 1 | Dump ELF metadata (headers, symbols, relocations) |
| `addr2line` | 1 | Map runtime addresses back to source lines |
| `as` / `gas` | 1 | GNU assembler |
| `ld` | 1 | GNU linker |
| `ar` | 1 | Static archive tool |
| `strings` | 1 | Print printable strings in binary |
| `gdb` | 1 | GNU debugger — single-step, registers, breakpoints |
| `lldb` | 1 | LLVM debugger (default on macOS) |
| `perf` | 1 | Linux perf_events: counters, flame graphs, profiling |
| `perf stat` | 1 | Quick microarch counter snapshot |
| `perf record` / `perf report` | 1 | Sample-based profiling |
| `strace` | 1 | Trace syscalls (links arch ↔ kernel) |
| `dtrace` / `dtruss` | 1 | macOS/FreeBSD dynamic tracing |
| `valgrind --tool=cachegrind` | 1 | Simulate cache behavior |
| `valgrind --tool=callgrind` | 1 | Call-graph + cycle estimate |
| `taskset` | 1 | Pin a process to specific cores |
| `numactl` | 8 | NUMA control: bind memory/CPU |

### Specialized
- `rdmsr` / `wrmsr` (msr-tools) — read/write Model Specific Registers
- `intel_pmu_tools` — Intel performance monitoring helpers
- `radare2` / `r2`, `rizin`, `binary ninja`, `IDA`, `Ghidra` — RE workflows

---

## Topics

### What is in this section

```text
  Five groups, and they answer five different questions about the same chip.

  ┌─────────────────────────────────────────────────────────────────────┐
  │  ISAs & extensions        what it promises to execute               │
  │    x86-64   MMX · SSE/AVX/AVX-512 · AES-NI · SHA-NI · BMI · AMX     │
  │    AArch64  NEON · SVE/SVE2 · crypto · PAC · MTE                    │
  │    RISC-V   RV32I/RV64I + M A F D C V B H                           │
  │    also     POWER · MIPS · SPARC · z/Arch · Itanium                 │
  └─────────────────────────────────┬───────────────────────────────────┘
                                    │  one implementation of that promise
  ┌─────────────────────────────────▼───────────────────────────────────┐
  │  microarchitecture        how it keeps the promise fast             │
  │    pipelining · out-of-order · superscalar · SMT                    │
  │    branch prediction — bimodal · tournament · perceptron · TAGE     │
  │    speculation and rollback · SIMD execution units                  │
  └─────────────────────────────────┬───────────────────────────────────┘
                                    │  which needs operands
  ┌─────────────────────────────────▼───────────────────────────────────┐
  │  memory hierarchy         where the operands come from              │
  │    L1i/L1d · L2 · L3 — MESI, MOESI, MESIF                           │
  │    TLBs and MMU · ASIDs/PCIDs · huge pages                          │
  │    ordering — TSO, weak, barriers · NUMA — UPI · Fabric · CXL       │
  └─────────────────────────────────┬───────────────────────────────────┘
                                    │  none of which may leak
  ┌─────────────────────────────────▼───────────────────────────────────┐
  │  privilege & isolation    who is allowed to see it                  │
  │    rings and EL levels · VT-x/AMD-V · EPT/NPT · IOMMU               │
  │    TEEs — SGX · SEV · TrustZone · Keystone                          │
  │    pointer auth and CFI — PAC · CET · Zicfilp/Zicfiss               │
  └─────────────────────────────────────────────────────────────────────┘

  ┌─────────────────────────────────────────────────────────────────────┐
  │  observability            how you watch any of the four happen      │
  │    PMU counters · LBR · Intel PT — what perf reads (Manual Pages)   │
  └─────────────────────────────────────────────────────────────────────┘

  Speculation appears in two of these groups and is where they collide:
  Spectre, Meltdown, MDS and L1TF are in 14 Security, Rowhammer in 01.

  Detail on the pipeline itself: cpu_pipeline.md.
```

### Dedicated topic files

| Topic | File |
|-------|------|
| CPU Pipeline | [CPU Pipeline](cpu_pipeline.md) — 5-stage RISC, superscalar OoO, hazards, cache hierarchy, branch prediction, Spectre |

---

### ISAs & extensions
- **x86-64** — base + MMX, SSE/AVX/AVX-512, AES-NI, SHA-NI, BMI, ADX, AMX.
- **AArch64** — base + NEON, SVE/SVE2, crypto, pointer authentication, MTE.
- **RISC-V** — RV32I/RV64I + standard extensions: M, A, F, D, C, V, B, H.
- **Other** — POWER, MIPS, SPARC, z/Architecture, Itanium (historical).

### Microarchitecture
- **Pipelining** — fetch, decode, rename, dispatch, execute, writeback, retire.
- **Out-of-order execution** — reservation stations, reorder buffer.
- **Superscalar & multi-issue** — multiple ops per cycle per core.
- **Branch prediction** — bimodal, tournament, perceptron, TAGE.
- **Speculation & rollback** — checkpoint, squash, recovery.
- **SIMD / vector** — packed-data execution units.
- **SMT / hyperthreading** — sharing execution resources between hardware threads.

### Memory hierarchy
- **Caches** — L1i/L1d, L2, L3/LLC; inclusive vs exclusive; coherence (MESI, MOESI, MESIF).
- **TLBs & MMU** — page tables, address translation, ASIDs/PCIDs, huge pages.
- **Memory ordering** — TSO (x86), weak (ARM/POWER), barriers/fences.
- **NUMA** — node locality, interconnect (UPI, Infinity Fabric, CXL).

### Privilege & isolation
- **Rings / EL levels** — x86 ring 0/3, ARM EL0–EL3.
- **Virtualization** — VT-x/AMD-V, EPT/NPT, IOMMU (VT-d/AMD-Vi).
- **TEEs** — Intel SGX, AMD SEV, ARM TrustZone, RISC-V Keystone.
- **Pointer auth & CFI** — ARM PAC, Intel CET, RISC-V Zicfilp/Zicfiss.

### Observability
- **PMU / performance counters** — cycles, instructions, cache misses, branch mispredicts.
- **Last Branch Record (LBR)**, **Intel PT** — branch & path tracing.

### Security cross-link
- Speculative side channels (Spectre, Meltdown, MDS, L1TF) → [Security › Topics](../14_Security/README.md#topics)
- Rowhammer (DRAM) → [Circuit Board › Topics](../01_Circuit_Board/README.md#topics)

---

## Protocols

Not wire protocols — these are the *software contracts* the CPU layer enforces.

### What is in this section

```text
  Nothing here is a wire protocol. These are the four contracts that let a
  binary built by one toolchain run under another's kernel, on silicon
  neither of them chose.

  ┌──────────────────────────────────────────────────────────────────────┐
  │  your code, compiled                                                 │
  └─────────────────────────────────┬────────────────────────────────────┘
                                    │
      ┌─────────────────────────────┴──────────────────────────────┐
      │  what a binary file looks like                             │
      │  ELF · Mach-O · PE/COFF · RISC-V psABI tag sections        │
      │  — the one contract set by the OS, not by the ISA          │
      └─────────────────────────────┬──────────────────────────────┘
                                    │
      ┌─────────────────────────────┴──────────────────────────────┐
      │  where a call puts its arguments                           │
      │  x86-64  SysV AMD64 · MS x64 · i386 SVR4 · fastcall,       │
      │          stdcall, cdecl                                    │
      │  ARM     AAPCS64  x0…x7    ·  AAPCS (32)  r0…r3            │
      │  RISC-V  psABI    a0…a7                        ──▶ 06      │
      └─────────────────────────────┬──────────────────────────────┘
                                    │
      ┌─────────────────────────────┴──────────────────────────────┐
      │  what happens on a trap                                    │
      │  x86-64  IDT, vectors 0–31 reserved · IST · MCE · NMI      │
      │  ARM     EL0–EL3 · VBAR · synchronous vs asynchronous      │
      │  RISC-V  mtvec / stvec · mcause / scause · delegation      │
      │                                                ──▶ 05      │
      └─────────────────────────────┬──────────────────────────────┘
                                    │
      ┌─────────────────────────────┴──────────────────────────────┐
      │  what ordering you may assume                              │
      │  x86-64  TSO — store buffers only                          │
      │  ARM     weak — dmb, dsb, isb                              │
      │  RISC-V  WMO, or TSO with the Ztso extension               │
      └────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
                              the hardware
```

### Application Binary Interfaces (ABIs)
| ABI | Platforms | Notes |
|-----|-----------|-------|
| System V AMD64 ABI | Linux, macOS, BSD on x86-64 | `rdi,rsi,rdx,rcx,r8,r9` arg regs |
| Microsoft x64 ABI | Windows on x86-64 | `rcx,rdx,r8,r9`, 32-byte shadow space |
| AAPCS64 | Linux/macOS/Windows on ARM64 | `x0..x7` arg regs |
| AAPCS (32-bit) | 32-bit ARM | `r0..r3` arg regs |
| RISC-V ELF psABI | Linux/RTOS on RISC-V | `a0..a7` arg regs |
| i386 SVR4 ABI | Linux on 32-bit x86 | Stack-based args |
| Windows fastcall / stdcall / cdecl | Win32 | Mixed legacy x86 conventions |

### Exception / interrupt models
- **x86-64** — IDT, vectors 0–31 reserved, IRQs 32+, IST stacks, MCE, NMI, SMI.
- **ARMv8-A** — exception levels (EL0–EL3), synchronous vs asynchronous, VBAR.
- **RISC-V** — `mtvec`/`stvec` trap base, `mcause`/`scause`, delegation.

### Memory consistency models
- **x86 TSO** — Total Store Order, store buffers only.
- **ARMv8 / POWER weak** — explicit `dmb` / `dsb` / `isb` barriers.
- **RISC-V WMO + Ztso** — weak by default; optional TSO extension.

### Binary formats (where ABI meets file format)
- **ELF** — Linux, BSD, most Unix
- **Mach-O** — macOS, iOS
- **PE/COFF** — Windows
- **RISC-V psABI tag sections** — feature compatibility

### Cross-link
- These ABIs are what syscall wrappers in [06_System_Libraries](../06_System_Libraries/) target.
- Kernel-side exception entry → [OS Kernel › Topics](../05_OS_Kernel/README.md#topics)
