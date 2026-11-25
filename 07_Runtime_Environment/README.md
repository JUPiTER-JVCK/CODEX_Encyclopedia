# 07 — Runtime Environment

> The execution substrate for high-level languages: JVMs, interpreters,
> .NET CLR, JS engines, Go/Rust standard runtimes, container runtimes,
> and the orchestration on top of them.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  08  User Applications                       │
└───────────────────────┬──────────────────────┘
                        │  runtime APIs (JNI, FFI, ABI)
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  07  Runtime Environment          ◀── here   ┃
┃      VMs · interpreters · GC · FFI           ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  function calls wrapping syscalls
┌───────────────────────┴──────────────────────┐
│  06  System Libraries                        │
└──────────────────────────────────────────────┘
```

## At a glance

| Field | Value |
|-------|-------|
| Description | Platform for application execution |
| Languages | C/C++ (host), Java, Python, JS, Go, Ruby, .NET languages, etc. |
| Medium / Interface | OS services + runtime-specific APIs (JNI, FFI, ABI) |
| Example | JVM executes Java bytecode using OS calls |
| Adjacent layers | ↓ [06_System_Libraries](../06_System_Libraries/), ↑ [08_User_Applications](../08_User_Applications/) |

## What lives here

- **JVM** — OpenJDK HotSpot, GraalVM, Eclipse OpenJ9, Azul Zing
- **CLR / .NET runtime** — CoreCLR, Mono, NativeAOT
- **JS engines** — V8, SpiderMonkey, JavaScriptCore, Hermes
- **CPython, PyPy, MicroPython** — Python implementations
- **Ruby (CRuby/MRI), JRuby, TruffleRuby, mruby**
- **Go runtime, Rust runtime (minimal), Node.js, Deno, Bun**
- **Erlang/BEAM** — Erlang/Elixir/Gleam VM
- **Container runtimes** — runc, crun, containerd, CRI-O, Docker, Podman
- **Orchestrators** — Kubernetes, Nomad, ECS
- **VM hypervisors as runtime** — KVM/QEMU, VMware, Hyper-V, Firecracker
- **WebAssembly runtimes** — Wasmtime, Wasmer, WAMR, V8/Wasm

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | JVM spec, ECMAScript, CPython docs |
| [Lessons](#lessons) | [Interactive labs](runtime_labs.md) | GC tuning, profiling, native interop |
| [Languages](#languages) | — | managed-vs-native lookup |
| [Manual Pages](#manual-pages) | [Container Management Commands](container_commands.md) · [Virtual Machine Management Commands](vm_commands.md) | `java`, `python`, `node`, `docker`, `kubectl` |
| [Topics](#topics) | [Container Internals](container_internals.md) | GC, JIT, sandboxing, containers, wasm |
| [Protocols](#protocols) | [OCI Runtime](oci_runtime.md) | JNI, gRPC, OCI image, CRI, CSI |

## Cross-references
- Underlying libs the runtime uses → [06_System_Libraries](../06_System_Libraries/)
- App code that runs on the runtime → [08_User_Applications](../08_User_Applications/)
- Container isolation kernel-side → [OS Kernel › Topics](../05_OS_Kernel/README.md#topics)
- ML training/inference runtimes → [15_AI_ML](../15_AI_ML/)

---

## References

### What is in this section

```text
  Three reference groups: specifications, books, and online resources.

  ┌─── specifications ────────────────────────────────────────────────────────┐
  │  JVMS · JLS (Java)  │  ECMA-262 (JS)  │  WebAssembly Core (W3C)         │
  │  ISO/IEC 23271 (.NET)  │  CPython C-API docs  │  OCI specs  │  K8s API  │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── books ─────────────────────────────────────────────────────────────────┐
  │  Crafting Interpreters (Nystrom, free)  │  Writing an Interpreter in Go  │
  │  GC Handbook (Jones/Hosking/Moss)  │  CPython Internals (Shaw)           │
  │  Java Performance (Oaks)  │  CLR via C# (Richter)                        │
  │  Programming Erlang (Armstrong)  │  Kubernetes in Action (Lukša)         │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── online ────────────────────────────────────────────────────────────────┐
  │  JVM Anatomy Park (Shipilëv)  │  v8.dev/blog  │  runtime/HACKING.md (Go) │
  │  Wasmtime book (docs.wasmtime.dev)                                        │
  └───────────────────────────────────────────────────────────────────────────┘
