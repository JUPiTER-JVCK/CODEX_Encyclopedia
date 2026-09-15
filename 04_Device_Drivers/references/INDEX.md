# Device Drivers — References

## What is in this section

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

## Books
- *Linux Device Drivers, 3rd ed.* (LDD3) — Corbet, Rubini, Kroah-Hartman. Dated but classic.
- *Linux Kernel Development* — Robert Love. Companion to LDD3.
- *Understanding the Linux Kernel* — Bovet & Cesati.
- *Writing Windows WDM Device Drivers* — Chris Cant.
- *Developing Drivers with WDF* — Penny Orwick, Guy Smith.
- *macOS and iOS Internals, Vol. II: Kernel Mode* — Jonathan Levin.

## Online / official
- **Linux kernel docs** — `Documentation/driver-api/`, `Documentation/process/`
- **Linux kernel source** — `drivers/` subtree
- **Microsoft Driver Documentation** — Windows Driver Kit (WDK) docs
- **Apple Developer — DriverKit** — `https://developer.apple.com/documentation/driverkit`
- **FreeBSD Architecture Handbook** — newbus, GEOM
- **Rust for Linux** — `https://rust-for-linux.com/`

## Mailing lists / channels
- LKML — Linux Kernel Mailing List (`vger.kernel.org`)
- `linux-pci`, `linux-usb`, `netdev` subsystem lists
