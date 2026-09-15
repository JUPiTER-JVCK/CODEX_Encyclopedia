# System Libraries — Protocols

## What is in this section

```text
  Three groups: language/ABI standards, library binary formats, and
  package/build metadata.

  ┌─── language & ABI standards ──────────────────────────────────────────────┐
  │  ISO C (C11/17/23)  │  ISO C++ (C++17/20/23)  │  POSIX.1-2017            │
  │  System V ABI  │  Itanium C++ ABI  │  MSVC C++ ABI  │  DWARF v5         │
  │  LSB (historical)  │  FHS                                                 │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── library formats ───────────────────────────────────────────────────────┐
  │  ELF (.so) — Linux/BSD  │  Mach-O (.dylib) — macOS                       │
  │  PE/COFF (.dll) — Windows  │  static archives (.a / .lib)                │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── package / build metadata ──────────────────────────────────────────────┐
  │  pkg-config (.pc)  │  CMake config-file packages  │  .la (legacy)        │
  └───────────────────────────────────────────────────────────────────────────┘
```

Language, API and ABI standards rather than wire protocols — the contracts a
library has to keep.

| Standard | What it pins |
|----------|--------------|
| ISO C (C11/C17/C23) | C language + standard library API |
| ISO C++ (C++17/20/23) | C++ language + STL |
| POSIX.1-2017 | Portable Unix API surface (pthreads, signals, files) |
| System V ABI | ELF format + per-arch calling conventions |
| Itanium C++ ABI | C++ name mangling, vtables, RTTI (used by GCC/Clang) |
| MSVC C++ ABI | Microsoft's separate C++ ABI |
| DWARF v5 | Debug info format |
| LSB | Distro-portable Linux binary contract (historical) |
| Filesystem Hierarchy Standard (FHS) | `/usr/lib`, `/lib64`, ... layout |

## Library formats
- **ELF** — Linux/BSD shared objects (`.so`)
- **Mach-O** — macOS dylibs (`.dylib`), bundles, frameworks
- **PE/COFF** — Windows DLLs (`.dll`)
- **Static archives** — `.a` (Unix), `.lib` (Windows)

## Package/build metadata
- **pkg-config (`.pc`)** — compile/link flag manifests
- **CMake config-file packages** — `Foo-config.cmake`
- **Autotools (`.la`)** — libtool archives (legacy)

## Cross-link
- ABIs live in [02_CPU/protocols](../../02_CPU/protocols/INDEX.md)
- Syscall surface in [05_OS_Kernel/protocols](../../05_OS_Kernel/protocols/INDEX.md)