```

### Specs
- **Java Virtual Machine Specification (JVMS)** — Oracle.
- **The Java Language Specification (JLS)** — Oracle.
- **ECMAScript Language Specification (ECMA-262)** — TC39.
- **WebAssembly Core Specification** — W3C.
- **ISO/IEC 23271** — Common Language Infrastructure (.NET).
- **CPython Internals docs** — `https://docs.python.org/3/c-api/`.
- **OCI Image / Runtime / Distribution Specs** — `https://opencontainers.org/`.
- **Kubernetes API reference** — `https://kubernetes.io/docs/reference/`.

### Books
- *Crafting Interpreters* — Bob Nystrom. Free online.
- *Writing an Interpreter / Compiler in Go* — Thorsten Ball.
- *The Garbage Collection Handbook* — Jones, Hosking, Moss.
- *CPython Internals* — Anthony Shaw.
- *Java Performance: The Definitive Guide* — Scott Oaks.
- *CLR via C#* — Jeffrey Richter.
- *Programming Erlang* — Joe Armstrong.
- *Kubernetes in Action* — Marko Lukša.

### Online
- **JVM Anatomy Park** — Aleksey Shipilëv blog posts.
- **V8 blog** — `https://v8.dev/blog`.
- **Go internals docs** — `runtime/HACKING.md`.
- **Wasmtime book** — `https://docs.wasmtime.dev/`.

---

## Lessons

### What is in this section

```text
  Dedicated module plus ten numbered lessons across four topic groups.

  ┌─── dedicated module ──────────────────────────────────────────────────────┐
  │  runtime_labs.md — container from scratch, OCI image, systemd unit       │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── observability & profiling  (1–3) ──────────────────────────────────────┐
  │  1 GC observed (JVM -Xlog:gc*, CPython gc.set_debug, V8 --trace-gc)      │
  │  2 JIT warm-up — measure tiered compilation effects                      │
  │  3 profile a runtime (async-profiler, py-spy, 0x, pprof)                 │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── interop & threading models  (4–5) ─────────────────────────────────────┐
  │  4 native interop — JNI, P/Invoke, Python ctypes, Go cgo                 │
  │  5 threading models — JVM threads, GIL + asyncio, V8 + workers, BEAM    │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── containers & orchestration  (6–8) ─────────────────────────────────────┐
  │  6 container 101 — build image, push registry, run via runc / Docker     │
  │  7 Kubernetes basics — deployment, service, ingress, logs                │
  │  8 init container & sidecar pattern                                       │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── WebAssembly & embedding  (9–10) ───────────────────────────────────────┐
  │  9 Wasm sandbox — compile Rust → wasm32-wasip1; run under wasmtime       │
  │  10 embed a runtime — V8 in C++, or wasmtime in Rust                     │
  └───────────────────────────────────────────────────────────────────────────┘
```

### Dedicated lesson modules

| Topic | File |
|-------|------|
| Runtime interactive labs | [Runtime Environment interactive labs](runtime_labs.md) — Container from scratch, OCI image, systemd unit |

---

