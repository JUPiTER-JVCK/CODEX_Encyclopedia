# CPU — Languages

## What is in this section

```text
  Three ISAs have a profile of their own here; the rest appear only in the
  comparison table. What the table distinguishes is syntax, toolchain, and
  where the arguments go.

  profiled here            x86_64_asm.md   Intel + AT&T, SysV + MS ABIs
                           arm64_asm.md    AArch64, AAPCS64
                           riscv_asm.md    RV32 / RV64, psABI

  ISA                      assembler            argument registers
  ─────────────────        ─────────────        ───────────────────────────
  x86-64  Intel syntax     NASM · MASM          SysV:  rdi rsi rdx rcx r8 r9
          AT&T syntax      gas · as             MS:    rcx rdx r8 r9 + 32B
                                                       shadow space
  AArch64                  as · LLVM            AAPCS64: x0…x7  ─▶ x0
  ARM 32  Thumb/Thumb-2    arm-none-eabi-as     AAPCS:   r0…r3
  RISC-V  RV32 / RV64      GNU · LLVM           psABI:   a0…a7  ─▶ a0/a1
  PowerPC · MIPS           GNU · MARS           listed for legacy and
                                                teaching use

  Two entries in that table are not assembled by hand at all: machine code,
  which is what the others produce, and microcode, which arrives as a
  vendor-signed update.

  C and Rust appear because both can embed assembly — `__asm__` and `asm!`.
```

## Per-architecture assembly profiles

| ISA | Profile |
|-----|---------|
| x86-64 (Intel + AT&T syntax, SysV + MS ABIs) | [x86_64_asm.md](x86_64_asm.md) |
| AArch64 (ARM64, AAPCS64) | [arm64_asm.md](arm64_asm.md) |
| RISC-V (RV32 / RV64, psABI) | [riscv_asm.md](riscv_asm.md) |

---

## Quick comparison

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

## Calling convention quick refs
- **System V AMD64** (Linux/macOS): args in `rdi, rsi, rdx, rcx, r8, r9`, return in `rax`.
- **Microsoft x64**: args in `rcx, rdx, r8, r9`, 32-byte shadow space, return in `rax`.
- **AAPCS64** (ARM): args in `x0..x7`, return in `x0`.
- **RISC-V**: args in `a0..a7`, return in `a0/a1`.

## Related
- Compiler frontends/backends → [06_System_Libraries/languages](../../06_System_Libraries/languages/INDEX.md)
- Assembly for boot code → [03_Firmware_BIOS/languages](../../03_Firmware_BIOS/languages/INDEX.md)
