# CPU — Manual Pages

## What is in this section

```text
  The file's own three words for these are inspection, disassembly and
  profiling. Sorted that way, plus the two groups that are neither:

  what is this CPU        lscpu · cpuid          model, cache, flags,
                                                 vulnerability status
                          rdmsr · wrmsr          model-specific registers

  what is in this binary  objdump · readelf      disassembly, ELF metadata
                          nm · strings · ar      symbols, text, archives
                          addr2line              address ─▶ source line
                          as · ld                the tools that made it

  what is it doing        perf stat              counter snapshot
                          perf record / report   sampled profile
                          cachegrind · callgrind simulated, not measured
                          strace · dtrace        the syscall boundary → 05

  where is it doing it    taskset                pin to cores
                          numactl                bind memory and CPU

  stepping through it     gdb · lldb             breakpoints and registers

  Reverse engineering (radare2 · rizin · Binary Ninja · IDA · Ghidra) is
  listed at the end of the file as its own workflow rather than as one of
  these. Detail on the inspection tools: cpu_inspection.md.
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
