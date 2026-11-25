# 06 — System Libraries

> The packaged services userland code links against: libc, libm, libstdc++,
> threading, crypto, networking. The "high-level wrappers around syscalls"
> that most C/C++ programs touch every line.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  07  Runtime Environment                     │
└───────────────────────┬──────────────────────┘
                        │  function calls wrapping syscalls
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  06  System Libraries             ◀── here   ┃
┃      libc · dynamic linking · ABI            ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  system calls
┌───────────────────────┴──────────────────────┐
│  05  OS Kernel                               │
└──────────────────────────────────────────────┘
```

## At a glance

| Field | Value |
|-------|-------|
| Description | Reusable code offering high-level APIs |
| Languages | C, C++ (with bindings for everything) |
| Medium / Interface | Function calls; many wrap [05_OS_Kernel](../05_OS_Kernel/) syscalls |
| Example | `printf()` ultimately calls the `write()` syscall |
| Adjacent layers | ↓ [05_OS_Kernel](../05_OS_Kernel/), ↑ [07_Runtime_Environment](../07_Runtime_Environment/) |

## What lives here

- **libc** — glibc, musl, bionic, dietlibc, ucLibc, Microsoft UCRT, Apple `libSystem`
- **libm** — math functions
- **libstdc++ / libc++ / MSVC STL** — C++ standard libraries
- **Threading** — pthreads, Win32 threads, C++11 `<thread>`
- **Crypto** — OpenSSL/LibreSSL, BoringSSL, mbedTLS, libsodium, Schannel, CommonCrypto
- **Network** — getaddrinfo stack, c-ares, libcurl, libevent, libuv
- **Compression** — zlib, zstd, lz4, brotli, xz/lzma
- **JSON/XML/YAML** — libxml2, jansson, yaml-cpp
- **Linker & loader** — `ld.so` / `dyld` / `ntdll`/loader; ELF/Mach-O/PE

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | glibc/musl manuals, MSDN, Apple docs |
| [Lessons](#lessons) | [Interactive labs](library_labs.md) | write your own tiny libc, hook with LD_PRELOAD |
| [Languages](#languages) | — | C/C++ + binding generators |
| [Manual Pages](#manual-pages) | [Debugging Commands](debug_commands.md) · [Linker & Binary Inspection Commands](linker_commands.md) | `ldd`, `nm`, `ldconfig`, `dyld`, `pkg-config` |
| [Topics](#topics) | [Libc Variants](libc_variants.md) | ABI, ld.so, name mangling, locales |
| [Protocols](#protocols) | — | libc API standards, linker scripts |

## Cross-references
- Syscalls the wrappers call → [OS Kernel › Protocols](../05_OS_Kernel/README.md#protocols)
- Runtimes layered above libc → [07_Runtime_Environment](../07_Runtime_Environment/)
- LD_PRELOAD attacks / library hijacking → [Security › Topics](../14_Security/README.md#topics)

---

## References

### What is in this section

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

### libc
- **glibc manual** — `https://www.gnu.org/software/libc/manual/`
- **musl libc** — `https://musl.libc.org/` (tiny, MIT-licensed, used by Alpine)
- **bionic libc** (Android) — `https://android.googlesource.com/platform/bionic/`
- **Microsoft UCRT** documentation (MSDN)
- **Apple libSystem / Libc** — open-source-distributions on GitHub

### Standard / specs
- **ISO/IEC 9899** — C standard (C11 / C17 / C23)
- **ISO/IEC 14882** — C++ standard
- **POSIX.1-2017** — IEEE 1003.1 (`man 7 posix`)
- **System V ABI** — ELF + per-arch supplements
- **DWARF** — debug info format

### Books
- *The C Programming Language* — K&R
- *Modern C* — Jens Gustedt
- *The C++ Programming Language* — Stroustrup
- *Effective Modern C++* — Scott Meyers
- *Linkers and Loaders* — John Levine
- *Computer Systems: A Programmer's Perspective* (CSAPP) — Bryant & O'Hallaron