1. **GC observed** — log GC events in JVM (`-Xlog:gc*`), CPython (`gc.set_debug`), V8 (`--trace-gc`).
2. **JIT warm-up** — write a hot loop; measure tiered compilation effects (JVM, V8).
3. **Profile a runtime** — async-profiler (JVM), `py-spy` (CPython), `0x` (Node), `pprof` (Go).
4. **Native interop** — JNI hello, .NET P/Invoke, Python `ctypes`, Go `cgo`.
5. **Threading models** — JVM threads, GIL & asyncio, V8 single-thread + workers, BEAM processes.
6. **Container 101** — build an image, push to a registry, run via runc and via Docker.
7. **Kubernetes basics** — deployment, service, ingress; apply, get, describe, logs.
8. **Init container & sidecar** — pattern walk-through with a logging sidecar.
9. **Wasm sandbox** — compile Rust → wasm32-wasip1; run under wasmtime.
10. **Embedding a runtime** — embed V8 in a C++ app, or wasmtime in Rust.

### Suggested external
- "The Garbage Collection Handbook" companion talks.
- KubeCon talks (CNCF) — Kubernetes deep dives.
- Mozilla Servo / V8 internals talks.

---

## Languages

### What is in this section

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

### JVM ecosystem
| Language | Notes |
|----------|-------|
| Java | The reference language |
| Kotlin | JetBrains; Android first-class |
| Scala | FP/OO hybrid; Akka, Spark |
| Groovy | Dynamic JVM; Gradle |
| Clojure | LISP on the JVM |
| JRuby | Ruby on JVM |
| Jython | Python on JVM (older; 2.x only) |

### .NET (CLR / CoreCLR / Mono / NativeAOT)
| Language | Notes |
|----------|-------|
| C# | Primary .NET language |
| F# | FP on .NET |
| VB.NET | Legacy |
| PowerShell | Shell on .NET |

### JavaScript engines (V8, SpiderMonkey, JSC, Hermes)
| Language | Notes |
|----------|-------|
| JavaScript (ECMAScript) | The native input |
| TypeScript | Transpiles to JS |
| Dart | (Flutter; AOT or JIT) |
| ClojureScript, Elm, ReScript | Compile-to-JS |

### CPython / PyPy
| Language | Notes |
|----------|-------|
| Python | Reference impl is CPython; PyPy uses JIT |
| Cython | C-extension dialect of Python |

### Native runtimes (minimal, mostly libc + std)
| Language | Runtime details |
|----------|-----------------|
| Go | Stop-the-world to concurrent GC; goroutines on M:N scheduler |
| Rust | Tiny runtime; no GC; async exec via tokio/async-std |
| Swift | ARC instead of GC; Swift runtime + libdispatch |
| C / C++ | libc + C++ stdlib (see [06](../06_System_Libraries/)) |

### Erlang/BEAM
| Language | Notes |
|----------|-------|
| Erlang | Reference |
| Elixir | Modern syntax atop BEAM |
| Gleam | Statically typed BEAM language |
| LFE | LISP-flavored Erlang |

### WebAssembly
| Source language | Compiles to wasm via |
|-----------------|----------------------|
| Rust | `wasm32-unknown-unknown`, `wasm32-wasip2` |
| C / C++ | Emscripten, clang `-target wasm32` |
| Go | TinyGo, Go-Wasm |
| AssemblyScript | TypeScript-like wasm |
| .NET | Blazor (mono-wasm), NativeAOT-LLVM |

---

## Manual Pages

### What is in this section

```text
  Two dedicated subfiles plus five command groups.

  ┌─── dedicated files ───────────────────────────────────────────────────────┐
  │  container_commands.md — docker, podman, systemd-nspawn, crictl          │
  │  vm_commands.md — qemu-system, virsh, VBoxManage                         │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── language runtime CLIs ─────────────────────────────────────────────────┐
  │  JVM: java · javac · jar · jcmd · jstack · jmap · jstat                  │
  │  .NET: dotnet  │  Node: node / npx / deno / bun                          │
  │  Python: python3 · pip · uv  │  Ruby: ruby · gem · bundle                │
  │  Go: go / go test / pprof  │  Rust: cargo · rustc  │  Swift: swift       │
  │  BEAM: erl · iex · mix  │  PHP: php / composer  │  Perl: perl / cpan    │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── WebAssembly ───────────────────────────────────────────────────────────┐
  │  wasmtime  │  wasmer  │  wasm-tools (validate, dump, component)           │
  │  wasm-pack (Rust → npm packaging)                                         │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── containers ────────────────────────────────────────────────────────────┐
  │  docker · podman · nerdctl · ctr  │  runc · crun (OCI executors)         │
  │  buildah · buildkit · kaniko  │  skopeo · dive · slim                    │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── orchestrators ─────────────────────────────────────────────────────────┐
  │  kubectl · helm · kustomize  │  kind · minikube · k3s/k3d  │  nomad      │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── hypervisors ───────────────────────────────────────────────────────────┐
  │  qemu-system-*  │  virsh / virt-install  │  firecracker  │  bhyve        │
  └───────────────────────────────────────────────────────────────────────────┘
```

