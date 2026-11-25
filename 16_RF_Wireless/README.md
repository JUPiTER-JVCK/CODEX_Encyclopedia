# 16 — RF / Wireless (Cross-cutting)

> Everything that travels through air or vacuum on an electromagnetic carrier:
> Wi-Fi, Bluetooth, cellular, satellite, RFID, NFC, AM/FM, HF/VHF/UHF radio.
> Hardware lives at L1; the protocols intersect L1–L3 of the network stack.

## Across the stack

```text
this layer cuts across the stack rather than sitting in one place

  10  Network Data Link (Wi-Fi MAC)  ─┐      ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  09  Network Physical (the PHY)     ─┼──────┃  16  RF / Wireless             ◀── here   ┃
  01  Circuit Board (RF front end)   ─┘      ┃      electromagnetic signalling           ┃
                                             ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

the same signal is hardware, then a PHY, then a MAC
```

## At a glance

| Field | Value |
|-------|-------|
| Spans | 01 (RF front-end hardware), 09 (PHY), 10 (Wi-Fi MAC) |
| Description | Electromagnetic communication and signaling |
| Languages | GNU Radio (Python/C++), MATLAB, VHDL/Verilog (SDR FPGAs) |
| Subdomains | Wi-Fi, Bluetooth/BLE, cellular, GNSS, satellite, ISM, amateur, mmWave |

## What lives here

