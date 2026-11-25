# 04 — Device Drivers

> The translation layer between hardware quirks and OS-uniform APIs. Drivers
> let the kernel speak to the wildly varied stuff on the board without each
> subsystem reinventing the wheel.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  05  OS Kernel                               │
└───────────────────────┬──────────────────────┘
                        │  driver APIs the kernel calls
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  04  Device Drivers               ◀── here   ┃
┃      MMIO · DMA · IRQ handling · device state┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  electrical signals, serial & parallel buses
┌───────────────────────┴──────────────────────┐
│  01  Circuit Board                           │
└──────────────────────────────────────────────┘
```

## At a glance

| Field | Value |
|-------|-------|
| Description | Controls hardware; interfaces hardware to OS |
| Languages | C (dominant), C++, Rust (Linux), Swift (DriverKit) |
| Medium / Interface | OS driver APIs, hardware buses, IRQs, MMIO, DMA |
| Example | Disk driver reads data from disk |
| Adjacent layers | ↓ [01_Circuit_Board](../01_Circuit_Board/), ↑ [05_OS_Kernel](../05_OS_Kernel/) |

## What lives here

- **Linux drivers** — character, block, network, USB, PCI, platform; in-tree & DKMS
- **Windows drivers** — KMDF, UMDF, WDM; signed driver requirement
- **macOS / iOS** — IOKit (legacy), DriverKit (`*.dext`), kexts (deprecated)
- **BSD drivers** — newbus (FreeBSD), autoconf (OpenBSD/NetBSD)
- **Firmware blobs** — `linux-firmware`, vendor microcode
- **Userspace drivers** — VFIO, UIO, libusb, DPDK PMDs, SPDK

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | LDD3, Windows Driver Kit docs |
| [Lessons](#lessons) | [Interactive labs](driver_labs.md) | write a char driver → write a PCI driver |
| [Languages](#languages) | — | kernel C, Rust-for-Linux, DriverKit Swift |
| [Manual Pages](#manual-pages) | [Device & Driver Management Commands](device_commands.md) | `modprobe`, `lsmod`, `udevadm`, `kextstat` |
| [Topics](#topics) | [Linux Driver Model](driver_model.md) | interrupts, DMA, MMIO, driver models |
| [Protocols](#protocols) | — | driver↔kernel ABIs, ioctl conventions |

## Cross-references
- Bus enumeration → [Circuit Board › Topics](../01_Circuit_Board/README.md#topics)
- Kernel module loading → [OS Kernel › Topics](../05_OS_Kernel/README.md#topics)
- Driver-shipped vulns → [Security › Topics](../14_Security/README.md#topics)

---

## References

### What is in this section

```text
  Three reference types for this layer.

  ┌─── books ────────────────────────────────────────────────────────────┐
  │  LDD3 (Corbet · Rubini · Kroah-Hartman)  │  Linux Kernel Dev (Love) │
  │  Understanding the Linux Kernel (Bovet & Cesati)                    │
  │  Writing Windows WDM Device Drivers (Cant)                          │
  │  Developing Drivers with WDF (Orwick & Smith)                       │
  │  macOS and iOS Internals Vol. II — Kernel Mode (Levin)              │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── online / official ────────────────────────────────────────────────┐
  │  Linux: Documentation/driver-api/ · drivers/ source tree            │
  │  Windows: WDK docs  │  Apple: DriverKit docs  │  FreeBSD Arch HB   │
  │  Rust for Linux: rust-for-linux.com                                 │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── mailing lists ────────────────────────────────────────────────────┐
  │  LKML  │  linux-pci  │  linux-usb  │  netdev  (all on vger.kernel)  │
  └──────────────────────────────────────────────────────────────────────┘