### Dedicated man page references

| Topic | File |
|-------|------|
| Container management | [Container Management Commands](container_commands.md) — docker, podman, systemd-nspawn, crictl |
| Virtual machine management | [Virtual Machine Management Commands](vm_commands.md) — qemu-system, virsh, VBoxManage |

---

### Language runtimes (CLI launchers)
| Command | Runtime |
|---------|---------|
| `java`, `javac`, `jar`, `jdeps`, `jcmd`, `jstack`, `jmap`, `jstat` | JVM toolchain |
| `dotnet` | .NET CLI |
| `node`, `npx`, `deno`, `bun` | JavaScript runtimes |
| `python` / `python3`, `pip`, `pipx`, `uv`, `poetry` | CPython ecosystem |
| `ruby`, `gem`, `bundle`, `rake` | Ruby |
| `go`, `go run`, `go test`, `go tool pprof` | Go |
| `cargo`, `rustc`, `rustup` | Rust |
| `swift` | Swift |
| `erl`, `iex`, `mix`, `rebar3` | BEAM languages |
| `php`, `composer` | PHP |
| `perl`, `cpan` | Perl |

### Wasm
| Command | Purpose |
|---------|---------|
| `wasmtime` | Wasmtime CLI runtime |
| `wasmer` | Wasmer CLI runtime |
| `wasm-tools` | wasm utilities (validate, dump, component) |
| `wasm-pack` | Rust → npm wasm packaging |

### Containers
| Command | Purpose |
|---------|---------|
| `docker` | Docker CLI |
| `podman` | Daemonless container CLI |
| `nerdctl` | containerd CLI |
| `ctr` | containerd low-level CLI |
| `runc` / `crun` | OCI runtime executors |
| `buildah`, `buildkit`, `kaniko` | Image builders |
| `skopeo` | Inspect / copy / sign images |
| `dive` | Inspect image layers |
| `slim` (DockerSlim) | Minimize images |

### Orchestrators
| Command | Purpose |
|---------|---------|
| `kubectl` | Kubernetes client |
| `helm` | K8s package manager |
| `kustomize` | K8s manifest overlay |
| `kind` | Local K8s (in Docker) |
| `minikube` | Local K8s VM |
| `k3s`, `k3d` | Lightweight K8s |
| `nomad` | HashiCorp scheduler |

### Hypervisors
| Command | Purpose |
|---------|---------|
| `qemu-system-*` | QEMU |
| `virsh`, `virt-install`, `virt-manager` | libvirt |
| `firecracker`, `cloud-hypervisor` | microVMs |
| `bhyve` | FreeBSD hypervisor |

---

## Topics

### What is in this section

