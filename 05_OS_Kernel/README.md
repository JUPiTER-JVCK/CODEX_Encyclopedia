# 05 — OS Kernel

> The traffic cop. Schedules processes, manages memory, mediates hardware
> through drivers, enforces privilege boundaries, and exposes the syscall
> interface that everything above depends on.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  06  System Libraries                        │
└───────────────────────┬──────────────────────┘
                        │  system calls
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  05  OS Kernel                    ◀── here   ┃
┃      processes · memory · VFS · scheduling   ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  driver APIs the kernel calls
┌───────────────────────┴──────────────────────┐
│  04  Device Drivers                          │
└──────────────────────────────────────────────┘
```

## At a glance

| Field | Value |
|-------|-------|
| Description | Manages resources, security, hardware |
| Languages | C, Assembly (Rust in Linux; Rust + Swift in Apple SEPOS) |
| Medium / Interface | System calls, hardware via drivers |
| Example | File-open request handled via kernel calls |
| Adjacent layers | ↓ [04_Device_Drivers](../04_Device_Drivers/), ↑ [06_System_Libraries](../06_System_Libraries/) |

## What lives here

- **Linux** — monolithic, modular; LTS releases, distros
- **BSDs** — FreeBSD, OpenBSD, NetBSD, Dragonfly
- **macOS / iOS** — XNU (Mach + BSD), Darwin
- **Windows** — NT kernel (hybrid), Hyper-V hypervisor
- **Microkernels & hybrids** — seL4, MINIX 3, Fuchsia (Zircon), QNX
- **Hypervisors** — KVM, Xen, Hyper-V, VMware ESXi, bhyve
- **Containers' kernel side** — namespaces, cgroups, seccomp, capabilities

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | Linux/XNU/NT internals books |
| [Lessons](#lessons) | [Interactive labs](kernel_labs.md) | syscalls, scheduler, VFS, networking |
| [Languages](#languages) | — | kernel-grade C, Rust, asm |
| [Manual Pages](#manual-pages) | [Filesystem Commands](filesystem_commands.md) · [Memory Management Commands](memory_commands.md) · [Process Management Commands](process_commands.md) · [Tracing & Debugging Commands](tracing_commands.md) | `strace`, `bpftrace`, `sysctl`, `lsns` |
| [Topics](#topics) | [Virtual Memory](virtual_memory.md) | scheduler, MM, FS, IPC, namespaces |
| [Protocols](#protocols) | [POSIX Syscalls](posix_syscalls.md) | syscall ABIs, POSIX, /proc, netlink |

## Cross-references
- Bootloader → kernel handoff → [Firmware / BIOS › Topics](../03_Firmware_BIOS/README.md#topics)
- libc syscall wrappers → [06_System_Libraries](../06_System_Libraries/)
- Container/VM isolation → [Security › Topics](../14_Security/README.md#topics)
- Network stack lives inside the kernel → [09–13](../09_Network_Physical/)

---

## References

### What is in this section

```text
  Three reference groups for this layer.

  ┌─── general OS theory ────────────────────────────────────────────────┐
  │  OSTEP (Arpaci-Dusseau, free)  │  Tanenbaum Modern OS               │
  │  Silberschatz (dinosaur book)  │  Tanenbaum & Woodhull (MINIX)      │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── platform books ───────────────────────────────────────────────────┐
  │  Linux: Bovet&Cesati · Love (2) · Mauerer                          │
  │  macOS/iOS: Levin (3 vols) · Singh  │  Windows: Russinovich (2 vols)│
  │  FreeBSD: McKusick (2 eds)  │  Microkernel/formal: seL4 manual+papers│
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── online / official ────────────────────────────────────────────────┐
  │  kernel.org Documentation/  │  LWN.net  │  Phoronix  │  xnu source │
  └──────────────────────────────────────────────────────────────────────┘
