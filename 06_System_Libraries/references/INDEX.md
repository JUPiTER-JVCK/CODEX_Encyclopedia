# System Libraries — References

## What is in this section

```text
  Four reference groups: libc implementations, specifications, books,
  and online resources.

  ┌─── libc implementations ──────────────────────────────────────────────────┐
  │  glibc (Linux default)  │  musl (Alpine, embedded)                        │
  │  Bionic (Android)  │  Microsoft UCRT (Windows)  │  Apple libSystem       │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── specifications ────────────────────────────────────────────────────────┐
  │  ISO C (C11/C17/C23)  │  ISO C++ (C++17/20/23)  │  POSIX.1-2017         │
  │  System V ABI  │  DWARF debug format                                     │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── books ─────────────────────────────────────────────────────────────────┐
  │  K&R · Modern C · Stroustrup · Effective Modern C++                      │
  │  Linkers and Loaders (Levine)  │  CSAPP (Bryant & O'Hallaron)            │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── online ────────────────────────────────────────────────────────────────┐
  │  cppreference.com — C/C++ stdlib reference                                │
  │  man7.org  │  Drepper "How To Write Shared Libraries"                    │
  └───────────────────────────────────────────────────────────────────────────┘
```

## libc
- **glibc manual** — `https://www.gnu.org/software/libc/manual/`
- **musl libc** — `https://musl.libc.org/` (tiny, MIT-licensed, used by Alpine)
- **bionic libc** (Android) — `https://android.googlesource.com/platform/bionic/`
- **Microsoft UCRT** documentation (MSDN)
- **Apple libSystem / Libc** — open-source-distributions on GitHub

## Standard / specs
- **ISO/IEC 9899** — C standard (C11 / C17 / C23)
- **ISO/IEC 14882** — C++ standard
- **POSIX.1-2017** — IEEE 1003.1 (`man 7 posix`)
- **System V ABI** — ELF + per-arch supplements
- **DWARF** — debug info format

## Books
- *The C Programming Language* — K&R
- *Modern C* — Jens Gustedt
- *The C++ Programming Language* — Stroustrup
- *Effective Modern C++* — Scott Meyers
- *Linkers and Loaders* — John Levine
- *Computer Systems: A Programmer's Perspective* (CSAPP) — Bryant & O'Hallaron

## Online
- cppreference.com — best C/C++ stdlib reference
- man7.org — Michael Kerrisk's Linux manpages
- Drepper, "How To Write Shared Libraries"
