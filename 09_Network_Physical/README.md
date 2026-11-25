# 09 — Network Physical (OSI L1)

> Bits on the medium. Copper twisted pair, fiber strands, coax, RF in the air.
> Modulation, line coding, signal levels, connectors, distance limits.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  10  Network Data Link (L2)                  │
└───────────────────────┬──────────────────────┘
                        │  encoded bits on copper, fiber, RF
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  09  Network Physical (L1)        ◀── here   ┃
┃      bits on the medium · modulation         ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  electrical signals, serial & parallel buses
┌───────────────────────┴──────────────────────┐
│  01  Circuit Board                           │
└──────────────────────────────────────────────┘
```

## At a glance

| Field | Value |
|-------|-------|
| OSI layer | 1 (Physical) |
| Description | Encoding bits onto a physical medium |
| Protocols | 802.3 PHY (Ethernet), 802.11 PHY (Wi-Fi), DOCSIS, GPON, SONET/SDH |
| Medium | Copper (Cat5e/6/6a/7/8), MMF/SMF fiber, coax, free-space RF/optics |
| Example | NIC encodes bits onto Cat6 with 1000BASE-T 4D-PAM5 |
| Adjacent | ↓ [01_Circuit_Board](../01_Circuit_Board/), ↑ [10_Network_DataLink](../10_Network_DataLink/) |

## What lives here

- **Wired** — 10/100/1000/2.5G/5G/10G/25G/40G/100G/400G/800G Ethernet PHYs
- **Fiber** — SR/LR/ER/ZR optics, transceiver form factors (SFP/SFP+/QSFP/OSFP)
- **Wireless** — see [16_RF_Wireless](../16_RF_Wireless/) for RF specifics
- **Access tech** — DSL, DOCSIS (cable), GPON / XGS-PON / 10G-EPON, 5G NR PHY
- **Backbone** — SONET/SDH, OTN, DWDM
- **Encoding / modulation** — Manchester, 4B/5B, 8B/10B, 64B/66B, PAM4, QAM, OFDM

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | IEEE 802 standards, ITU-T G-series |
| [Lessons](#lessons) | [Interactive labs](physical_labs.md) | cable test, fiber inspection, spectrum basics |
| [Languages](#languages) | — | not really a language layer |
| [Manual Pages](#manual-pages) | — | `ethtool`, `iwlist`, `iperf3` |
| [Topics](#topics) | — | cabling, modulation, PMD/PCS, autoneg |
| [Protocols](#protocols) | — | PHY standards table |

## Cross-references
- Wire-level RF / antennas → [16_RF_Wireless](../16_RF_Wireless/)
- MAC/Ethernet framing → [10_Network_DataLink](../10_Network_DataLink/)
- NIC drivers → [04_Device_Drivers](../04_Device_Drivers/)

---

## References

### What is in this section

```text
  Physical layer reference sources: specs, books, and vendor guides.

  ┌─── standards ─────────────────────────────────────────────────────────┐
  │  IEEE 802.3 (Ethernet) · IEEE 802.11 (Wi-Fi HT/VHT/HE/EHT)          │
  │  ITU-T G.984/G.987/G.9807 · G.707/G.709 · DOCSIS 3.x                │
  │  3GPP TS 38.2xx (5G NR PHY) · TIA/EIA-568 (structured cabling)       │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── books ─────────────────────────────────────────────────────────────┐
  │  Ethernet: The Definitive Guide (Spurgeon, Zimmerman)                 │
  │  Optical Networks: A Practical Perspective (Ramaswami et al.)         │
  │  Fiber Optic Communications (Palais) · Wi-Fi 6/7 in Depth            │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── online ────────────────────────────────────────────────────────────┐
  │  ieee802.org · cabling-installation.com · flukenetworks.com          │
  └───────────────────────────────────────────────────────────────────────┘