```

### Books — general OS theory
- *Operating Systems: Three Easy Pieces* (OSTEP) — Arpaci-Dusseau. Free, excellent.
- *Modern Operating Systems* — Tanenbaum.
- *Operating System Concepts* — Silberschatz ("the dinosaur book").
- *Operating Systems: Design and Implementation* — Tanenbaum & Woodhull (MINIX).

### Linux
- *Understanding the Linux Kernel* — Bovet & Cesati.
- *Linux Kernel Development* — Robert Love.
- *Linux System Programming* — Robert Love (user-side, but adjacent).
- *Professional Linux Kernel Architecture* — Mauerer.

### Darwin / macOS / iOS
- *macOS and iOS Internals* (3 vols) — Jonathan Levin.
- *Mac OS X Internals* — Amit Singh.

### Windows
- *Windows Internals*, Parts 1 & 2 — Russinovich, Solomon, Ionescu, Yosifovich.

### BSD
- *The Design and Implementation of the FreeBSD Operating System* — McKusick, Neville-Neil, Watson.
- *The Design and Implementation of the 4.4BSD Operating System* — McKusick et al.

### Microkernels / formal
- *seL4 Reference Manual* + *seL4 papers*
- *MINIX 3: A Highly Reliable, Self-Repairing OS* — Tanenbaum

### Online
- **kernel.org** docs — `Documentation/` tree
- **LWN.net** — kernel development news
- **Phoronix** — Linux performance tracking
- **xnu source** — `https://github.com/apple-oss-distributions/xnu`

---

## Lessons

### What is in this section

```text
  Twelve exercises + a labs file (kernel_labs.md); grouped by focus.

  ┌─── build & observe ──────────────────────────────────────────────────┐
  │  1 build + boot (QEMU)  │  2 custom syscall  │  3 trace boot       │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── kernel subsystems ────────────────────────────────────────────────┐
  │  4 scheduler probe (bpftrace)  │  5 memory (page tables · OOM)     │
  │  6 VFS / FUSE  │  7 network path (NIC → softirq → socket)         │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── isolation & security ─────────────────────────────────────────────┐
  │  8 namespaces + cgroups  │  9 seccomp + capabilities                │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── advanced ─────────────────────────────────────────────────────────┐
  │  10 eBPF (XDP + kprobe)  │  11 hypervisor (KVM/QEMU)  │  12 seL4  │
  └──────────────────────────────────────────────────────────────────────┘
```

### Dedicated lesson modules

| Topic | File |
|-------|------|
| Kernel interactive labs | [OS Kernel interactive labs](kernel_labs.md) — Build & boot, custom syscall, eBPF, namespace container |

---

1. **Build a kernel** — fetch Linux source, `make defconfig && make -j$(nproc)`, boot under QEMU.
2. **Add a custom syscall** — register, implement, call from userspace.
3. **Trace boot** — `dmesg`, `printk` placement, kernel command line.
4. **Process & scheduler** — read `task_struct`, write a small CFS / EEVDF probe with bpftrace.
5. **Memory management** — page tables, slab allocators (`/proc/slabinfo`), OOM behavior.
6. **VFS & filesystems** — write a minimal FUSE filesystem; understand the inode/dentry cache.
7. **Networking subsystem** — packet path: NIC → IRQ → softirq → protocol → socket → app.
8. **Namespaces & cgroups** — build a container by hand with `unshare`, `nsenter`, `cgcreate`.
9. **seccomp & capabilities** — sandbox a binary with `seccomp-bpf` filter.
10. **eBPF program** — XDP packet counter, kprobe latency histogram, USDT trace.
11. **Hypervisor 101** — KVM/QEMU: launch a VM, understand `vcpu`, virtio.
12. **Microkernel touch** — boot seL4 / MINIX 3 in QEMU; observe IPC.

### Suggested external
- OSTEP labs (xv6) — write parts of a teaching OS.
- Linux Kernel Newbies — `https://kernelnewbies.org/`
- Brendan Gregg's BPF performance tools series.

---

## Languages

### What is in this section

```text
  Seven languages; C and Assembly are production-universal, the rest niche.

  ┌──────────────────────────── production ──────────────────────────────┐
  │  C — dominant; kernel dialect, no libc (Linux · BSD · NT · XNU)     │
  │  Assembly — entry stubs, context switch, mode transitions (all)     │
  │  Rust (Linux drivers · Redox)  │  C++ (XNU IOKit · NT · Zircon)    │
  └──────────────────────────────────────────────────────────────────────┘

  ┌──────────────────────────── niche / formal ──────────────────────────┐
  │  Swift (Apple SEPOS — internal)  │  Ada/SPARK (Muen, defense)       │
  │  Haskell (House, seL4 formal spec — research)                       │
  └──────────────────────────────────────────────────────────────────────┘
```

