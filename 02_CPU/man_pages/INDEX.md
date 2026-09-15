# CPU — Manual Pages

## What is in this section

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

## Dedicated man page references

| Topic | File |
|-------|------|
| CPU inspection & profiling | [cpu_inspection.md](cpu_inspection.md) — lscpu, cpuid, turbostat, likwid, perf stat |

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

## Specialized
- `rdmsr` / `wrmsr` (msr-tools) — read/write Model Specific Registers
- `intel_pmu_tools` — Intel performance monitoring helpers
- `radare2` / `r2`, `rizin`, `binary ninja`, `IDA`, `Ghidra` — RE workflows
