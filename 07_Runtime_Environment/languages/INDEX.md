# Runtime Environment — Languages

## What is in this section

```text
  Seven runtime ecosystems, grouped by their execution model.

  ┌─── JVM ───────────────────────────────────────────────────────────────────┐
  │  Java · Kotlin · Scala · Groovy · Clojure · JRuby · Jython               │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── .NET (CLR / CoreCLR / Mono / NativeAOT) ──────────────────────────────┐
  │  C# · F# · VB.NET · PowerShell                                            │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── JavaScript engines (V8 · SpiderMonkey · JSC · Hermes) ────────────────┐
  │  JavaScript (ECMAScript) · TypeScript · ClojureScript · Elm              │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── CPython / PyPy ────────────────────────────────────────────────────────┐
  │  Python (CPython ref impl, PyPy JIT) · Cython                            │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── native runtimes ───────────────────────────────────────────────────────┐
  │  Go (concurrent GC, goroutines)  │  Rust (no GC, async-std/Tokio)        │
  │  Swift (ARC + libdispatch)  │  C / C++ (libc + C++ stdlib)               │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── Erlang / BEAM ─────────────────────────────────────────────────────────┐
  │  Erlang · Elixir · Gleam · LFE                                            │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── WebAssembly ───────────────────────────────────────────────────────────┐
  │  Rust · C/C++ (Emscripten) · Go (TinyGo) · AssemblyScript · .NET (Blazor)│
  └───────────────────────────────────────────────────────────────────────────┘
```

The languages that *target* this layer, grouped by runtime model.

## JVM ecosystem
| Language | Notes |
|----------|-------|
| Java | The reference language |
| Kotlin | JetBrains; Android first-class |
| Scala | FP/OO hybrid; Akka, Spark |
| Groovy | Dynamic JVM; Gradle |
| Clojure | LISP on the JVM |
| JRuby | Ruby on JVM |
| Jython | Python on JVM (older; 2.x only) |

## .NET (CLR / CoreCLR / Mono / NativeAOT)
| Language | Notes |
|----------|-------|
| C# | Primary .NET language |
| F# | FP on .NET |
| VB.NET | Legacy |
| PowerShell | Shell on .NET |

## JavaScript engines (V8, SpiderMonkey, JSC, Hermes)
| Language | Notes |
|----------|-------|
| JavaScript (ECMAScript) | The native input |
| TypeScript | Transpiles to JS |
| Dart | (Flutter; AOT or JIT) |
| ClojureScript, Elm, ReScript | Compile-to-JS |

## CPython / PyPy
| Language | Notes |
|----------|-------|
| Python | Reference impl is CPython; PyPy uses JIT |
| Cython | C-extension dialect of Python |

## Native runtimes (minimal, mostly libc + std)
| Language | Runtime details |
|----------|-----------------|
| Go | Stop-the-world to concurrent GC; goroutines on M:N scheduler |
| Rust | Tiny runtime; no GC; async exec via tokio/async-std |
| Swift | ARC instead of GC; Swift runtime + libdispatch |
| C / C++ | libc + C++ stdlib (see [06](../../06_System_Libraries/)) |

## Erlang/BEAM
| Language | Notes |
|----------|-------|
| Erlang | Reference |
| Elixir | Modern syntax atop BEAM |
| Gleam | Statically typed BEAM language |
| LFE | LISP-flavored Erlang |

## WebAssembly
| Source language | Compiles to wasm via |
|-----------------|----------------------|
| Rust | `wasm32-unknown-unknown`, `wasm32-wasip2` |
| C / C++ | Emscripten, clang `-target wasm32` |
| Go | TinyGo, Go-Wasm |
| AssemblyScript | TypeScript-like wasm |
| .NET | Blazor (mono-wasm), NativeAOT-LLVM |