| Language | Use in kernel | Examples |
|----------|--------------|----------|
| C | Dominant. Kernel-specific dialect, no libc. | Linux, XNU (BSD half), NT, BSDs |
| Assembly | Entry/exit stubs, context switch, mode transitions | All kernels (arch/-specific dirs) |
| Rust | Growing presence in Linux; experimental in Windows | Linux drivers (`rust/`), Redox OS |
| C++ | XNU IOKit (kernel), parts of NT, Fuchsia (Zircon) | Macros restricted in IOKit |
| Swift | Apple's Secure Enclave (SEPOS, partially) | Apple-internal |
| Ada / SPARK | High-assurance kernels (Muen, some defense) | Niche |
| Haskell | Verified kernel research (House), seL4 spec | Academic |

### Linux kernel C dialect
- Pre-C89 + GCC extensions: statement expressions, typeof, attribute, designated init.
- `kmalloc/kfree`, `printk`, `copy_to/from_user`.
- Strict typing: `__user`, `__rcu`, `__iomem` sparse annotations.
- Locking primitives: `spin_lock`, `mutex`, `rwsem`, RCU.

### Build & verify
- **Linux** — Kbuild Makefiles, Kconfig, sparse, smatch, coccinelle.
- **XNU** — Xcode + KEXT tools (limited going forward).
- **NT** — WDK + Visual Studio + Driver Verifier.
- **seL4** — proof-carrying via Isabelle/HOL.

