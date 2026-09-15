# CPU — Protocols

Not wire protocols — these are the *software contracts* the CPU layer enforces.

## What is in this section

```text
  Four kinds of contract, and the file organises them by what each one
  fixes. Three of them vary by ISA, so they are shown against the same
  three columns.

                    x86-64            ARM               RISC-V
                    ──────            ───               ──────
  where args go     SysV AMD64        AAPCS64  x0…x7    psABI  a0…a7
                    MS x64                              
                    i386 SVR4         AAPCS (32) r0…r3
                    Win fastcall,
                    stdcall, cdecl

  how traps work    IDT, vectors      EL0–EL3, VBAR     mtvec / stvec
                    0–31 reserved     sync vs async     mcause / scause
                    IST · MCE · NMI                     delegation

  what ordering     TSO — store       weak — dmb,       WMO, or TSO with
  you may assume    buffers only      dsb, isb          the Ztso extension

  And one that varies by operating system rather than by ISA:

  what a binary     ELF (Linux, BSD) · Mach-O (macOS, iOS) · PE/COFF
  file looks like   (Windows) · RISC-V psABI tag sections

  None of these is a wire protocol. They are the contracts that let code
  built by one toolchain run under another's kernel — which is why 06
  System Libraries targets them and 05 OS Kernel implements the trap side.
```

## Application Binary Interfaces (ABIs)
| ABI | Platforms | Notes |
|-----|-----------|-------|
| System V AMD64 ABI | Linux, macOS, BSD on x86-64 | `rdi,rsi,rdx,rcx,r8,r9` arg regs |
| Microsoft x64 ABI | Windows on x86-64 | `rcx,rdx,r8,r9`, 32-byte shadow space |
| AAPCS64 | Linux/macOS/Windows on ARM64 | `x0..x7` arg regs |
| AAPCS (32-bit) | 32-bit ARM | `r0..r3` arg regs |
| RISC-V ELF psABI | Linux/RTOS on RISC-V | `a0..a7` arg regs |
| i386 SVR4 ABI | Linux on 32-bit x86 | Stack-based args |
| Windows fastcall / stdcall / cdecl | Win32 | Mixed legacy x86 conventions |

## Exception / interrupt models
- **x86-64** — IDT, vectors 0–31 reserved, IRQs 32+, IST stacks, MCE, NMI, SMI.
- **ARMv8-A** — exception levels (EL0–EL3), synchronous vs asynchronous, VBAR.
- **RISC-V** — `mtvec`/`stvec` trap base, `mcause`/`scause`, delegation.

## Memory consistency models
- **x86 TSO** — Total Store Order, store buffers only.
- **ARMv8 / POWER weak** — explicit `dmb` / `dsb` / `isb` barriers.
- **RISC-V WMO + Ztso** — weak by default; optional TSO extension.

## Binary formats (where ABI meets file format)
- **ELF** — Linux, BSD, most Unix
- **Mach-O** — macOS, iOS
- **PE/COFF** — Windows
- **RISC-V psABI tag sections** — feature compatibility

## Cross-link
- These ABIs are what syscall wrappers in [06_System_Libraries](../../06_System_Libraries/) target.
- Kernel-side exception entry → [05_OS_Kernel/topics](../../05_OS_Kernel/topics/INDEX.md)