```

### Standards
- **IEEE 802.3** — Ethernet (the whole multi-thousand-page family)
- **IEEE 802.11** — Wi-Fi PHY (HT/VHT/HE/EHT for n/ac/ax/be)
- **ITU-T G.984 / G.987 / G.9807** — GPON / XG-PON / XGS-PON
- **ITU-T G.707 / G.709** — SDH / OTN
- **CableLabs DOCSIS 3.0 / 3.1 / 4.0**
- **3GPP TS 38.2xx** — 5G NR physical layer
- **TIA/EIA-568** — structured cabling

### Books
- *Ethernet: The Definitive Guide* — Charles Spurgeon, Joann Zimmerman
- *Wi-Fi 6 / Wi-Fi 7 in Depth* (various)
- *Optical Networks: A Practical Perspective* — Ramaswami, Sivarajan, Sasaki
- *Fiber Optic Communications* — Joseph Palais

### Online
- ieee802.org standards drafts (some free, others paywalled)
- cabling-installation.com — practical guides
- flukenetworks.com / viavi.com — test equipment vendors

---

## Lessons

### What is in this section

```text
  Physical layer hands-on: cable testing, diagnostics, and spectrum.

  ┌─── dedicated module ──────────────────────────────────────────────────┐
  │  physical_labs.md (cable testing · ethtool · Wi-Fi signal survey)    │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── lesson ladder ─────────────────────────────────────────────────────┐
  │  1–4: Cat6 termination · cable testing · fiber inspection · SFP EEPROM │
  │  5–8: spectrum sweep · autoneg tuning · fiber link budget · 802.3 PCS │
  │  9–10: WAN circuit terminology · 5G NR primer                        │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated Lesson Modules

| File | Covers |
|------|--------|
| [Network Physical — Interactive Labs](physical_labs.md) | Cable testing, ethtool diagnostics, Wi-Fi signal survey |

### Lesson ladder

