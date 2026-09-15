# Circuit Board — Protocols

Physical/electrical bus protocols that live on the board.

## The buses, by shape

```text
  What distinguishes these is topology and clocking, not speed — and the
  slow ones at the bottom differ from each other as much as from the rest.

  point-to-point, serial, lanes        the fast ones. A link is two devices
    PCIe 1.0–6.0 ──▶ NVMe (a command set, not a bus)
    SATA · Thunderbolt (tunnels PCIe + DisplayPort over USB-C)
    HDMI (TMDS/FRL) · DisplayPort (Main Link)
    SGMII ── MAC ◀──▶ PHY, serialised          ──▶ 09 Network Physical

  parallel, clocked, wide              memory, and the MAC-to-PHY link
    DDR4 · DDR5 (JESD79-4/5) · LPDDR4/5 (JESD209-4/5)
    MII · RGMII — four or eight data lines plus a clock, not lanes

  a tree with one host                 enumeration, addresses handed out
    USB 2.0 / 3.x / 4

  the slow ones, everywhere on the board — and no two share a topology:
    I²C ──▶ SMBus     truly multi-drop: two wires, addresses on the bus
    CAN (ISO 11898)   multi-drop and multi-master, with arbitration
    SPI               a shared clock and data, one chip-select per device
    UART / RS-232     point-to-point, and no clock at all
    JTAG (1149.1)     a daisy chain — out of one device, into the next

  The decoder catalog for all of these, as a logic analyzer sees them, is
  in embedded_bus_protocols_lookup.md in this folder.
```

| Protocol | Spec | Type | Status |
|----------|------|------|--------|
| PCIe (1.0 – 6.0) | PCI-SIG Base Spec | Serial, point-to-point, lanes | Active |
| DDR4 / DDR5 | JEDEC JESD79-4 / JESD79-5 | Parallel memory bus | Active |
| LPDDR4/5 | JEDEC JESD209-4/5 | Low-power memory | Active |
| USB 2.0 / 3.x / 4 | USB-IF | Serial, host-centric tree | Active |
| Thunderbolt 3 / 4 / 5 | Intel + USB-IF | Tunnels PCIe + DisplayPort over USB-C | Active |
| SATA (I/II/III) | SATA-IO | Serial storage | Legacy/active |
| NVMe (over PCIe) | NVM Express | Storage command protocol | Active |
| SPI | de facto (Motorola) | 4-wire serial, master-slave | Active |
| I²C | NXP/Philips | 2-wire, multi-drop | Active |
| UART / RS-232 | ANSI/TIA-232-F | Asynchronous serial | Legacy/active |
| CAN bus | ISO 11898 | Multi-master, automotive | Active |
| JTAG / Boundary scan | IEEE 1149.1 | Test & debug access | Active |
| SMBus | SBS-IF | I²C-derived, system management | Active |
| HDMI | HDMI Forum | Video + audio (TMDS / FRL) | Active |
| DisplayPort | VESA | Video + audio (Main Link) | Active |
| Ethernet PHY (MII/RGMII/SGMII) | IEEE 802.3 | MAC ↔ PHY interface | Active |

## Cross-links
- Wire-level Ethernet → [09_Network_Physical/protocols](../../Network/09_Network_Physical/protocols/INDEX.md)
- RF interconnects → [16_RF_Wireless/protocols](../../16_RF_Wireless/protocols/INDEX.md)
