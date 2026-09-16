# Runtime Environment — Manual Pages

## What is in this section

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

## Dedicated man page references

| Topic | File |
|-------|------|
| Container management | [container_commands.md](container_commands.md) — docker, podman, systemd-nspawn, crictl |
| Virtual machine management | [vm_commands.md](vm_commands.md) — qemu-system, virsh, VBoxManage |

---

## Language runtimes (CLI launchers)
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

## Wasm
| Command | Purpose |
|---------|---------|
| `wasmtime` | Wasmtime CLI runtime |
| `wasmer` | Wasmer CLI runtime |
| `wasm-tools` | wasm utilities (validate, dump, component) |
| `wasm-pack` | Rust → npm wasm packaging |

## Containers
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

## Orchestrators
| Command | Purpose |
|---------|---------|
| `kubectl` | Kubernetes client |
| `helm` | K8s package manager |
| `kustomize` | K8s manifest overlay |
| `kind` | Local K8s (in Docker) |
| `minikube` | Local K8s VM |
| `k3s`, `k3d` | Lightweight K8s |
| `nomad` | HashiCorp scheduler |

## Hypervisors
| Command | Purpose |
|---------|---------|
| `qemu-system-*` | QEMU |
| `virsh`, `virt-install`, `virt-manager` | libvirt |
| `firecracker`, `cloud-hypervisor` | microVMs |
| `bhyve` | FreeBSD hypervisor |
