# Circuit Board — Manual Pages

Hardware enumeration & inspection tools — mostly Linux, with macOS equivalents.

## Asking the machine what it is made of

```text
  Every command here answers the same question at a different level of the
  board. Most read back what firmware and the kernel already discovered; the
  last two go and ask the hardware themselves.

  the whole board        lshw · hwinfo          system_profiler   (macOS)
  │                      dmidecode ── SMBIOS/DMI: board, BIOS, memory
  │
  ├─ the buses           lspci   PCIe tree, and which driver claimed what
  │                      lsusb   USB topology
  │                      ioreg   the IORegistry tree          (macOS)
  │
  ├─ the parts on them   lscpu · lsmem · lsblk
  │
  ├─ what happened at boot
  │                      dmesg   the kernel's own account of the above
  │
  └─ and two that transact rather than report:
                         i2cdetect   drives the bus, addressing every slot
                         spi-tools   talks to /dev/spidev* directly
                         both can wedge a live device — read their warnings

  On an SBC the same job needs board-specific tools, because the pins are
  not on any standard bus: pinctrl (RPi GPIO, replacing WiringPi's gpio)
  and vcgencmd (VideoCore temperature, voltage, clocks).

  Who is driving each of these devices is 04 Device Drivers.
```

| Command | Section | Purpose |
|---------|---------|---------|
| `lspci` | 8 | List PCI/PCIe devices and their drivers |
| `lsusb` | 8 | List USB devices and topology |
| `lshw` | 1 | Comprehensive hardware listing (CPU, memory, buses) |
| `dmidecode` | 8 | Dump SMBIOS/DMI tables: motherboard, memory modules, BIOS info (firmware-reported, not read from the DIMM's SPD) |
| `hwinfo` | 8 | openSUSE-style hardware probe |
| `dmesg` | 1 | Kernel ring buffer — boot-time hardware messages |
| `lsblk` | 8 | List block devices and partitions |
| `lscpu` | 1 | CPU architecture details (cores, cache, flags) |
| `lsmem` | 1 | Memory range information |
| `i2cdetect` | 8 | Scan for devices on I²C bus (i2c-tools) |
| `spi-tools` | 1 | Userspace SPI access via `/dev/spidev*` |
| `system_profiler` | 8 | macOS — equivalent to `lshw` (`SPHardwareDataType`) |
| `ioreg` | 8 | macOS — IORegistry tree of attached devices |

## SBC / embedded
| Command | Purpose |
|---------|---------|
| `gpio` (WiringPi) | Raspberry Pi GPIO control (deprecated; use `pinctrl`) |
| `pinctrl` | RPi GPIO control (modern) |
| `vcgencmd` | Raspberry Pi VideoCore GPU/temp/voltage queries |