```

### Books
- *Linux Device Drivers, 3rd ed.* (LDD3) — Corbet, Rubini, Kroah-Hartman. Dated but classic.
- *Linux Kernel Development* — Robert Love. Companion to LDD3.
- *Understanding the Linux Kernel* — Bovet & Cesati.
- *Writing Windows WDM Device Drivers* — Chris Cant.
- *Developing Drivers with WDF* — Penny Orwick, Guy Smith.
- *macOS and iOS Internals, Vol. II: Kernel Mode* — Jonathan Levin.

### Online / official
- **Linux kernel docs** — `Documentation/driver-api/`, `Documentation/process/`
- **Linux kernel source** — `drivers/` subtree
- **Microsoft Driver Documentation** — Windows Driver Kit (WDK) docs
- **Apple Developer — DriverKit** — `https://developer.apple.com/documentation/driverkit`
- **FreeBSD Architecture Handbook** — newbus, GEOM
- **Rust for Linux** — `https://rust-for-linux.com/`

### Mailing lists / channels
- LKML — Linux Kernel Mailing List (`vger.kernel.org`)
- `linux-pci`, `linux-usb`, `netdev` subsystem lists

---

## Lessons

### What is in this section

```text
  Twelve exercises plus a lab file (driver_labs.md); grouped by focus.

  ┌─── module basics ────────────────────────────────────────────────────┐
  │  1 hello-world (load/unload)  2 char driver (cdev)  3 ioctl design  │
  └─────────────────────────────────────────────────────────────────────┘

  ┌─── kernel interfaces ────────────────────────────────────────────────┐
  │  4 sysfs / debugfs  │  5 interrupt handler  │  6 DMA basics         │
  └─────────────────────────────────────────────────────────────────────┘

  ┌─── bus-specific drivers ─────────────────────────────────────────────┐
  │  7 PCI driver  │  8 USB driver  │  9 network driver (NAPI)          │
  └─────────────────────────────────────────────────────────────────────┘

  ┌─── beyond the standard Linux model ──────────────────────────────────┐
  │  10 userspace driver (UIO / VFIO)  │  11 Rust-for-Linux  │  12 KMDF │
  └─────────────────────────────────────────────────────────────────────┘
```

### Dedicated lesson modules

| Topic | File |
|-------|------|
| Driver interactive labs | [Device Drivers interactive labs](driver_labs.md) — Linux char device, udev rules, Device Tree overlay |

---

1. **Kernel module hello-world** — load/unload, dmesg, params (`module_param`).
2. **Character driver** — register a `cdev`, implement `open/read/write/release`.
3. **ioctl design** — define commands, structs, copy_to/from_user.
4. **Sysfs & debugfs** — expose attributes; the right place for what.
5. **Interrupt handler** — request_irq, top-half vs bottom-half (tasklet/workqueue).
6. **DMA basics** — coherent vs streaming mappings, IOMMU awareness.
7. **PCI driver** — `pci_driver` boilerplate, BAR mapping, MSI/MSI-X.
8. **USB driver** — `usb_driver`, URBs, endpoint types.
9. **Network driver** — `net_device`, NAPI, ring buffers.
10. **Userspace driver** — UIO or VFIO for direct device access.
11. **Rust-for-Linux driver** — port a small module from C to Rust.
12. **Windows KMDF intro** — sample driver, INF file, install.

### Suggested external
- LWN.net article series — "Driver porting", "An updated kernel API"
- Greg Kroah-Hartman talks (FOSDEM/LPC)
- The Eudyptula Challenge (archived but invaluable)

---

## Languages

### What is in this section

```text
  Six languages in this section; split by where the driver code runs.

  ┌────────────────────────── kernel space ──────────────────────────────┐
  │  C (Linux · BSD · Windows · macOS) — strict subset, no libc         │
  │  C++ restricted (Windows KMDF, macOS IOKit)                         │
  │  Rust (Linux · Windows experimental)  │  Obj-C/C++ (macOS IOKit)   │
  └────────────────────────────────────────────────────────────────────┘

  ┌────────────────────────── user space ────────────────────────────────┐
  │  C++ (macOS/iOS DriverKit — *.dext bundles; Swift has thin wrappers) │
  │  Python (libusb · pyudev — prototyping; not production drivers)     │
  └────────────────────────────────────────────────────────────────────┘
```