- **Wi-Fi** — 2.4 / 5 / 6 / 60 GHz; 802.11 PHY/MAC; WPA2/3
- **Bluetooth Classic + BLE** — 4.x / 5.x / 6.0; mesh; LE Audio (Auracast)
- **Cellular** — 2G/3G/4G/5G (and looking at 6G research); private 5G/LTE
- **GNSS** — GPS, GLONASS, Galileo, BeiDou
- **Satellite** — VSAT, Iridium, Starlink/OneWeb LEO
- **ISM bands** — 433/868/915 MHz; 2.4/5 GHz unlicensed
- **LPWAN** — LoRa/LoRaWAN, Sigfox, NB-IoT, LTE-M
- **RFID / NFC** — LF 125 kHz, HF 13.56 MHz, UHF 860–960 MHz
- **Broadcast** — AM/FM, DAB+, DVB-T/T2, ATSC 1.0/3.0
- **Amateur radio** — HF/VHF/UHF; SSB, CW, FT8, packet, APRS, DMR/D-STAR/Fusion/M17
- **SDR** — RTL-SDR, HackRF, BladeRF, LimeSDR, USRP, Pluto
- **mmWave / 60 GHz**, **THz research**, **free-space optics**

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | Ham radio handbooks, RF textbooks, 3GPP docs |
| [Lessons](#lessons) | [Interactive labs](rf_labs.md) | SDR setup → Wi-Fi capture → LoRa lab |
| [Languages](#languages) | — | GNU Radio, MATLAB, HDLs for SDR |
| [Manual Pages](#manual-pages) | [RF & Wireless Tools Reference](rf_tools.md) | `gqrx`, `rtl_*`, `hackrf_*`, `gnuradio-companion` |
| [Topics](#topics) | — | modulation, channels, antennas, propagation, regs |
| [Protocols](#protocols) | [Bluetooth & BLE](bluetooth.md) · [LoRaWAN](lorawan.md) · [Wi-Fi](wifi.md) | wireless protocols & specs |

## Cross-references
- PHY-layer concerns shared with → [09_Network_Physical](../09_Network_Physical/)
- Wi-Fi MAC framing → [10_Network_DataLink](../10_Network_DataLink/)
- Antenna PCBs / RF front-ends → [01_Circuit_Board](../01_Circuit_Board/)
- Wireless attacks (deauth, BLE spoofing, replay) → [Security › Topics](../14_Security/README.md#topics)

---

## References

### What is in this section

```text
  Books, standards, online resources, and regulatory bodies for RF/wireless.

  ┌─── books ─────────────────────────────────────────────────────────────┐
  │  ARRL Handbook · SDR for Engineers (free PDF) · Lyons DSP             │
  │  Wireless Comms (Goldsmith) · RF Microelectronics (Razavi)            │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── standards & specs ─────────────────────────────────────────────────┐
  │  IEEE 802.11 · Bluetooth Core · 3GPP TS (LTE 36.x / 5G NR 38.x)     │
  │  ITU-R Radio Regs · ETSI EN 300 · FCC Part 15 · LoRa Alliance        │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── online & regulatory ───────────────────────────────────────────────┐
  │  GNU Radio Wiki · RTL-SDR.com · PySDR (free textbook) · DSP Guide    │
  │  FCC · Ofcom · ISED · ACMA · ITU-R · ETSI/CEPT · ARRL/RSGB/IARU     │
  └──────────────────────────────────────────────────────────────────────┘
```

### Books
- *The ARRL Handbook for Radio Communications* — annual; the bible.
- *The ARRL Antenna Book* — antenna theory & build guides.
- *Practical Antenna Design 140-150 MHz* (and similar by various authors).
- *Software Defined Radio for Engineers* — Wyglinski, Cummings, Pu, et al. (free PDF).
- *Understanding Digital Signal Processing* — Lyons.
- *Wireless Communications* — Andrea Goldsmith.
- *RF Microelectronics* — Behzad Razavi.
- *Microwave Engineering* — David Pozar.
- *Wireless and Mobile Communications* — Lee.

### Standards / specs
- **IEEE 802.11** family (Wi-Fi PHY/MAC; see [09](../09_Network_Physical/) and [10](../10_Network_DataLink/))
- **Bluetooth Core Spec** (4.x / 5.x / 6.0) — Bluetooth SIG
- **3GPP TS series** — LTE (36.x), 5G NR (38.x), 6G (in progress)
- **ITU-R Radio Regulations** — global spectrum allocation
- **ETSI EN 300 220 / 328 / 440** — European SRD bands
- **FCC Part 15** — US unlicensed devices
- **LoRa Alliance LoRaWAN spec**

### Online
- **GNU Radio Wiki & Tutorials** — `https://wiki.gnuradio.org/`
- **RTL-SDR.com** — projects + reviews
- **PySDR** — `https://pysdr.org/` (free SDR textbook in Python)
- **DSP Guide** — Steven Smith's free DSP book
- **Cellmapper, OpenCellID** — cell tower DBs
- **WSPRnet, PSK Reporter** — amateur propagation
- **RadioReference** — frequency directory

### Regulatory bodies
- **FCC** (USA) — `fcc.gov`
- **Ofcom** (UK), **ISED** (Canada), **ACMA** (Australia)
- **ITU-R** — global coordination
- **ETSI / CEPT** — Europe

### Amateur radio
- **ARRL** (USA), **RSGB** (UK), **IARU** (international)
- Operating practice books, band plans, contesting guides

---

## Lessons

### What is in this section

```text
  Lesson ladder: SDR fundamentals → Wi-Fi → BLE → LoRa → GNSS → amateur.

  ┌─── dedicated module ──────────────────────────────────────────────────┐
  │  rf_labs.md (SDR FM · Wi-Fi capture · BLE scan · LoRa hello)         │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── SDR & demodulation (1–7) ──────────────────────────────────────────┐
  │  RTL-SDR setup · GNU Radio flowgraph · IQ basics · modulation tour   │
  │  ADS-B · POCSAG paging · AIS ship transponders                        │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── wireless protocols (8–20) ─────────────────────────────────────────┐
  │  Wi-Fi monitor mode · WPA handshake · BLE scan · GATT explore        │
  │  LoRa P2P · TTN join · NFC/RFID · GNSS · amateur HF/FT8              │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── advanced (21–28) ──────────────────────────────────────────────────┐
  │  amateur radio licensing · homebrew dipole · APRS                     │
  │  private 4G/5G lab (lawful + shielded) · RF safety / regs             │
  └──────────────────────────────────────────────────────────────────────┘
```

### Dedicated Lesson Modules

| File | Covers |
|------|--------|
| [RF & Wireless — Interactive Labs](rf_labs.md) | SDR FM, Wi-Fi capture, Bluetooth scan, LoRa hello |

### SDR fundamentals
1. **SDR starter kit** — RTL-SDR + antenna; install `gqrx`/`SDR++`; tune FM band.
2. **GNU Radio Companion (GRC)** — build "tune → demodulate → audio sink" flowgraph.
3. **IQ basics** — what complex baseband means; visualize in time/freq/IQ plots.
4. **Modulation tour** — receive AM, FM, SSB, CW, PSK31, FT8 in turn.
5. **Decode ADS-B (1090 MHz)** — `dump1090`; visualize aircraft on a map.
6. **POCSAG / FLEX paging** — `multimon-ng` (where legal to monitor).
7. **AIS (ship transponders)** — `rtl_ais`; OpenCPN integration.

### Wi-Fi
8. **Monitor mode + capture** — `iw dev wlanX set type monitor`; tcpdump beacons.
9. **WPA handshake capture** — `hcxdumptool` + `hcxpcapngtool` (lawful network only).
10. **PMKID extraction** — concept walkthrough.
11. **Channel sweep** — `wavemon`, `kismet` heatmap.

### Bluetooth / BLE
12. **BLE scan** — `bluetoothctl`, `bettercap` BLE module.
13. **GATT explore** — `nrfconnect` on phone; read characteristics of a fitness sensor.
14. **Audio (Auracast)** — Bluetooth LE Audio basics.

### LoRa / LPWAN
15. **LoRa point-to-point** — two RFM95 modules on Arduinos / RPi.
16. **TTN (The Things Network)** — register a node; OTAA join; send a sensor value.

### NFC / RFID
17. **Read MIFARE card** — `nfc-poll`, `mfoc`, `mfcuk` (only your own cards).
18. **Emulate Tag** — Proxmark3 / Flipper Zero hello.

### GNSS
19. **GPS receiver** — u-blox + `gpsd` + `cgps`; sat constellations.
20. **GNSS spoofing/jamming awareness** — defensive only.

### Amateur radio
21. **Get licensed** — Technician → General → Extra (US).
22. **First contact** — VHF FM repeater, then HF SSB, then digital (FT8).
23. **Build a dipole** — 1/2-wave for 20m or 40m; SWR analyzer.
24. **APRS + Packet** — TNC software + Direwolf.

### Cellular
25. **OsmoBTS / SrsRAN / Open5GS lab** — private 4G/5G in a lab, lawful & RF-shielded.
26. **IMSI catchers — concept only** — understand detection, never deploy on open air.

### RF safety / regs
27. **Read ITU & FCC band plans** for your region.
28. **Antenna safety** — power density, height, lightning protection.

---

## Languages

### What is in this section

```text
  RF tooling from GNU Radio flowgraphs to cellular and FPGA kernels.

  ┌─── SDR / DSP frameworks ──────────────────────────────────────────────┐
  │  GNU Radio (C++/Python/GRC) · MATLAB/Simulink · LiquidSDR (C)         │
  │  PySDR · Volk · SoapySDR · Redhawk · SDRangel/SDR++                   │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── protocol stacks & tooling ─────────────────────────────────────────┐
  │  cellular: srsRAN / OAI / Open5GS (C/C++)                             │
  │  Wi-Fi: hostapd / wpa_supplicant / aircrack-ng (C)                    │
  │  BLE: BlueZ / bleak / CoreBluetooth / nRF Connect SDK                 │
  │  LoRa: LMIC / RadioLib / ChirpStack (Go)                              │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── FPGA & simulation ─────────────────────────────────────────────────┐
  │  Verilog / VHDL / Chisel · Sionna (TF) · NumPy/SciPy · Octave        │
  └──────────────────────────────────────────────────────────────────────┘
```

The "language" of RF is **signal processing**. Software tooling clusters around
a few ecosystems.

### SDR / DSP frameworks
| Tool | Languages | Notes |
|------|-----------|-------|
| GNU Radio | C++ core, Python bindings, GRC visual flowgraphs | Open-source workhorse |
| MATLAB / Simulink + Communications Toolbox | MATLAB | Industry/academia |
| Pothos / SoapySDR | C++/Python | Cross-SDR abstraction |
| LiquidSDR | C | Lightweight DSP library |
| Volk | C/C++ | Vector-optimized kernels (used by GNU Radio) |
| PySDR | Python (numpy/scipy) | Educational |
| LuaRadio | Lua | Lightweight alt to GNU Radio |
| Redhawk | C++/Python | DoD-flavored SDR framework |
| SDRangel / SDR++ / Cubic SDR | C++ | GUI SDR receivers |

### Cellular stacks
| Stack | Languages |
|-------|-----------|
| srsRAN / srsLTE / srsUE | C++ |
| Open5GS | C |
| OpenAirInterface (OAI) | C/C++ |
| YateBTS | C++ |
| Osmocom suite (OsmoBTS, OsmoBSC, OsmoCN, etc.) | C |

### Wi-Fi tooling
| Tool | Languages |
|------|-----------|
| hostapd / wpa_supplicant | C |
| aircrack-ng | C |
| kismet | C++ |
| nexmon (firmware patches) | C / assembly |
| OpenWrt / OpenWRT-friendly drivers | C |

### Bluetooth / BLE
- BlueZ (Linux) — C
- bleak (Python), noble (Node.js), CoreBluetooth (Swift/Obj-C), Android BLE (Kotlin)
- nRF Connect SDK — C / Zephyr RTOS

### LoRa / LPWAN
- LMIC / RadioLib / arduino-LoRa — C++ on microcontrollers
- ChirpStack — Go (LoRaWAN Network Server)

### HDL for SDR FPGAs
- USRP / LimeSDR / Pluto FPGAs — Verilog/VHDL/Chisel
- gr-iio / libiio — Python/C glue to FPGA-side flows

### Math / sim
- NumPy/SciPy, Octave — quick DSP prototyping
- Sionna (TF) — link-level 5G/6G physical-layer simulation
- Komm (Python) — communications-systems library
- MATLAB Communications + Antenna toolboxes

---

## Manual Pages

### What is in this section

```text
  RF tooling: SDR receivers, RTL-SDR, HackRF, Wi-Fi, BT, LoRa, GNSS.

  ┌─── dedicated subfile ─────────────────────────────────────────────────┐
  │  rf_tools.md (gnuradio · hackrf · rtl_sdr · kismet · bluetoothctl)   │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── SDR hardware tools ────────────────────────────────────────────────┐
  │  gqrx / SDR++ (GUI) · rtl_fm / rtl_power / rtl_433 / dump1090       │
  │  hackrf_transfer / hackrf_sweep · bladeRF-cli · uhd_usrp_probe       │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── wireless protocol tools ───────────────────────────────────────────┐
  │  iw / hostapd / aircrack-ng / kismet / hcxdumptool (Wi-Fi)           │
  │  bluetoothctl / btmon · ChirpStack · pm3 / Flipper Zero (NFC)        │
  │  gpsd / cgps (GNSS) · srsenb / osmo-bts (cellular lab)               │
  └──────────────────────────────────────────────────────────────────────┘
```

### Dedicated man page references

| Topic | File |
|-------|------|
| RF & wireless tools | [RF & Wireless Tools Reference](rf_tools.md) — gnuradio, hackrf, rtl_sdr, kismet, bluetoothctl |

---

### SDR receivers (GUI + CLI)
| Tool | Purpose |
|------|---------|
| `gqrx` | Popular Qt SDR receiver |
| `SDR++` | Modern cross-platform receiver |
| `SDRangel` | Multi-receiver, multi-protocol |
| `cubicsdr` | Simple cross-platform |
| `gnuradio-companion` (`grc`) | Visual flowgraph editor |
| `osmocom_fft` | Quick spectrum view |

### RTL-SDR utilities
| Command | Purpose |
|---------|---------|
| `rtl_fm` | FM/AM/SSB demod |
| `rtl_tcp` | Stream IQ over network |
| `rtl_test` | Sample-rate / gain tests |
| `rtl_power` | Spectrum scan / heatmap |
| `rtl_433` | Decode 433 MHz ISM (weather sensors, doorbells) |
| `rtl_ais` | AIS marine receiver |
| `dump1090` | ADS-B aircraft |

### HackRF
| Command | Purpose |
|---------|---------|
| `hackrf_info` | Device info |
| `hackrf_transfer -r out.iq -f 100e6` | Capture IQ |
| `hackrf_sweep` | Spectrum sweep |
| `hackrf_spiflash` | Firmware mgmt |

### BladeRF / LimeSDR / USRP
| Command | Purpose |
|---------|---------|
| `bladeRF-cli` | BladeRF interactive tool |
| `LimeSuite`, `LimeUtil` | LimeSDR |
| `uhd_find_devices`, `uhd_usrp_probe` | USRP devices |
| `rx_samples_to_file` | USRP IQ capture |

### Wi-Fi
| Command | Purpose |
|---------|---------|
| `iw` | Modern wireless config |
| `iwconfig` (legacy) | Older wireless config |
| `wpa_supplicant` | Client connection |
| `hostapd` | AP daemon |
| `wavemon` | Live signal/quality TUI |
| `kismet` | Sniffer + WIDS |
| `aircrack-ng` suite | `airmon-ng`, `airodump-ng`, `aireplay-ng`, `aircrack-ng` |
| `hcxdumptool`, `hcxpcapngtool` | Modern WPA capture |
| `wifite` | Automated Wi-Fi audit |
| `bettercap` | L2/L7 wireless attacks |

### Bluetooth
| Command | Purpose |
|---------|---------|
| `bluetoothctl` | BlueZ CLI |
| `hciconfig`, `hcitool`, `hcidump` (legacy) | Older BlueZ |
| `btmon` | Modern BlueZ monitor |
| `gatttool`, `bluetoothd` | GATT operations |
| `nrfutil`, `nrf-connect` | Nordic tooling |

### LoRa / LPWAN
| Tool | Purpose |
|------|---------|
| ChirpStack (`chirpstack`) | LoRaWAN NS |
| LoRaServer (legacy) | Predecessor |
| `lora_pkt_fwd` | UDP packet forwarder for gateways |

### RFID / NFC
| Command | Purpose |
|---------|---------|
| `nfc-list`, `nfc-poll`, `nfc-mfclassic` | libnfc |
| `pm3` (Proxmark client) | Proxmark3 |
| Flipper Zero CLI / app | Hobbyist multi-tool |

### GNSS
| Command | Purpose |
|---------|---------|
| `gpsd` | Daemon |
| `cgps`, `gpsmon` | Clients |
| `ublox-tools` / `u-center` (Windows) | u-blox config |

### Cellular (lab use)
| Tool | Purpose |
|------|---------|
| `srsenb`, `srsue`, `srsepc` | srsRAN suite |
| `osmo-bts`, `osmo-bsc`, etc. | Osmocom |
| `open5gs-mmed`, ... | Open5GS daemons |

### Spectrum & analysis
- `gr_specest`, `inspectrum` (GUI burst inspection), `urh` (Universal Radio Hacker)

---

## Topics

### What is in this section

```text
  RF topics: fundamentals → modulation → antennas → wireless protocols.

  ┌─── physics & propagation ─────────────────────────────────────────────┐
  │  wavelength/frequency · bands (VLF–EHF) · dB/dBm/dBi · link budget  │
  │  path loss (Friis/Okumura) · fading (Rayleigh/Rician) · Doppler      │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── modulation, coding & antennas ────────────────────────────────────┐
  │  AM/FM/SSB · ASK/FSK/PSK/QAM/OFDM/DSSS · LDPC/Polar/Turbo codes    │
  │  dipole/Yagi/patch/phased-array · MIMO · receiver architectures       │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── protocol topics ───────────────────────────────────────────────────┐
  │  Wi-Fi bands/security · BLE/GATT/attacks · cellular (2G→5G)          │
  │  GNSS · LoRa/NB-IoT/Zigbee/Matter · RFID/NFC · amateur/broadcast    │
  └──────────────────────────────────────────────────────────────────────┘
```

### RF fundamentals
- **Wavelength, frequency, period** — λ = c/f
- **Bands & propagation** — VLF, LF, MF, HF, VHF, UHF, SHF, EHF; ground wave, sky wave, line of sight
- **Decibels** — dBm, dBW, dBi, dBd, dBc, dBFS, dB-Hz
- **Link budget** — Tx power + Tx antenna gain − path loss − misc − Rx noise floor + Rx antenna gain
- **Path loss models** — Friis (free space), Okumura-Hata, COST-231, Longley-Rice
- **Fading** — slow vs fast; Rayleigh, Rician, Nakagami
- **Doppler shift, coherence time / bandwidth**

### Modulation
- **Analog** — AM, FM, PM, SSB (USB/LSB), DSB-SC
- **Digital** — ASK, FSK, PSK, QAM, OFDM/OFDMA, GMSK, CPFSK
- **Spreading** — DSSS, FHSS, CSS (LoRa), CDMA
- **MIMO** — SU-MIMO, MU-MIMO, beamforming, massive MIMO, OFDMA-RU

### Coding & error control
- **Block codes** — Hamming, BCH, Reed-Solomon
- **Convolutional + Viterbi**, **Turbo codes**, **LDPC**, **Polar codes** (5G)
- **Interleaving** to combat burst errors

### Antennas
- **Types** — dipole, Yagi, log-periodic, patch, helical, horn, slot, fractal
- **Parameters** — gain (dBi), VSWR, impedance (50Ω typical), polarization, F/B ratio, bandwidth
- **Arrays & beamforming** — phased arrays, MIMO antennas
- **mmWave specifics** — high path loss, narrow beams, foliage/rain attenuation

### Receivers / transmitters
- **Superheterodyne** vs **direct conversion (zero-IF)** vs **low-IF**
- **SDR architecture** — RF front-end → ADC/DAC → DDC/DUC → host DSP
- **Sensitivity, selectivity, noise figure, IP3, dynamic range**

### Spectrum & regulation
- **Licensed vs unlicensed (ISM)** — Wi-Fi/BT in 2.4/5/6 GHz; LoRa in 868/915 MHz; etc.
- **FCC Part 15**, **ETSI EN 300 328 / 220**
- **Duty cycle** restrictions on LPWAN bands
- **TDWR/radar coexistence** — DFS rules in 5 GHz Wi-Fi

### Wi-Fi specifics
- **Bands & channels** — 2.4 (1–14), 5, 6 (UNII bands), 60 GHz (802.11ad/ay)
- **Channel widths** — 20/40/80/160/320 MHz
- **Generations** — Wi-Fi 4/5/6/6E/7 (and prior a/b/g)
- **Security** — WEP (broken), WPA, WPA2, WPA3 (SAE/Dragonfly), OWE (open enhanced)

### Bluetooth / BLE
- **Versions** — Classic 1.x–5.x; LE 4.0+; Auracast LE Audio (5.2)
- **Topologies** — piconet, scatternet (Classic); BLE star, mesh, broadcast
- **GATT, ATT, L2CAP, SMP**
- **BLE attacks** — sniffing, key negotiation flaws (KNOB), spoofing

### Cellular
- **2G GSM, 3G UMTS/HSPA, 4G LTE, 5G NR (NSA/SA)**
- **EPC vs 5GC** core networks
- **RAN split** — DU/CU/RU (Open RAN)
- **Frequencies** — FR1 (sub-6) vs FR2 (mmWave)
- **Private LTE/5G (CBRS in US)**

### GNSS
- **Constellations** — GPS, GLONASS, Galileo, BeiDou, IRNSS, QZSS
- **Signals** — L1/L2/L5
- **Augmentation** — SBAS (WAAS/EGNOS/MSAS), RTK
- **Spoofing & jamming** — defenses

### LPWAN
- **LoRa** — CSS modulation; LoRaWAN MAC (ABP/OTAA)
- **Sigfox** — UNB, low-bit-rate
- **NB-IoT / LTE-M** — licensed cellular IoT
- **Zigbee, Z-Wave, Thread, Matter** — short-range mesh

### RFID / NFC
- **LF (125 kHz)** — EM4100, HID Prox
- **HF (13.56 MHz)** — MIFARE Classic/DESFire, FeliCa, NFC (ISO 14443/15693)
- **UHF (860–960 MHz)** — EPC Gen2 (logistics)

### Broadcast
- **AM / FM**, **HD Radio (US)**, **DAB+ (EU)**
- **DVB-T / T2 / S2 / C2**, **ATSC 1.0/3.0**

### Amateur radio
- **License classes** — Tech / Gen / Extra (US)
- **Modes** — SSB, CW, FT8/FT4, PSK31, AM/FM, DMR/D-STAR/Fusion/M17
- **APRS, Packet, Winlink**
- **Repeaters, satellites (AMSAT, ARISS), EME (moonbounce)**

### Security cross-link
- KRACK, dragonblood (Wi-Fi); KNOB, BLURtooth (BT); IMSI catchers (cellular); GNSS spoofing
- Wireless attacks live in [Security › Topics](../14_Security/README.md#topics)

---

## Protocols

### What is in this section

```text
  Wi-Fi, Bluetooth, cellular, LPWAN, GNSS, broadcast, amateur digital.

  ┌─── WLAN & WPAN ───────────────────────────────────────────────────────┐
  │  Wi-Fi 4/5/6/6E/7 (802.11n/ac/ax/be) · WPA3 / SAE · WiGig (60 GHz) │
  │  Bluetooth Classic/BLE 4.x–6.x · LE Audio / Auracast · BT Mesh      │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── cellular & LPWAN ──────────────────────────────────────────────────┐
  │  3GPP: 2G GSM → 3G UMTS → 4G LTE → 5G NR → 5G-Advanced             │
  │  LoRaWAN · Sigfox · NB-IoT · LTE-M · Zigbee · Z-Wave · Thread/Matter│
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── positioning, broadcast & amateur ─────────────────────────────────┐
  │  GNSS: GPS/GLONASS/Galileo/BeiDou · RFID/NFC (HF/UHF)               │
  │  AM/FM/DAB/DVB-T · FT8/PSK31/APRS/DMR/D-STAR (amateur digital)      │
  └──────────────────────────────────────────────────────────────────────┘
```

> Wi-Fi, Bluetooth, cellular, LPWAN, GNSS, broadcast, amateur digital.

### Dedicated Protocol References

| File | Covers |
|------|--------|
| [Wi-Fi (802.11)](wifi.md) | Evolution, OFDM, WPA3, roaming, mesh |
| [Bluetooth / BLE](bluetooth.md) | GATT, pairing, LE Audio, BT Mesh |
| [LoRaWAN](lorawan.md) | Classes, OTAA/ABP, ADR, regional params |

### Wi-Fi (802.11)

| Standard | Marketing name | Band | Year |
|----------|----------------|------------|------|
| 802.11a | — | 5 GHz | 1999 |
| 802.11b | — | 2.4 GHz | 1999 |
| 802.11g | — | 2.4 GHz | 2003 |
| 802.11n | Wi-Fi 4 | 2.4 / 5 | 2009 |
| 802.11ac | Wi-Fi 5 | 5 | 2013 |
| 802.11ax | Wi-Fi 6 / 6E | 2.4 / 5 / 6 | 2019/2020 |
| 802.11be | Wi-Fi 7 | 2.4 / 5 / 6 | 2024 |
| 802.11bn | Wi-Fi 8 (in dev) | TBD | future |
| 802.11ad / ay | WiGig | 60 GHz | 2012 / 2021 |

#### Wi-Fi security
| Spec | Notes |
|------|-------|
| WEP | Broken |
| WPA / WPA2 | TKIP / AES-CCMP |
| WPA3 | SAE (Dragonfly), 192-bit suite, OWE for open |
| EAP types | TLS, TTLS, PEAP, FAST, AKA' |

### Bluetooth
| Spec | Notes |
|------|-------|
| Core 4.0 | Introduced BLE |
| Core 4.2 | LE Secure Connections |
| Core 5.0 | Long range, 2M PHY |
| Core 5.1 | Direction finding (AoA/AoD) |
| Core 5.2 | LE Audio, LC3, Isochronous channels |
| Core 5.3 / 5.4 | Periodic adv enhancements, channel sounding work |
| Core 6.0 | Channel sounding (2024+) |
| Mesh 1.1 | BT mesh stack |

### Cellular (3GPP)
| Generation | Releases |
|------------|----------|
| 2G GSM/GPRS/EDGE | (pre-3GPP / Rel-99) |
| 3G UMTS / HSPA / HSPA+ | Rel-99 → Rel-7 |
| 4G LTE / LTE-A | Rel-8 → Rel-14 |
| 5G NR (NSA / SA) | Rel-15 → present |
| 5G-Advanced | Rel-18 → 20 |
| 6G research | post-Rel-20 |

### LPWAN / IoT
| Protocol | Owner | Notes |
|----------|-------|-------|
| LoRaWAN | LoRa Alliance | Long-range ISM, ABP/OTAA |
| Sigfox | Sigfox | UNB |
| NB-IoT | 3GPP | Licensed-cellular IoT |
| LTE-M (Cat-M1) | 3GPP | Higher BW IoT |
| Zigbee 3.0 | CSA | 802.15.4 mesh |
| Z-Wave | Silicon Labs | Home automation |
| Thread | Thread Group | IPv6 mesh (802.15.4) |
| Matter | CSA | App-layer over Thread/Wi-Fi/Eth |

### RFID / NFC
| Standard | Notes |
|----------|-------|
| ISO/IEC 18000 series | RFID air interfaces |
| ISO/IEC 14443 (A/B) | HF contactless (MIFARE) |
| ISO/IEC 15693 | HF vicinity cards |
| ISO/IEC 18092 (NFCIP-1) | NFC |
| EPC Gen2 (ISO 18000-6C) | UHF supply chain |

### GNSS
| System | Owner | Bands |
|--------|-------|-------|
| GPS | USA | L1/L2/L5 |
| GLONASS | Russia | L1/L2/L3 |
| Galileo | EU | E1/E5a/E5b/E6 |
| BeiDou | China | B1/B2/B3 |
| QZSS | Japan | L1/L2/L5 + LEX |
| IRNSS / NavIC | India | L5/S |

### Broadcast
| Protocol | Notes |
|----------|-------|
| AM / FM | Analog broadcast |
| HD Radio | iBiquity, US |
| DAB / DAB+ | Eureka 147 |
| DVB-T / T2 | Terrestrial digital TV |
| DVB-S / S2 / S2X | Satellite |
| ATSC 1.0 / 3.0 | US DTV |
| RDS / RBDS | FM data subcarrier |

### Amateur digital
| Mode | Notes |
|------|-------|
| FT8 / FT4 | WSJT-X weak-signal |
| PSK31 | Live keyboard chat |
| Packet (AX.25) | TNCs / KISS |
| APRS | Position reporting |
| D-STAR, DMR, Yaesu Fusion (C4FM), M17 | Digital voice |
| Winlink | HF email via PACTOR / VARA |

### Identifier / framing standards
- **EUI-48 / EUI-64** — MAC addresses (also used by BLE, LoRa devEUI, etc.)
- **ICCID, IMSI, IMEI** — cellular identifiers
- **MMSI** — maritime AIS
- **ICAO 24-bit address** — ADS-B

### Spectrum allocation
- **ITU-R Radio Regulations** — global
- **FCC OET Frequency Allocation Table** — USA
- **CEPT ERC Report 25** — Europe