### Online
- cppreference.com — best C/C++ stdlib reference
- man7.org — Michael Kerrisk's Linux manpages
- Drepper, "How To Write Shared Libraries"

---

## Lessons

### What is in this section

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

### Dedicated lesson modules

| Topic | File |
|-------|------|
| Library interactive labs | [System Libraries interactive labs](library_labs.md) — Shared library, symbol visibility, dlopen, ABI versioning |

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

### Suggested external
- CppCon talks on ABI compatibility (Marshall Clow, Titus Winters)
- "What Every Programmer Should Know About Memory" — Drepper

---

## Languages

### What is in this section

```text
  Three groups: implementation languages, compilers, and FFI binding generators.

  ┌─── implementation languages ──────────────────────────────────────────────┐
  │  C (glibc · musl · OpenSSL · zlib · sqlite)                              │
  │  C++ (libstdc++ · libc++ · Boost · ICU · gRPC)                           │
  │  Rust (rustls · ring · sled)  │  Assembly (AES-NI fast paths)             │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── compilers / toolchains ────────────────────────────────────────────────┐
  │  GCC · Clang/LLVM · MSVC · ICC/ICX · TinyCC · Cosmopolitan libc          │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── FFI / binding generators ──────────────────────────────────────────────┐
  │  SWIG (many targets)  │  bindgen (Rust←C)  │  cgo (Go)                   │
  │  ctypes / cffi (Python)  │  node-gyp / NAPI (Node.js)                    │
  │  JNI / JNA (Java)  │  P/Invoke (.NET)                                    │
  └───────────────────────────────────────────────────────────────────────────┘
```

The libraries themselves are mostly C / C++. The interesting layer is the
*binding* tooling that exposes them to everything else.

### Implementation languages
| Language | Examples |
|----------|----------|
| C | glibc, musl, OpenSSL, zlib, sqlite |
| C++ | libstdc++, libc++, Boost, ICU, gRPC |
| Rust | rustls, ring, sled (newer, gaining ground) |
| Assembly | crypto fast paths (AES-NI), memcpy/memset |

### Compilers / toolchains
| Tool | Notes |
|------|-------|
| GCC | GNU C/C++ compiler; default on most Linux |
| Clang / LLVM | macOS default; alt on Linux/Windows |
| MSVC | Microsoft Visual C++; Windows native |
| ICC / ICX | Intel C/C++ compilers |
| TinyCC | Fast, small C compiler |
| Cosmopolitan libc | Single binary, multi-OS |

### FFI / binding generators
| Tool | Target | Notes |
|------|--------|-------|
| SWIG | Many | Wraps C/C++ for Python, Ruby, Java, ... |
| `bindgen` | Rust | Generates Rust FFI from C headers |
| `cgo` | Go | Built-in C interop |
| `ctypes`, `cffi` | Python | Two flavors of C-call FFI |
| `node-gyp`, NAPI | Node.js | Native addons |
| JNI / JNA | Java | C interop |
| P/Invoke | .NET | C interop |