```text
  Seven topic groups: execution, GC, concurrency, containers, orchestration,
  hypervisors, and WebAssembly.

  ┌─── execution models ──────────────────────────────────────────────────────┐
  │  interpretation (CPython, MRI Ruby)  │  JIT (tiered, tracing)            │
  │  AOT (GraalVM, NativeAOT, Dart, Go)  │  hybrid (V8 Ignition→TurboFan)   │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── garbage collection ────────────────────────────────────────────────────┐
  │  tracing: mark-sweep · generational · G1 · ZGC · Shenandoah · Go        │
  │  reference counting (CPython, Swift ARC)  │  manual / RAII (C++, Rust)  │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── concurrency / parallelism ─────────────────────────────────────────────┐
  │  OS threads (JVM, .NET)  │  GIL + asyncio (CPython)                      │
  │  goroutines / Loom / Kotlin coroutines  │  actor model (BEAM/Akka)       │
  │  event loops (libuv · asyncio · Tokio)                                   │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── containers & images ───────────────────────────────────────────────────┐
  │  OCI image spec (layers, manifests)  │  runc/crun (OCI runtime spec)     │
  │  namespaces · cgroups · seccomp  │  overlay2 storage  │  rootless        │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── Kubernetes / orchestration ────────────────────────────────────────────┐
  │  Pod · Deployment · StatefulSet · DaemonSet · Job · CronJob              │
  │  service mesh (Istio/Linkerd)  │  PV/PVC · CSI  │  CRD Operators        │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── VMs / hypervisors ─────────────────────────────────────────────────────┐
  │  Type 1 / Type 2  │  paravirtualization + virtio  │  microVMs            │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── WebAssembly ───────────────────────────────────────────────────────────┐
  │  module (sections · imports/exports · memory · tables)                   │
  │  WASI 0.2 (component model)  │  embedding (wasmtime, V8, JVM/Chicory)   │
  └───────────────────────────────────────────────────────────────────────────┘
```

### Dedicated Topic Deep Dives

| File | Covers |
|------|--------|
| [Container Internals](container_internals.md) | Namespaces, cgroups v2, overlayfs, seccomp |

### Execution models
- **Interpretation** — bytecode walk (CPython, MRI Ruby).
- **JIT** — tiered (V8 Ignition→TurboFan, JVM C1→C2/Graal), tracing JITs (PyPy, LuaJIT).
- **AOT** — GraalVM Native Image, .NET NativeAOT, Dart AOT, Go.
- **Hybrid** — JS engines mix interp + multiple JIT tiers.

### Garbage collection
- **Tracing GCs** — mark-sweep, mark-compact, copying, generational.
- **Modern collectors** — G1, ZGC, Shenandoah (JVM); GC concurrent in V8; CPython refcount + cycle collector; Go concurrent tricolor.
- **Reference counting** — CPython, Swift ARC, Objective-C ARC.
- **Manual / RAII** — C++, Rust ownership model (no GC).

### Concurrency / parallelism
- **Threads** — OS threads exposed by JVM, .NET, native runtimes.
- **GIL** — CPython's Global Interpreter Lock; PEP 703 (no-GIL) progress.
- **Goroutines / fibers** — Go scheduler, Loom (Java virtual threads), Kotlin coroutines.
- **Actor model** — BEAM processes, Akka.
- **Event loops** — libuv (Node), asyncio (Python), Tokio (Rust).

### Containers & images
- **Image format** — OCI image spec (layers, manifests, configs).
- **Runtime** — runc/crun execute OCI runtime spec configs.
- **Linux primitives used** — namespaces, cgroups, seccomp, capabilities, MAC.
- **Storage drivers** — overlay2, btrfs, zfs.
- **Networking** — bridge, host, macvlan, CNI plugins.
- **Rootless containers** — user namespaces.

### Kubernetes / orchestration
- **Workload kinds** — Pod, Deployment, StatefulSet, DaemonSet, Job, CronJob.
- **Service mesh** — Istio, Linkerd; sidecar vs ambient.
- **Storage** — PV/PVC, CSI drivers.
- **Networking** — Service, Ingress, NetworkPolicy, CNI.
- **Operators / CRDs** — extending the API.

### VMs / hypervisors as runtime
- **Type 1 / Type 2** hypervisors.
- **Paravirtualization** vs full virt; **virtio**.
- **microVMs** — Firecracker, Cloud Hypervisor.

### WebAssembly
- **Module structure** — sections, imports/exports, memory, tables.
- **WASI** — POSIX-ish system interface; WASI 0.2 components.
- **Component model** — interface types, world definitions.
- **Embedding** — wasmtime, V8, JVM (Chicory, Wasmer).