| Language | OS | Notes |
|----------|----|----|
| C (kernel dialect) | Linux, BSD, Windows (with KMDF/WDM), macOS (XNU) | The default — strict subset, no libc |
| C++ (restricted) | Windows KMDF, macOS IOKit (legacy) | No exceptions, no STL in many contexts |
| Rust | Linux (Rust-for-Linux), Windows (experimental) | `no_std`, async limited; growing fast |
| C++ (DriverKit API) | macOS / iOS (DriverKit) | User-space drivers via `*.dext` bundles; Swift has thin wrappers only |
| Objective-C / C++ | macOS IOKit (legacy kexts) | Mostly being replaced by DriverKit |
| Python | Userspace via libusb, pyudev | Prototyping, not actual kernel drivers |

### Kernel C dialect notes
- No standard library — use kernel APIs (`kmalloc`, `printk`, `copy_to_user`).
- No floating point (without explicit `kernel_fpu_begin`/`end`).
- Strict locking discipline — sleep vs atomic contexts.
- GPL symbol export (`EXPORT_SYMBOL_GPL`) gates a large API surface.

### Build systems
- Linux: out-of-tree Makefile or DKMS
- Windows: WDK + Visual Studio + `inf2cat`/`signtool`
- macOS: Xcode + DriverKit SDK

