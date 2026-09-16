# System Libraries — Lessons

## What is in this section

```text
  Dedicated module plus eleven numbered lessons across four topic groups.

  ┌─── dedicated module ──────────────────────────────────────────────────────┐
  │  library_labs.md — shared library, dlopen, symbol visibility, ABI        │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── linking fundamentals  (1–5) ───────────────────────────────────────────┐
  │  1 Hello libc + strace  │  2 static vs dynamic  │  3 LD_PRELOAD hook     │
  │  4 musl static build  │  5 linker scripts                                │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── ABI & symbols  (6–7) ──────────────────────────────────────────────────┐
  │  6 symbol visibility (-fvisibility, version scripts)                      │
  │  7 C++ name mangling (nm, c++filt, vtable layout)                        │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── threading, i18n & crypto  (8–10) ──────────────────────────────────────┐
  │  8 pthreads — mutex/cond, std::atomic, false sharing                      │
  │  9 locale & i18n — setlocale, iconv, UTF-8 pitfalls                      │
  │  10 crypto API — OpenSSL EVP, AES-GCM, ChaCha20-Poly1305                 │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── FFI & external resources  (11+) ───────────────────────────────────────┐
  │  11 call C from Python (ctypes/cffi), Rust, Go                           │
  │  CppCon ABI talks  │  Drepper "What Every Programmer Should Know"        │
  └───────────────────────────────────────────────────────────────────────────┘
```

## Dedicated lesson modules

| Topic | File |
|-------|------|
| Library interactive labs | [library_labs.md](library_labs.md) — Shared library, symbol visibility, dlopen, ABI versioning |

---

1. **Hello, libc** — write & link a "hello" C program; trace with `strace` to see syscalls.
2. **Static vs dynamic linking** — same binary, two link models; size & startup differences.
3. **`LD_PRELOAD` hook** — intercept `malloc` to log allocations.
4. **Build with musl** — cross-compile a static binary; compare with glibc.
5. **Linker scripts** — read the default GNU ld script; write a minimal one.
6. **Symbol visibility** — `-fvisibility=hidden`, version scripts, ABI hygiene.
7. **C++ name mangling** — `nm`, `c++filt`, mismatched compilers, vtable layout.
8. **Threading primitives** — pthreads mutex/cond, std::atomic; ABA, false sharing.
9. **Locale & i18n** — `setlocale`, `iconv`, UTF-8 handling pitfalls.
10. **Crypto API hands-on** — OpenSSL EVP; pick AEAD (AES-GCM, ChaCha20-Poly1305).
11. **FFI from a higher language** — call a C lib from Python (`ctypes`/`cffi`), Rust, Go.

## Suggested external
- CppCon talks on ABI compatibility (Marshall Clow, Titus Winters)
- "What Every Programmer Should Know About Memory" — Drepper