1. **Terminate a Cat6 cable** — T568A vs T568B, RJ45 crimp, certify.
2. **Test cable with a tester** — Fluke or budget equivalent: length, wiremap, NEXT.
3. **Inspect fiber connectors** — clean with proper wipes, scope for end-face contamination.
4. **Identify transceivers** — read SFP/SFP+ EEPROM with `ethtool -m`.
5. **Spectrum sweep (wireless)** — see [RF / Wireless › Lessons](../16_RF_Wireless/README.md#lessons).
6. **Tune autoneg** — observe link bring-up; force speed/duplex; diagnose mismatch.
7. **Link budget for fiber** — calculate dB budget from spec sheets.
8. **Read 802.3 PCS** — understand 64B/66B, scrambling, lane bonding for 100G.
9. **WAN circuit terminology** — DS-1, T-3, OC-3, OC-48 (legacy literacy).
10. **5G NR primer** — slot structure, numerology, BWPs, beamforming.

### Lab equipment / sims
- Cable tester (Fluke MicroScanner, Klein VDV, Pockethernet)
- Fiber inspection scope, OTDR
- Spectrum analyzer (RTL-SDR for low-cost intro — see [16_RF_Wireless](../16_RF_Wireless/))

---

## Languages

### What is in this section

```text
  Encoding and modulation — the "language" of the physical layer.

  ┌─── line codes (digital) ──────────────────────────────────────────────┐
  │  NRZ/NRZI · Manchester · 4B/5B+MLT-3 · 8B/10B · 64B/66B             │
  │  128B/130B · 256B/257B · PAM4 (50G+/GDDR6X) · 4D-PAM5 (1000BASE-T)  │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── modulation (RF & fiber) ───────────────────────────────────────────┐
  │  OOK · BPSK/QPSK (satellite/802.11) · QAM-16/64/256/1024/4096       │
  │  OFDM/OFDMA (802.11ax/be · LTE · 5G NR) · GMSK (GSM) · FM/FSK      │
  └───────────────────────────────────────────────────────────────────────┘
```

Not a software-language layer. The "language" here is **encoding and modulation**.

### Line codes (digital)
| Code | Used by |
|------|---------|
| NRZ / NRZI | RS-232, USB low/full-speed |
| Manchester | 10BASE-T Ethernet |
| 4B/5B + MLT-3 | 100BASE-TX |
| 8B/10B | 1000BASE-X, PCIe Gen1/2, SATA, USB 3.x |
| 64B/66B | 10G/40G/100G Ethernet PCS |
| 128B/130B | PCIe Gen3 |
| 256B/257B (RS-FEC) | 100G/400G |
| PAM4 | 50G/100G per-lane (Ethernet, GDDR6X) |
| 4D-PAM5 | 1000BASE-T |

### Modulation (RF / fiber)
| Modulation | Used by |
|-----------|---------|
| OOK (on-off keying) | Simple optical, basic IR |
| BPSK / QPSK | satellite, 802.11 lowest rates |
| QAM-16 / 64 / 256 / 1024 / 4096 | Wi-Fi, DOCSIS, cellular |
| OFDM / OFDMA | 802.11a/g/n/ac/ax/be, LTE, 5G, DOCSIS 3.1 |
| GMSK | GSM |
| FM / FSK | analog/legacy |

### Where these are described
- IEEE 802 PHY clauses
- ITU-T G-series, 3GPP TS 38.211 for 5G NR
- DSP textbooks (see [RF / Wireless › References](../16_RF_Wireless/README.md#references))

---

## Manual Pages

### What is in this section

```text
  Commands for wired and wireless physical-layer diagnostics.

  ┌─── wired diagnostics ─────────────────────────────────────────────────┐
  │  ethtool (link status · SFP EEPROM · NIC stats · FEC mode)           │
  │  ip link · mii-tool · iperf3 · mtr · ping · tcpdump                  │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── wireless & cross-platform ─────────────────────────────────────────┐
  │  iw · iwconfig (legacy) · iwlist · wpa_supplicant · nmcli             │
  │  macOS: ifconfig · networksetup · airport                             │
  │  Windows: Get-NetAdapter · netsh wlan show interfaces                 │
  └───────────────────────────────────────────────────────────────────────┘
```

| Command | Purpose |
|---------|---------|
| `ethtool eth0` | Link status, speed, duplex, autoneg |
| `ethtool -m eth0` | Read SFP/SFP+ transceiver EEPROM |
| `ethtool -S eth0` | NIC stats (errors, drops, FEC) |
| `ethtool --show-fec eth0` | FEC mode (RS-FEC, Firecode) |
| `ip link show` | List interfaces & operstate |
| `mii-tool` | Older PHY query utility |
| `iwconfig` (legacy) / `iw dev` | Wireless interface settings |
| `iwlist wlan0 scan` | Scan visible SSIDs/channels |
| `iw dev wlan0 station dump` | Connected station details |
| `wpa_supplicant` / `nmcli` | Wireless client mgmt |
| `iperf3` | End-to-end throughput test (also useful at L4/L7) |
| `mtr`, `ping` | Reachability (cross-layer) |
| `tcpdump -i eth0 -w cap.pcap` | Capture from PHY/MAC |
| `vconfig` (legacy) / `ip link add type vlan` | VLAN tagging (L2 boundary) |

### macOS
- `ifconfig`, `networksetup`, `airport` (legacy CLI: `/System/Library/PrivateFrameworks/Apple80211.framework/.../airport`)
- System Information → Network → physical link reports

### Windows
- `Get-NetAdapter`, `Get-NetAdapterAdvancedProperty`, `netsh wlan show interfaces`

---

## Topics

### What is in this section

```text
  Physical layer topics: media, optical, PHY sublayers, power, and access tech.

  ┌─── physical media ────────────────────────────────────────────────────┐
  │  Twisted pair (Cat5e–Cat8 UTP/STP) · Coax (RG-6/LMR)                │
  │  Fiber: OS1/OS2 SMF · OM1–OM5 MMF · LC/SC/MPO · Twinax/DAC/AOC     │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── optical & transceivers ────────────────────────────────────────────┐
  │  SFP–OSFP families · SR/LR/ER/ZR reach types · DWDM backbone        │
  │  PCS/PMA/PMD sublayers · MII/SGMII/XGMII MAC↔PHY interfaces         │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── link bring-up, power & access ─────────────────────────────────────┐
  │  Autoneg (802.3 Cl.28) · FEC negotiation · duplex mismatch           │
  │  PoE/PoE+/PoE++ (802.3af/at/bt) · EEE (802.3az)                     │
  │  DOCSIS · xDSL · GPON/XGS-PON/25G-PON · 5G NR radio access         │
  └───────────────────────────────────────────────────────────────────────┘
```

### Wired media
- **Twisted pair** — Cat5e, Cat6, Cat6a, Cat7, Cat8; lengths, shielding (UTP/FTP/STP).
- **Coax** — RG-6, RG-59 (HFC); RG-58, LMR-400 (RF).
- **Fiber** — Single-mode (OS1/OS2), multi-mode (OM1–OM5); LC/SC/MPO connectors.
- **Twinax / DAC** — direct-attach copper for short data-center runs.
- **AOC** — active optical cables.

### Wireless overview (PHY only — see [16_RF_Wireless](../16_RF_Wireless/) for radio)
- **Wi-Fi PHY** — 2.4 / 5 / 6 GHz bands, channel widths 20/40/80/160/320 MHz.
- **Cellular PHY** — LTE OFDMA, 5G NR with sub-6 and mmWave.
- **BT PHY** — 1M, 2M, Coded (BLE long range).

### Optical
- **Transceiver families** — SFP (1G), SFP+ (10G), SFP28 (25G), QSFP+ (40G), QSFP28 (100G), QSFP-DD / OSFP (400/800G).
- **Reach types** — SR (multi-mode short), LR (single-mode long), ER, ZR, ZR+.
- **DWDM** — dense wavelength division multiplexing on backbone.

### PCS / PMA / PMD
- **PMD** — physical medium dependent (the optics or copper interface).
- **PMA** — physical medium attachment (lane gearbox).
- **PCS** — physical coding sublayer (line code, FEC, scrambler).
- **MII / RGMII / SGMII / XGMII / XLAUI** — MAC ↔ PHY interfaces.

### Autoneg & link bring-up
- 802.3 Clause 28 autoneg (BASE-T).
- Forced speed/duplex pitfalls; duplex mismatch CRC errors.
- FEC negotiation (RS-FEC mandatory at 100G+).

### Power
- **PoE / PoE+ / PoE++** — IEEE 802.3af/at/bt; budgets, classes.
- **EEE** — Energy-Efficient Ethernet (802.3az).

### Access tech
- **DOCSIS** — cable broadband over HFC.
- **xDSL** — ADSL/VDSL/G.fast.
- **GPON / XGS-PON / 25G-PON** — fiber-to-the-premise.
- **5G NR** — radio access network basics.

---

## Protocols

### What is in this section

```text
  PHY-layer standards: Ethernet, Wi-Fi, WAN/cellular, and transceiver MSAs.

  ┌─── Ethernet PHY (IEEE 802.3) ─────────────────────────────────────────┐
  │  10BASE-T through 800GBASE-DR8 · copper/MMF/SMF · DAC/AOC            │
  │  FEC: Firecode (25G) · RS-FEC (100G+) · PAM4 per-lane signalling     │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── wireless & WAN PHY ────────────────────────────────────────────────┐
  │  Wi-Fi 4/5/6/7 (802.11n/ac/ax/be) · 2.4 / 5 / 6 GHz · OFDMA       │
  │  5G NR · LTE · DOCSIS 3.x · GPON/XGS-PON · SDH/OTN · xDSL          │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── transceiver MSAs ──────────────────────────────────────────────────┐
  │  SFP/SFP+/SFP28/SFP56 · QSFP+/QSFP28/QSFP56/QSFP-DD · OSFP/CFP    │
  └───────────────────────────────────────────────────────────────────────┘
```

### Ethernet PHY standards (IEEE 802.3, selected)
| Speed | Standard | Medium | Reach |
|-------|----------|--------|-------|
| 10 Mb/s | 10BASE-T | Cat3 UTP | 100 m |
| 100 Mb/s | 100BASE-TX | Cat5 UTP | 100 m |
| 1 Gb/s | 1000BASE-T | Cat5e UTP | 100 m |
| 1 Gb/s | 1000BASE-SX/LX | MMF/SMF | 550 m / 5–10 km |
| 2.5 / 5 Gb/s | 2.5GBASE-T / 5GBASE-T | Cat5e/6 | 100 m |
| 10 Gb/s | 10GBASE-T | Cat6a | 100 m |
| 10 Gb/s | 10GBASE-SR / -LR | MMF / SMF | 300 m / 10 km |
| 25 Gb/s | 25GBASE-SR / -LR | MMF / SMF | 100 m / 10 km |
| 40 Gb/s | 40GBASE-SR4 / -LR4 | MMF / SMF | 150 m / 10 km |
| 100 Gb/s | 100GBASE-SR4 / -LR4 / -CR4 | MMF / SMF / DAC | varies |
| 400 Gb/s | 400GBASE-DR4 / -FR4 / -LR4 | SMF (4×100G PAM4) | 500 m / 2 km / 10 km |
| 800 Gb/s | 800GBASE-DR8 / -FR4 | SMF | varies |

### Wi-Fi PHY (IEEE 802.11)
| Amendment | Marketing | Year | Max PHY rate |
|-----------|-----------|------|-------------|
| 802.11n | Wi-Fi 4 | 2009 | 600 Mb/s |
| 802.11ac | Wi-Fi 5 | 2013 | 6.93 Gb/s |
| 802.11ax | Wi-Fi 6 / 6E | 2019/2020 | 9.6 Gb/s |
| 802.11be | Wi-Fi 7 | 2024 | 46 Gb/s |

### WAN / access
- **DOCSIS 3.0 / 3.1 / 4.0** — cable broadband
- **GPON (G.984)**, **XG-PON (G.987)**, **XGS-PON (G.9807)**, **25G-PON**
- **SDH / SONET (G.707)**, **OTN (G.709)**
- **xDSL** — ADSL2+/VDSL2/G.fast

### Cellular
- **5G NR PHY** — 3GPP TS 38.2xx
- **LTE PHY** — 3GPP TS 36.2xx

### Transceiver MSAs (Multi-Source Agreements)
- SFP / SFP+ / SFP28 / SFP56
- QSFP+ / QSFP28 / QSFP56 / QSFP-DD
- OSFP, CFP/CFP2/CFP4/CFP8