### Related
- Drivers use the same dialect → [Device Drivers › Languages](../04_Device_Drivers/README.md#languages)
- libc bridges to userland → [System Libraries › Languages](../06_System_Libraries/README.md#languages)

---

## Manual Pages

### What is in this section

```text
  Four dedicated subfiles plus inline tables by subsystem.

  ┌──────────────────────────────────────────────────────────────────────┐
  │  Dedicated files: process_commands · memory_commands                │
  │                   filesystem_commands · tracing_commands            │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── process / scheduling ─────────────────────────────────────────────┐
  │  ps · top/htop/btop · pidstat · pstree · nice · chrt · taskset     │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── memory ───────────────────────────────────────────────────────────┐
  │  free · vmstat · slabtop · smem · numastat · pmap                  │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── filesystem / VFS ─────────────────────────────────────────────────┐
  │  mount · df · du · stat · lsof · fuser · inotifywait               │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── tracing & debugging ──────────────────────────────────────────────┐
  │  strace · perf · bpftrace · bcc-tools · ftrace · dmesg · sysctl   │
  └──────────────────────────────────────────────────────────────────────┘
```

### Dedicated man page references

| Topic | File |
|-------|------|
| Process management | [Process Management Commands](process_commands.md) — ps, top, htop, kill, nice, chrt, taskset |
| Memory management | [Memory Management Commands](memory_commands.md) — free, vmstat, slabtop, smem, pmap |
| Filesystem tools | [Filesystem Commands](filesystem_commands.md) — mount, df, du, stat, lsof, fuser, inotifywait |
| Tracing & debugging | [Tracing & Debugging Commands](tracing_commands.md) — strace, perf, bpftrace, bcc-tools, dmesg, sysctl |

---

### Process / scheduling
| Command | Purpose |
|---------|---------|
| `ps` | Process snapshot |
| `top` / `htop` / `btop` | Live process view |
| `pidstat` | Per-process stats over time |
| `pstree` | Parent/child tree |
| `nice` / `renice` | Adjust niceness |
| `chrt` | Realtime scheduling class |
| `taskset` | CPU affinity |

### Memory
| Command | Purpose |
|---------|---------|
| `free` | Total/used memory |
| `vmstat` | Virtual memory + system activity |
| `slabtop` | Slab allocator usage |
| `smem` | PSS/USS memory accounting |
| `numastat` | NUMA memory stats |
| `pmap` | Process memory map |

### Filesystem / VFS
| Command | Purpose |
|---------|---------|
| `mount` / `umount` | Attach/detach filesystems |
| `df` / `du` | Space usage |
| `stat` | inode info |
| `lsof` | List open files |
| `fuser` | Identify processes using a file |
| `inotifywait` | Watch FS events |

### Tracing / debugging
| Command | Purpose |
|---------|---------|
| `strace` | Trace syscalls |
| `ltrace` | Trace library calls |
| `perf` | Performance counters & sampling |
| `bpftrace` | High-level eBPF tracing language |
| `bcc-tools` | eBPF tool suite (`execsnoop`, `opensnoop`, ...) |
| `ftrace` (via tracefs) | In-kernel function tracer |
| `dmesg` | Kernel ring buffer |
| `sysctl` | Read/write kernel parameters |
| `crash` | Post-mortem vmcore analysis |
| `gdb vmlinux` | Live or vmcore kernel debug |

### Namespaces / cgroups (Linux)
| Command | Purpose |
|---------|---------|
| `lsns` | List namespaces |
| `nsenter` | Enter an existing namespace |
| `unshare` | Run a command in a new namespace |
| `systemd-cgls` / `systemd-cgtop` | Cgroup tree / live view |

### macOS
- `dtrace`, `dtruss`, `sysdiagnose`, `spindump`, `fs_usage`, `vm_stat`

### Windows
- `tasklist`, `wmic process`, `procmon`, `procexp`, `xperf`, `WPA` (Windows Performance Analyzer)

---

## Topics

### What is in this section

```text
  Six groups: what the kernel manages, and how it is secured.

  ┌─── process & scheduling ─────────────────────────────────────────────┐
  │  task_struct · fork/exec · CFS/EEVDF · realtime · context switch    │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── memory management ────────────────────────────────────────────────┐
  │  page tables · TLB · buddy · slab/slub · cgroup OOM · HugePages    │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── filesystems ──────────────────────────────────────────────────────┐
  │  VFS (superblock·inode·dentry·file)  │  ext4·xfs·btrfs·zfs·apfs   │
  │  NFS·SMB  │  procfs·sysfs·tmpfs·cgroupfs  │  FUSE                 │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── IPC ──────────────────────────────────────────────────────────────┐
  │  pipes · UDS · shmem/semaphores · eventfd · futex · Mach ports     │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── network stack ────────────────────────────────────────────────────┐
  │  socket → protocol → IP/TCP/UDP → netdev → driver                  │
  │  NAPI · XDP · eBPF/XDP · TC (traffic control)                     │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── security / isolation ─────────────────────────────────────────────┐
  │  capabilities · ACLs  │  LSMs (SELinux · AppArmor · Landlock)      │
  │  seccomp-BPF  │  namespaces · cgroups                              │
  └──────────────────────────────────────────────────────────────────────┘
```

### Dedicated Topic Deep Dives

| File | Covers |
|------|--------|
| [Virtual Memory](virtual_memory.md) | Page tables, TLB, mmap, huge pages, ASLR |

### Process & scheduling
- **Process / thread model** — `task_struct`, fork/clone/exec, exit/wait.
- **Schedulers** — CFS, EEVDF (Linux), Mach scheduler (XNU), Windows scheduler.
- **Realtime classes** — SCHED_FIFO, SCHED_RR, SCHED_DEADLINE; PREEMPT_RT.
- **Context switching** — kernel/user stack swap, FPU lazy save.

### Memory management
- **Virtual memory** — page tables, TLB, demand paging, COW, swap.
- **Allocators** — buddy, slab/slub/slob, vmalloc, kmalloc.
- **Memory cgroups & OOM** — limits, reclaim, oom_score.
- **HugePages / Transparent HugePages**, **memory compaction**.

### Filesystems
- **VFS abstractions** — superblock, inode, dentry, file.
- **Common FS** — ext4, xfs, btrfs, zfs, apfs, ntfs, refs.
- **Network FS** — NFS, SMB/CIFS, 9P.
- **Pseudo FS** — procfs, sysfs, debugfs, tmpfs, cgroupfs.
- **FUSE** — userspace filesystems.

### IPC
- **Pipes & FIFOs**, **Unix domain sockets**, **POSIX/SysV shared memory / semaphores / msg queues**.
- **eventfd, signalfd, timerfd**, **futex** (Linux).
- **Mach ports** (XNU), **ALPC** (Windows).

### Network stack inside the kernel
- **Socket layer** → protocol families → IP/TCP/UDP → netdev → driver.
- **NAPI, XDP, eBPF/XDP**, **TC (traffic control)**.

### Security / isolation
- **Privilege rings, capabilities, ACLs**.
- **LSMs** — SELinux, AppArmor, Smack, Yama, Landlock.
- **seccomp-BPF**, **seccomp_unotify**.
- **Namespaces** — pid, mnt, net, uts, ipc, user, cgroup, time.
- **Cgroups v1 & v2** — cpu, memory, io, pids, devices.

### Virtualization
- **KVM** — `/dev/kvm`, VM exits, virtio.
- **Hyper-V**, **VMware ESXi**, **Xen** (PV / HVM).
- **Containers** — runc, crun, containerd, CRI-O.

### Boot & init
- **Bootloader → kernel handoff** (zImage, vmlinuz, EFI stub).
- **initramfs / initrd**.
- **init systems** — systemd, OpenRC, launchd, SMF, Windows Service Manager.

### Observability
- **ftrace, kprobes, uprobes, tracepoints, USDT**.
- **eBPF programs & maps** — kprobe, uprobe, tracepoint, perf_event, XDP, TC.

### Security cross-link
- Rootkits, LKM injection, eBPF abuse → [Security › Topics](../14_Security/README.md#topics)

---

## Protocols

### What is in this section

```text
  Three groups: portability standards, arch-specific ABIs, pseudo-FS
  and messaging interfaces that cross the kernel/userspace boundary.

  ┌──────────────── portability standards ──────────────────────────────┐
  │  POSIX (IEEE 1003.1)  │  SUSv4/v5 (Open Group)  │  FHS (LF)       │
  │  LSB (historical)     │  systemd DBus / unit-file interfaces       │
  └─────────────────────────────────────────────────────────────────────┘

  ┌──────────────── Linux syscall ABIs (arch-specific) ─────────────────┐
  │  x86-64: syscall insn  │  i386: int 0x80 / sysenter               │
  │  AArch64: svc #0       │  RISC-V: ecall                           │
  └─────────────────────────────────────────────────────────────────────┘

  ┌──────────────── kernel ↔ userspace interfaces ──────────────────────┐
  │  /proc · /sys · /dev · debugfs · configfs                          │
  │  netlink (RTNL · NFNL · GENL)  │  ioctl  │  sysctl               │
  │  eventfd · signalfd · timerfd (fd-based event signaling)           │
  └─────────────────────────────────────────────────────────────────────┘
```

> POSIX & syscall ABI standards governing the kernel/user-space boundary.

### Dedicated Protocol References

| File | Covers |
|------|--------|
| [POSIX Syscalls](posix_syscalls.md) | Categories, calling convention, error handling |

### Portability standards

| Standard | Owner | Scope |
|----------|-------|-------|
| POSIX (IEEE 1003.1) | Open Group / IEEE | API surface for portable Unix code |
| SUSv4 / SUSv5 | Open Group | Single Unix Specification |
| LSB (Linux Standard Base) | LF | Distro ABI compatibility (largely historical now) |
| FHS (Filesystem Hierarchy Standard) | LF | `/usr`, `/etc`, `/var`, ... layout |
| systemd interfaces | freedesktop | DBus APIs, unit file syntax |

### Linux syscall ABIs (arch-specific)
- **x86-64** — `syscall` instruction, numbers in `<asm/unistd_64.h>`.
- **i386** — `int 0x80` (legacy) or `sysenter`.
- **AArch64** — `svc #0`, numbers in `<asm-generic/unistd.h>`.
- **RISC-V** — `ecall`, numbers in `<asm-generic/unistd.h>`.

### Kernel ↔ userspace interfaces
| Interface | Purpose |
|-----------|---------|
| syscall ABI | Direct kernel entry |
| `/proc` | Process & kernel state as files |
| `/sys` (sysfs) | Device & subsystem attributes |
| `/dev` (devtmpfs) | Device nodes |
| `debugfs` | Ad-hoc kernel debugging exports |
| `configfs` | Config-via-FS for subsystems |
| netlink | Bidirectional kernel/user msg (RTNL, NFNL, GENL) |
| ioctl | Per-device commands over fd |
| sysctl / `/proc/sys` | Tunables |
| eventfd / signalfd / timerfd | fd-based event signaling |

### Internal protocols
- **VFS operations** — `super_operations`, `inode_operations`, `file_operations`
- **netlink families** — NETLINK_ROUTE, NETLINK_NETFILTER, NETLINK_GENERIC
- **virtio** — paravirtualized device protocol (kernel ↔ hypervisor)
- **9P** — Plan 9 file protocol, used by virtio-9p

### Cross-link
- ABIs the kernel must honor → [CPU › Protocols](../02_CPU/README.md#protocols)
- libc as the syscall wrapper layer → [System Libraries › Protocols](../06_System_Libraries/README.md#protocols)