### Related
- The C standard library is what compilers emit calls to → [CPU › Protocols](../02_CPU/README.md#protocols) ABIs
- Runtimes link libc → [Runtime Environment › Languages](../07_Runtime_Environment/README.md#languages)

---

## Manual Pages

### What is in this section

```text
  Two dedicated subfiles plus four command groups for linking and debugging.

  ┌─── dedicated files ───────────────────────────────────────────────────────┐
  │  linker_commands.md — ld, ldd, ldconfig, nm, objdump, readelf, strings   │
  │  debug_commands.md  — gdb, lldb, valgrind, addr2line                     │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── linker / loader ───────────────────────────────────────────────────────┐
  │  ld · lld · mold · gold  │  link.exe (MSVC)                              │
  │  ld.so / ld-linux.so (Linux)  │  dyld (macOS)                            │
  │  ldd · otool -L · dumpbin /dependents  │  ldconfig · pkg-config          │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── inspection ────────────────────────────────────────────────────────────┐
  │  nm  │  objdump -T/-t  │  readelf -d/-s/-h  │  otool -hv/-tv            │
  │  dumpbin /headers//exports  │  c++filt  │  strings                       │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── trace / debug ─────────────────────────────────────────────────────────┐
  │  ltrace  │  strace -e %file  │  valgrind  │  gdb / lldb                  │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── loader knobs (env vars) ───────────────────────────────────────────────┐
  │  LD_LIBRARY_PATH · LD_PRELOAD · LD_DEBUG · LD_BIND_NOW  (Linux)          │
  │  DYLD_LIBRARY_PATH · DYLD_INSERT_LIBRARIES  (macOS, SIP-limited)         │
  │  _NT_SYMBOL_PATH  (Windows)                                               │
  └───────────────────────────────────────────────────────────────────────────┘
```

### Dedicated man page references

| Topic | File |
|-------|------|
| Linker & binary inspection | [Linker & Binary Inspection Commands](linker_commands.md) — ld, ldd, ldconfig, nm, objdump, readelf, strings |
| Debugging | [Debugging Commands](debug_commands.md) — gdb, lldb, valgrind, addr2line |

---

### Linker / loader
| Command | Purpose |
|---------|---------|
| `ld` | GNU linker |
| `lld` | LLVM linker |
| `mold` | Modern fast linker |
| `gold` | GNU gold linker (legacy) |
| `link.exe` | MSVC linker |
| `ld.so` / `ld-linux.so` | Dynamic linker (Linux) |
| `dyld` | Dynamic linker (macOS) |
| `ldd` | Print dynamic dependencies (Linux) |
| `otool -L` | macOS equivalent of `ldd` |
| `dumpbin /dependents` | Windows equivalent |
| `ldconfig` | Update Linux dynamic linker cache |
| `pkg-config` | Library compile/link flags lookup |

### Inspection
| Command | Purpose |
|---------|---------|
| `nm` | List symbols |
| `objdump -T` / `-t` | Dynamic / all symbols |
| `readelf -d` / `-s` / `-h` | ELF dynamic / symbol / header info |
| `otool -hv` / `-tv` | Mach-O header/disasm |
| `dumpbin /headers` / `/exports` | PE inspection |
| `c++filt` | Demangle C++ symbols |
| `strings` | Printable strings in a binary |

### Trace / debug
| Command | Purpose |
|---------|---------|
| `ltrace` | Library call tracing |
| `strace -e %file` | Syscall trace filtered |
| `valgrind` | Memory checker, leak detector |
| `gdb` / `lldb` | Source-level debug |

### Loader knobs (env vars / man 8)
- `LD_LIBRARY_PATH`, `LD_PRELOAD`, `LD_DEBUG`, `LD_BIND_NOW` (Linux)
- `DYLD_LIBRARY_PATH`, `DYLD_INSERT_LIBRARIES` (macOS; restricted under SIP)
- `_NT_SYMBOL_PATH`, `PATH` (Windows)

See also `man 8 ld-linux.so`, `man 1 dyld`.

---

## Topics

### What is in this section

```text
  Six topic groups covering the libc anatomy, linking, ABIs, threading,
  cryptography, and networking helpers.

  ┌─── libc anatomy ──────────────────────────────────────────────────────────┐
  │  headers · syscall wrappers · FILE streams · malloc impls · locale/ICU   │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── linking & loading ─────────────────────────────────────────────────────┐
  │  static vs dynamic  │  ld.so / dyld / NT loader  │  PLT · GOT           │
  │  lazy binding  │  RPATH / RUNPATH  │  symbol versioning  │  visibility   │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── ABIs ──────────────────────────────────────────────────────────────────┐
  │  C ABI (calling conventions)  │  Itanium C++ ABI (Linux/macOS/Clang)     │
  │  MSVC C++ ABI  │  symbol versioning as ABI stability tool                │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── threading ─────────────────────────────────────────────────────────────┐
  │  pthreads (attributes, cancellation)  │  C11 <threads.h>                 │
  │  C++11 <thread>/<atomic>/<mutex>  │  futexes (Linux) · WaitOnAddress     │
  │  TLS — thread-local storage                                               │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── crypto libraries ──────────────────────────────────────────────────────┐
  │  OpenSSL / LibreSSL / BoringSSL  │  libsodium  │  mbedTLS               │
  │  CommonCrypto (Apple)  │  Schannel / CNG (Windows)                       │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── networking helpers & compression ──────────────────────────────────────┐
  │  getaddrinfo / NSS  │  libcurl  │  libuv / libevent / libev              │
  │  zlib (deflate) · zstd · lz4 · xz/lzma · brotli                         │
  └───────────────────────────────────────────────────────────────────────────┘
```

### Dedicated Topic Deep Dives

| File | Covers |
|------|--------|
| [libc Variants](libc_variants.md) | glibc, musl, Bionic, uClibc, newlib |

### libc anatomy
- **Headers** — `stdio.h`, `stdlib.h`, `string.h`, `unistd.h`, `pthread.h`, ...
- **Syscall wrappers** — `read()` / `open()` / `mmap()` thin shims.
- **stdio FILE streams** — buffering modes (line/full/unbuffered).
- **malloc implementations** — ptmalloc (glibc), mimalloc, jemalloc, tcmalloc, hoard.
- **Locales & ICU** — UTF-8 vs wide chars; `iconv`.

### Linking & loading
- **Static vs dynamic linking** — tradeoffs.
- **Dynamic linker** — `ld.so` / `dyld` / NT loader; relocation, PLT, GOT.
- **Lazy binding** — first call triggers symbol resolution.
- **RPATH / RUNPATH** — embedded library search paths.
- **Symbol versioning** — GLIBC_2.x, version scripts.
- **Visibility** — default vs hidden vs protected.

### ABIs
- **C ABI** — calling conventions per platform (see [CPU › Protocols](../02_CPU/README.md#protocols)).
- **C++ ABI** — Itanium ABI (Linux/macOS/Clang), MSVC ABI; mangling, vtables, RTTI.
- **Stable ABIs** — what changes break consumers; symbol versioning as mitigation.

### Threading
- **pthreads** — POSIX threads model, attributes, cancellation.
- **C11 `<threads.h>`**, **C++11 `<thread>`/`<atomic>`/`<mutex>`**.
- **Futexes** (Linux), **WaitOnAddress** (Windows).
- **TLS** — thread-local storage; per-arch implementation.

### Crypto libraries
- **OpenSSL** / **LibreSSL** / **BoringSSL** — TLS + primitives.
- **libsodium** — opinionated NaCl-derived API.
- **mbedTLS** — embedded-friendly.
- **CommonCrypto** (Apple), **Schannel/CNG** (Windows).

### Networking helpers
- **Resolver** — `getaddrinfo`, `/etc/nsswitch.conf`, NSS modules.
- **libcurl** — multi-protocol client.
- **libuv / libevent / libev** — event loops (used by Node, etc.).

### Compression
- **zlib** (deflate), **zstd**, **lz4**, **xz/lzma**, **brotli**.

---

## Protocols

### What is in this section

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

### Library formats
- **ELF** — Linux/BSD shared objects (`.so`)
- **Mach-O** — macOS dylibs (`.dylib`), bundles, frameworks
- **PE/COFF** — Windows DLLs (`.dll`)
- **Static archives** — `.a` (Unix), `.lib` (Windows)

### Package/build metadata
- **pkg-config (`.pc`)** — compile/link flag manifests
- **CMake config-file packages** — `Foo-config.cmake`
- **Autotools (`.la`)** — libtool archives (legacy)

### Cross-link
- ABIs live in [CPU › Protocols](../02_CPU/README.md#protocols)
- Syscall surface in [OS Kernel › Protocols](../05_OS_Kernel/README.md#protocols)