### Related
- Kernel internals → [OS Kernel › Languages](../05_OS_Kernel/README.md#languages)
- Bus protocols → [Circuit Board › Protocols](../01_Circuit_Board/README.md#protocols)

---

## Manual Pages

### What is in this section

```text
  Commands in this section, grouped by OS.

  ┌────────────────────────────────── Linux ──────────────────────────────┐
  │  modules: lsmod · modinfo · modprobe · insmod · rmmod · depmod · dkms │
  │  events:  udevadm · dmesg  │  config: modules-load.d               │
  │  hardware: ethtool · nvidia-smi · rocm-smi                           │
  └───────────────────────────────────────────────────────────────────────┘

  ┌──────── macOS ─────────────────────────┐  ┌──── Windows ──────────────────────┐
  │  kextstat · kmutil                     │  │  pnputil · driverquery            │
  │  systemextensionsctl · pluginkit       │  │  sc query type=driver · verifier  │
  └────────────────────────────────────────┘  └───────────────────────────────────┘

  ┌──────── Linux (additional) ───────────────────────────────────────────┐
  │  pyudev (Python bindings for Linux udev — Linux-only)                 │
  └───────────────────────────────────────────────────────────────────────┘

  ┌──────────────────────── cross-platform ───────────────────────────────┐
  │  libusb (userspace USB access, wraps each OS's USB stack)             │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated man page references

| Topic | File |
|-------|------|
| Device & driver management | [Device & Driver Management Commands](device_commands.md) — lspci, lsusb, lsblk, modprobe, udevadm, dkms |

---

### Linux
| Command | Section | Purpose |
|---------|---------|---------|
| `lsmod` | 8 | List loaded kernel modules |
| `modinfo` | 8 | Module metadata (author, license, params) |
| `modprobe` | 8 | Load module + dependencies |
| `insmod` | 8 | Load a single module file |
| `rmmod` | 8 | Unload module |
| `depmod` | 8 | Generate module dependency map |
| `udevadm` | 8 | Query/monitor udev events |
| `dmesg` | 1 | Kernel ring buffer — driver bind/unbind |
| `modules-load.d` | 5 | Boot-time module list |
| `dkms` | 8 | Out-of-tree module rebuild on kernel upgrade |
| `ethtool` | 8 | NIC driver knobs (offloads, ring sizes) |
| `nvidia-smi` | 1 | NVIDIA driver/runtime monitor |
| `rocm-smi` | 1 | AMD ROCm equivalent |

### macOS
| Command | Purpose |
|---------|---------|
| `kextstat` | List loaded kernel extensions (deprecated path) |
| `kmutil` | Modern kext / driver extension management |
| `systemextensionsctl` | Manage system extensions (DriverKit) |
| `pluginkit` | List installed extensions |

### Windows
| Command | Purpose |
|---------|---------|
| `pnputil` | Add/remove drivers, list installed |
| `driverquery` | List installed drivers |
| `devcon` (legacy) / `pnputil` | Device control |
| `sc query type=driver` | Service Control Manager view of drivers |
| `verifier` | Driver Verifier — runtime checks |

### Linux (additional)
- `pyudev` — Python bindings for Linux udev (Linux-only; wraps the udev C library)

### Cross-platform
- `libusb` — userspace USB access (wraps each OS's USB stack)

---

## Topics

### What is in this section

```text
  Four groups: what a driver IS, how it talks to hardware, which
  framework it runs in, and how to debug it when it goes wrong.

  ┌─── driver classes ───────────────────────────────────────────────────┐
  │  char · block · network · USB · PCI/PCIe · platform · GPU (DRM/KMS) │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── hardware access mechanics ────────────────────────────────────────┐
  │  MMIO (ioremap)  │  PIO (inb/outb, x86)  │  DMA (coherent+streaming)│
  │  IOMMU (VT-d · AMD-Vi · SMMU)  │  IRQ (top-half · NAPI · threaded) │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── frameworks ───────────────────────────────────────────────────────┐
  │  Linux: struct device/bus/driver  │  Windows: WDM → WDF (KMDF|UMDF) │
  │  macOS: IOKit (legacy) → DriverKit│  userspace: VFIO · UIO · DPDK  │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── debugging & reliability ──────────────────────────────────────────┐
  │  Linux: lockdep · KASAN · KCSAN · kgdb/kdb                          │
  │  Windows: Driver Verifier · WinDbg (KD)                             │
  └──────────────────────────────────────────────────────────────────────┘
```

### Dedicated Topic Deep Dives

| File | Covers |
|------|--------|
| [Linux Driver Model](driver_model.md) | Bus/device/driver binding, DT/ACPI, udev |

### Driver classes
- **Character drivers** — byte-stream devices (`/dev/tty*`, `/dev/random`)
- **Block drivers** — random-access storage (`/dev/sd*`, `/dev/nvme*`)
- **Network drivers** — packet I/O (`net_device`, NAPI, XDP)
- **USB drivers** — endpoint-based, URB-driven
- **PCI / PCIe drivers** — BAR mapping, MSI/MSI-X, DMA
- **Platform drivers** — Device-Tree / ACPI-described non-discoverable hardware
- **GPU drivers** — DRM/KMS on Linux, WDDM on Windows, IOAccelerator on macOS

### Mechanics
- **MMIO** — memory-mapped I/O regions; `ioremap` / `iounmap`
- **PIO** — port I/O (legacy x86): `inb`/`outb`
- **DMA** — Direct Memory Access; coherent vs streaming; scatter-gather
- **IOMMU** — VT-d, AMD-Vi, SMMU; per-device address spaces
- **Interrupts** — IRQ assignment, MSI/MSI-X, top-half/bottom-half, threaded IRQs
- **Polling vs interrupt** — tradeoffs; NAPI as the hybrid

### Frameworks & models
- **Linux device model** — `struct device`, `struct bus_type`, `struct driver`
- **Windows WDM / KMDF / UMDF** — one legacy model and two sibling frameworks
- **macOS IOKit (legacy) vs DriverKit (current)**
- **Userspace drivers** — VFIO, UIO, libusb, DPDK, SPDK

### Reliability & debugging
- **Lockdep, KASAN, KCSAN** — Linux kernel sanitizers
- **Driver Verifier** — Windows runtime stressor
- **kgdb, kdb** — kernel debugging on Linux
- **WinDbg** — Windows kernel debugging (KD)
- **Panic / oops analysis** — backtrace, decode_stacktrace.sh

### Security cross-link
- Vulnerable drivers (BYOVD) → [Security › Topics](../14_Security/README.md#topics)
- Driver signing bypass / rootkits → [Security › Topics](../14_Security/README.md#topics)

---

## Protocols

### What is in this section

```text
  Three groups: Linux kernel ABIs, cross-OS frameworks, userspace I/O.

  ┌───────────────── Linux subsystem ABIs ──────────────────────────────┐
  │  char: /dev/* + ioctl  │  block: /dev/sd*  │  net: sockets+netlink │
  │  USB: /dev/bus/usb     │  PCI: sysfs       │  platform: DT/ACPI    │
  │  input: /dev/input     │  DRM/KMS: /dev/dri│  V4L2 · ALSA          │
  └─────────────────────────────────────────────────────────────────────┘

  ┌───────────────── driver frameworks ─────────────────────────────────┐
  │  Windows: WDM (legacy) → WDF [ KMDF (kernel) | UMDF (user) ]       │
  │  macOS: IOKit (deprecated) → DriverKit                             │
  │  BSD: newbus (FreeBSD) · autoconf (NetBSD/OpenBSD)                 │
  └─────────────────────────────────────────────────────────────────────┘

  ┌───────────────── userspace I/O ─────────────────────────────────────┐
  │  VFIO (IOMMU passthrough)  │  UIO (memory-mapped)  │  libusb        │
  │  DPDK PMD (NIC poll-mode)  │  SPDK (NVMe poll-mode)                │
  └─────────────────────────────────────────────────────────────────────┘
```

Not wire protocols — driver↔OS contracts and stable userspace ABIs.

### Linux subsystem APIs
| Subsystem | Driver registration | User interface |
|-----------|--------------------|-----------------|
| Character | `cdev_add` / `register_chrdev` | `/dev/*`, ioctl |
| Block | `add_disk`, `blk_mq_*` | `/dev/sd*`, syscalls |
| Network | `register_netdev` | sockets, netlink |
| USB | `usb_register` | `/dev/bus/usb`, sysfs |
| PCI | `pci_register_driver` | sysfs, /proc/bus/pci |
| Platform | `platform_driver_register` | DT/ACPI matched |
| Input | `input_register_device` | `/dev/input/event*` |
| DRM/KMS | `drm_dev_register` | `/dev/dri/*` |
| V4L2 | `video_register_device` | `/dev/video*` |
| ALSA | `snd_card_register` | `/dev/snd/*` |

### Driver-to-OS frameworks
| Framework | OS | Status |
|-----------|----|----|
| WDM (Windows Driver Model) | Windows | Legacy |
| KMDF (Kernel-Mode Driver Framework) | Windows | Active |
| UMDF (User-Mode Driver Framework) | Windows | Active |
| IOKit | macOS (kexts) | Deprecated |
| DriverKit | macOS / iOS | Active |
| newbus | FreeBSD | Active |
| autoconf | NetBSD / OpenBSD | Active |

### Userspace I/O APIs
- **VFIO** — IOMMU-protected device passthrough (KVM, DPDK)
- **UIO** — simple userspace I/O for memory-mapped devices
- **libusb** — cross-platform USB access
- **DPDK PMD** — poll-mode NIC drivers in userspace
- **SPDK** — NVMe poll-mode in userspace

### Conventions
- **ioctl numbering** — Linux `_IOR/_IOW/_IOWR` macros, magic numbers
- **netlink** — generic netlink families for config/events
- **sysfs / debugfs** — attribute conventions: one value per file
- **udev rules** — `KERNEL==`, `SUBSYSTEM==`, `ATTRS{vendor}==`