### Security cross-link
- Sandbox escapes, container CVEs → [Security › Topics](../14_Security/README.md#topics)
- Wasm capability model & isolation → [Security › Topics](../14_Security/README.md#topics)

---

## Protocols

### What is in this section

```text
  Four groups: language/bytecode specs, container/orchestration specs,
  native-interop ABIs, and RPC/wire protocols.

  ┌─── language & bytecode specs ─────────────────────────────────────────────┐
  │  JVMS (JVM bytecode)  │  ECMA-335 (CLI/.NET IL)  │  ECMA-262 (JS)       │
  │  WebAssembly Core  │  WASI 0.2 (component model)  │  PEP 484/561 (Python)│
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── container & orchestration ─────────────────────────────────────────────┐
  │  OCI Image · OCI Runtime · OCI Distribution  │  OCI Artifacts            │
  │  CRI (kubelet↔runtime)  │  CNI (network)  │  CSI (storage)  │  SMI      │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── native-interop ABIs ───────────────────────────────────────────────────┐
  │  JNI / Panama FFM (JVM)  │  P/Invoke (.NET)  │  N-API (Node.js)         │
  │  ctypes / cffi (Python)  │  cgo (Go)  │  Swift–C / Swift–Obj-C          │
  └───────────────────────────────────────────────────────────────────────────┘

  ┌─── RPC / wire protocols ──────────────────────────────────────────────────┐
  │  gRPC (HTTP/2 + protobuf)  │  JSON-RPC · MessagePack-RPC                 │
  │  Thrift  │  Cap'n Proto  │  GraphQL over HTTP/WS                         │
  └───────────────────────────────────────────────────────────────────────────┘
```

> OCI image/runtime/distribution specifications and adjacent runtime standards.

### Dedicated Protocol References

| File | Covers |
|------|--------|
| [OCI Runtime/Image/Distribution Specs](oci_runtime.md) | Container lifecycle, image format, registry API |

### Language & bytecode specs

| Spec | Covers |
|------|--------|
| JVMS | JVM bytecode, class file format |
| ECMA-335 (CLI) | .NET intermediate language, metadata, type system |
| ECMA-262 (ECMAScript) | JavaScript language |
| WebAssembly Core | wasm bytecode, validation, execution |
| WASI 0.2 | WebAssembly system interface (component model) |
| PEP 484 / 561 | Python type hints / stub distribution |

### Container & orchestration
| Spec | Owner | Pins |
|------|-------|------|
| OCI Image Spec | OCI | Image layout & manifest |
| OCI Runtime Spec | OCI | Container runtime config |
| OCI Distribution Spec | OCI | Registry HTTP API |
| CRI | Kubernetes | Container Runtime Interface (kubelet ↔ runtime) |
| CNI | CNCF | Container Network Interface |
| CSI | CNCF | Container Storage Interface |
| SMI | (Service Mesh Interface) | Cross-mesh policy / traffic |
| OCI Artifacts | OCI | Non-image content via registry |

### Native-interop ABIs
| ABI | Runtime | Notes |
|-----|---------|-------|
| JNI | JVM | Java ↔ C/C++ |
| Project Panama (FFI/FFM) | JVM | Modern foreign linker API |
| P/Invoke | .NET | C interop |
| ctypes / cffi | Python | C interop |
| N-API / NAPI | Node.js | Stable ABI for native addons |
| cgo | Go | C interop |
| Swift–C / Swift–Objective-C | Swift | Apple interop |

### RPC / wire protocols (often runtime-bundled)
- **gRPC** (HTTP/2 + protobuf)
- **JSON-RPC**, **MessagePack-RPC**
- **Thrift**, **Cap'n Proto**
- **GraphQL over HTTP/WS**

### Cross-link
- HTTP/gRPC wire details → [Network Application › Protocols](../13_Network_Application/README.md#protocols)
