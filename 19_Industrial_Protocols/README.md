# 19 — Industrial & Automotive Protocols (Cross-cutting)

> Field-bus, motion-control, building-automation, and vehicle-network protocols.
> Many ride below standard IP networks (or in parallel to them) and don't fit
> cleanly into the OSI-aligned layers 09–13.

## Across the stack

```text
this layer cuts across the stack rather than sitting in one place

  18  Embedded Systems     ─┐
  13  Network Application  ─┤
  12  Network Transport    ─┤      ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  11  Network Internet     ─┼──────┃  19  Industrial & Automotive Protocols  ◀── here ┃
  10  Network Data Link    ─┤      ┃      deterministic, domain-specific networks     ┃
  09  Network Physical     ─┘      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

OT networks trade throughput for bounded, predictable latency
```

## At a glance

| Field | Value |
|-------|-------|
| Spans | 09–13 + OT/ICS world; 18 (embedded) consumer |
| Description | Deterministic and/or domain-specific networks: industrial, automotive, building, energy |
| Languages | C / C++ (stack impls); Python (clients); Vector CANoe (automotive); CodeSys (PLC) |

## Subdomains

### Industrial / OT
- **Field buses** — Modbus, PROFIBUS, DeviceNet, AS-i, INTERBUS
- **Industrial Ethernet** — PROFINET, EtherNet/IP, EtherCAT, POWERLINK, Sercos III, CC-Link IE, Modbus TCP
- **Building automation** — BACnet, KNX, LonWorks, DALI, DMX512, M-Bus
- **Process** — HART, WirelessHART, ISA100.11a, Foundation Fieldbus
- **Energy / smart grid** — IEC 61850, DNP3, Modbus, IEC 60870-5
- **Semantic / interop** — OPC UA, OPC Classic (DA/AE/HDA)

### Automotive
- **CAN (CAN 2.0A/B, CAN-FD, CAN-XL)**, **LIN**, **FlexRay**, **MOST**
- **Automotive Ethernet** (100BASE-T1 / 1000BASE-T1 / MultiGBASE-T1)
- **SOME/IP, DDS** — service-oriented in-vehicle
- **AUTOSAR PDU formats**
- **UDS (ISO 14229)**, **KWP2000 (ISO 14230)**, **J1939** — diagnostics & heavy-duty
- **OBD-II (ISO 15765)** — emissions diag

### IoT / messaging (cross-link)
- **MQTT, CoAP, AMQP, NATS** — see [13_Network_Application](../13_Network_Application/README.md#protocols)

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — |  |
| [Lessons](#lessons) | [Interactive labs](industrial_labs.md) |  |
| [Languages](#languages) | — |  |
| [Manual Pages](#manual-pages) | — |  |
| [Topics](#topics) | — |  |
| [Protocols](#protocols) | [Modbus](modbus.md) · [OPC UA](opc_ua.md) |  |

## Cross-references
- Ethernet PHY for industrial Ethernet → [09_Network_Physical](../09_Network_Physical/)
- IP-based traffic on top → [11_Network_Internet](../11_Network_Internet/)
- Embedded system context → [18_Embedded_Systems](../18_Embedded_Systems/)
- ICS / SCADA security → [Security › Topics](../14_Security/README.md#topics)
- Bus-wire physical level → [Circuit Board › Protocols](../01_Circuit_Board/README.md#protocols)

---

## References

### What is in this section

```text
  Books, standards bodies, and online resources for industrial protocols.

  ┌─── books ─────────────────────────────────────────────────────────────┐
  │  industrial: Industrial Comm Systems · Industrial Network Security    │
  │  automotive: CAN guide (Voss) · J1939 guide · Automotive Ethernet    │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── standards bodies ──────────────────────────────────────────────────┐
  │  Modbus Org · PI (PROFIBUS/PROFINET) · ODVA (CIP) · ETG (EtherCAT)  │
  │  OPC Foundation · ASHRAE (BACnet) · CiA (CANopen) · AUTOSAR · SAE   │
  │  IEC (61850/60870/61131) · FieldComm Group (HART) · KNX · DALI/DiiA │
  └──────────────────────────────────────────────────────────────────────┘
```

### Industrial / OT
- *Industrial Communication Systems* — Bogdan M. Wilamowski (CRC).
- *Industrial Network Security* — Knapp & Langill (ICS/SCADA security focus).
- *Modbus Application Protocol Specification V1.1b3* — Modbus Organization (free).
- *PROFINET — The Solution to Industrial Communication* — Karl-Heinz Niemann.
- *EtherCAT Technology Group* technical docs (members & public papers).
- *BACnet: A Data Communication Protocol for Building Automation and Control* — H. Michael Newman.
- *OPC Unified Architecture* — Mahnke, Leitner, Damm (Springer).
- *DALI by Example* — Beck & Schillinger.

### Automotive
- *Understanding Automotive Electronics* — William Ribbens.
- *Controller Area Network Projects* — Dogan Ibrahim.
- *A Comprehensible Guide to Controller Area Network* — Wilfried Voss.
- *A Comprehensible Guide to J1939* — Wilfried Voss.
- *Automotive Ethernet* — Matheus & Königseder (Cambridge).
- *AUTOSAR Compendium* — Dr. Lars Geyer-Blaumeiser (free PDFs).
- *SOME/IP — Technical Overview* — AUTOSAR docs.

### Standards bodies
- **Modbus Organization** — modbus.org
- **PI (PROFIBUS & PROFINET International)** — profibus.com
- **ODVA** — odva.org (EtherNet/IP, DeviceNet, ControlNet)
- **EtherCAT Technology Group (ETG)** — ethercat.org
- **EPSG** — Ethernet POWERLINK
- **OPC Foundation** — opcfoundation.org
- **ASHRAE** — BACnet (ASHRAE Standard 135)
- **KNX Association** — knx.org
- **DALI Alliance / DiiA** — dali-alliance.org
- **DMX/RDM (ESTA)** — tsp.esta.org
- **IEC** — IEC 61850, IEC 60870-5, IEC 61131-3
- **HART Communication Foundation** (now FieldComm Group)
- **CAN in Automation (CiA)** — can-cia.org
- **AUTOSAR** — autosar.org
- **SAE** — J1939, J2602 (LIN US), J3138
- **ISO** — ISO 14229 (UDS), ISO 11898 (CAN), ISO 17458 (FlexRay), ISO 21434 (auto cybersec)
- **OASIS** — MQTT 5
- **IETF** — CoAP (RFC 7252)

### Online
- ControlGlobal, Automation.com, ARC Advisory blog
- PLCdev / `instrumentationtools.com`
- CSS Electronics free guides (CAN, J1939)
- Wireshark wiki — dissector docs for most of the above

---

## Lessons

### What is in this section

```text
  Lesson ladder: industrial OT → automotive → ICS/SCADA security.

  ┌─── dedicated module ──────────────────────────────────────────────────┐
  │  industrial_labs.md (Modbus TCP · OPC UA browse · CAN monitor · MQTT)│
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── industrial / OT (1–10) ────────────────────────────────────────────┐
  │  Modbus RTU/TCP · PROFINET · EtherCAT · OPC UA · BACnet              │
  │  DALI · DMX512 · HART · IEC 61850 substation                         │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── automotive (11–18) ────────────────────────────────────────────────┐
  │  CAN basics/FD · UDS over CAN · OBD-II · J1939 · LIN · FlexRay      │
  │  SOME/IP                                                              │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── ICS / SCADA security (19–21) ─────────────────────────────────────┐
  │  Modbus security (TLS) · Modbus fuzzing (lab) · CAN intrusion        │
  └──────────────────────────────────────────────────────────────────────┘
```

### Dedicated Lesson Modules

| File | Covers |
|------|--------|
| [Industrial Protocols — Interactive Labs](industrial_labs.md) | Modbus TCP, OPC UA browse, CAN monitor, MQTT pub/sub |

### Industrial / OT
1. **Modbus RTU on RS-485** — single master + 2 slaves on a USB-to-RS485 dongle; read holding regs.
2. **Modbus TCP** — port 502 server with `pymodbus`; map exception codes.
3. **PROFINET basics** — read a vendor wireshark capture; identify DCP, MRP, RT/IRT.
4. **EtherCAT slave bring-up** — buy a SOEM/IgH master kit; observe DC sync.
5. **OPC UA hello** — `python-opcua` server + UaExpert client; browse address space.
6. **BACnet/IP** — `bacpypes` device sim; read property; subscribe to COV.
7. **DALI tour** — wire one DALI driver; use a USB DALI adapter (e.g. Lunatone).
8. **DMX512 lighting** — control a moving head from a DMX USB widget.
9. **HART** — concept walkthrough; HART modem decode via SDR.
10. **IEC 61850** — read a substation SCD; identify GOOSE messages in wireshark.

### Automotive
11. **CAN basics** — CANable / PEAK-USB; `cansend`, `candump`; arbitration ID 0x7E0.
12. **CAN-FD** — same hardware, FD frames; observe data-phase bitrate change.
13. **UDS over CAN** — read DTCs (service 0x19), clear DTCs (0x14); RoutineControl.
14. **OBD-II live data** — ELM327 adapter; query Mode 01 PIDs (speed, RPM, coolant).
15. **J1939** — heavy-duty truck PGNs; decode EEC1, ETC1.
16. **LIN** — master/slave on dev board; observe sync break + schedule table.
17. **FlexRay** — concept + vector trace; static + dynamic segments.
18. **SOME/IP** — Wireshark + sample app; events vs requests.

### ICS / SCADA security (cross-link [14](../14_Security/))
19. **Modbus security** — sniff cleartext; deploy TLS-Modbus (RFC 8907 / 2018+).
20. **Modbus fuzzing** — `modbus-cli`, `smod`, Codesys exploits in isolated lab.
21. **CAN intrusion** — `canbusniffer`, replay attacks; awareness only.

### Suggested external
- CSS Electronics CAN bus introductions (free)
- "Wireshark for SCADA / OT" workshops (Black Hat / Idaho Falls)
- Real Pars (PLC) YouTube

---

## Languages

### What is in this section

```text
  Languages for industrial and automotive protocol work.

  ┌─── implementation languages ──────────────────────────────────────────┐
  │  C — fieldbus stacks (SOEM/FreeMODBUS/libsocketcan)                  │
  │  C++ — OPC UA / CANoe APIs                                           │
  │  Python — pymodbus · python-can · cantools · asyncua · bacpypes3     │
  │  Rust — socketcan crate · OPC UA efforts                              │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── PLC languages (IEC 61131-3) ──────────────────────────────────────┐
  │  Ladder Diagram · Function Block Diagram · Structured Text (ST)       │
  │  Sequential Function Chart · IDEs: CODESYS / TIA Portal / TwinCAT    │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── automotive DSLs ───────────────────────────────────────────────────┐
  │  CAPL (CANoe/CANalyzer) · DBC files · ARXML (AUTOSAR) · ODX (UDS)   │
  └──────────────────────────────────────────────────────────────────────┘
```

### Implementation languages
| Language | Use |
|----------|-----|
| C | Most field-bus stacks (OpenSAFETY, EtherCAT SOEM, lwIP, FreeMODBUS, libsocketcan) |
| C++ | Higher-level (OPC UA open62541 has both; CANoe APIs) |
| Python | Tooling & clients: `pymodbus`, `python-can`, `python-snap7` (Siemens S7), `bacpypes`, `python-opcua`, `cantools`, `udsoncan` |
| Rust | Newer stacks: `socketcan` crate, OPC UA in Rust, EtherCAT efforts |
| Go | `goburrow/modbus`, `gosnmp` |

### PLC languages (IEC 61131-3)
| Lang | Notes |
|------|-------|
| Ladder Diagram (LD) | Visual, relay-logic style |
| Function Block Diagram (FBD) | Block-and-wire |
| Structured Text (ST) | Pascal-like, expressive |
| Sequential Function Chart (SFC) | State-machine-like |
| Instruction List (IL) | Assembly-like (deprecated in 3rd ed.) |

PLC IDEs: CODESYS, TIA Portal (Siemens), TwinCAT (Beckhoff), Studio 5000 (Rockwell).

### Vehicle / automotive DSLs & ecosystems
| Language / tool | Use |
|-----------------|-----|
| Vector CANoe / CANalyzer (CAPL) | Industry-standard CAN/LIN/FlexRay simulation |
| CANdb++ / DBC files | CAN message database |
| ARXML | AUTOSAR XML (BSW config, ECU extract) |
| FIBEX | Field-bus exchange XML |
| ODX (ISO 22901) | Open Diagnostic data eXchange (UDS DBs) |
| dSPACE ControlDesk + Simulink | HIL test |

### OPC UA address-space modeling
- NodeSet XML (UA 1.04+)
- Companion specs (FDI, AutomationML)

### Useful Python libs (pip install ...)
| lib | Purpose |
|-----|---------|
| `pymodbus` | Modbus RTU/TCP/UDP master & slave |
| `python-can` | Cross-platform CAN |
| `cantools` | DBC parsing + decode |
| `udsoncan` | UDS client |
| `python-opcua` (deprecated → `asyncua`) | OPC UA |
| `bacpypes3` | BACnet |
| `python-snap7` | Siemens S7 PLC |
| `pylogix` | Allen-Bradley CIP / EtherNet-IP |
| `socketcan` | Linux socketCAN bindings |
| `pyprofibus` | PROFIBUS (limited support) |

### Cross-link
- App-layer messaging protocols → [Network Application › Languages](../13_Network_Application/README.md#languages)
- L2 framing under industrial Ethernet → [10_Network_DataLink](../10_Network_DataLink/)

---

## Manual Pages

### What is in this section

```text
  CLI and GUI clients for industrial and automotive protocols.

  ┌─── industrial clients ────────────────────────────────────────────────┐
  │  modpoll / mbpoll (Modbus) · UaExpert (OPC UA) · Yabe (BACnet)      │
  │  SOEM / IgH EtherCAT master · ENTTEC DMX / ola (DMX/RDM)            │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── automotive / CAN ──────────────────────────────────────────────────┐
  │  candump · cansend · cangen · cantools · caringcaribou (security)    │
  │  ELM327 / obd (OBD-II) · Vector CANalyzer/CANoe / PEAK PCAN         │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── analysis ──────────────────────────────────────────────────────────┐
  │  Wireshark dissectors: Modbus · EtherCAT · PROFINET · CAN · J1939   │
  │  CANable / PEAK PCAN-USB · industrial Ethernet TAPs                  │
  └──────────────────────────────────────────────────────────────────────┘
```

Grouped by protocol rather than by command — each section lists the CLI and
GUI clients that speak it.

### Modbus
| Tool | Purpose |
|------|---------|
| `modpoll` | CLI client (TCP / RTU) |
| `mbpoll` | Open alt |
| `pymodbus.server` / `.client` | Python lib |
| QModMaster | GUI master |
| Diagslave | Test slave |

### CAN (SocketCAN on Linux)
| Tool | Purpose |
|------|---------|
| `ip link set can0 up type can bitrate 500000` | Bring up CAN iface |
| `candump can0` | Live monitor |
| `cansend can0 123#DEADBEEF` | Send frame |
| `cangen` | Random traffic generator |
| `canbusload` | Bus load monitor |
| `canfdtest` | CAN-FD echo test |
| `slcand` | Serial line CAN (CANable/USBtin) |
| `cantools` | DBC decode/encode CLI |
| `kayak` | Java GUI |
| `caringcaribou` | CAN security testing |

### CAN (other OS)
- Vector tools (CANalyzer, CANoe, CANalyzer.HW)
- PEAK PCAN-View / PCAN-Explorer
- Kvaser CanKing
- Wireshark with CAN dissector

### EtherCAT
| Tool | Purpose |
|------|---------|
| SOEM (Simple Open EtherCAT Master) | Open C/C++ master |
| IgH EtherCAT master | Linux kernel master |
| TwinCAT 3 | Beckhoff IDE+runtime |
| EtherCAT Explorer | Vendor diagnostic |

### OPC UA
| Tool | Purpose |
|------|---------|
| UaExpert | Reference GUI client (Unified Automation) |
| open62541 examples | Open server/client |
| Prosys OPC UA Simulation Server | Free server for testing |

### BACnet
| Tool | Purpose |
|------|---------|
| Yabe (Yet Another BACnet Explorer) | Free Windows GUI |
| BACnet Stack (Steve Karg) | Open C reference |
| `bacpypes` apps | Python CLIs |

### DALI / DMX
- Lunatone DALI USB tools
- ENTTEC DMX USB Pro + various controller apps
- ola (Open Lighting Architecture) — DMX/RDM stack
- QLC+ — open lighting controller

### Vehicle diagnostics
| Tool | Purpose |
|------|---------|
| ELM327 USB / Bluetooth | OBD-II adapter |
| `obd` (Python) | OBD-II library |
| ScanTool / Torque Pro | App-level OBD |
| ODB Auto Doctor | Multi-platform diag |
| Vector vFlash / CANape | Pro-grade flash/diag |

### Wireshark dissectors (built-in)
- Modbus, EtherCAT, EtherNet/IP, CIP, PROFINET, BACnet, OPC UA, DNP3, IEC 61850 (MMS/GOOSE/SV), HART-IP, CAN/CAN-FD, J1939

### Capture hardware
- Logic analyzers with industrial protocol decoders (Saleae, DSLogic — see [Embedded Bus Protocols](../01_Circuit_Board/embedded_bus_protocols_lookup.md))
- Industrial Ethernet TAPs / mirror ports
- CAN sniffer: CANable, Kvaser USBcan, PEAK PCAN-USB, Vector VN1610

---

## Topics

### What is in this section

```text
  Protocol internals: Modbus → PROFINET → EtherCAT → CAN → OPC UA.

  ┌─── fieldbus internals ────────────────────────────────────────────────┐
  │  Modbus function codes · PROFIBUS DP/PA · PROFINET (RT/IRT/TSN/MRP)  │
  │  EtherCAT DC sync / CoE / ESI · EtherNet/IP CIP · CANopen SDO/PDO   │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── automotive protocols ──────────────────────────────────────────────┐
  │  CAN 2.0 / CAN-FD arbitration · LIN master/slave schedule            │
  │  FlexRay static+dynamic · SOME/IP service discovery                  │
  │  UDS (ISO 14229) diagnostic services · J1939 PGNs · AUTOSAR Classic  │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── SCADA & building ──────────────────────────────────────────────────┐
  │  DNP3 · IEC 61850 (GOOSE/MMS/SV) · IEC 60870-5-101/104              │
  │  BACnet/IP · KNX · DALI · HART · OPC UA (address space / PubSub)    │
  └──────────────────────────────────────────────────────────────────────┘
```

### Modbus
- **Variants** — Modbus RTU (RS-485/232), Modbus ASCII, Modbus TCP (port 502), Modbus over UDP
- **Function codes** — 01 Read Coils, 03 Read Holding Regs, 06 Write Single Reg, 16 Write Multiple, etc.
- **Exception codes** — 01 Illegal Function, 02 Illegal Address, 03 Illegal Value, 04 Slave Device Failure
- **Holding/Input registers, coils, discrete inputs** — 4 address spaces
- **Modbus security** — TLS extension (RFC?-equiv), role-based access (newer)

### PROFIBUS / PROFINET
- **PROFIBUS DP/PA** — legacy RS-485 / IS-friendly
- **PROFINET IO** — RT, IRT, TSN profiles
- **GSD / GSDML** — device description files
- **MRP, MRPD** — media redundancy
- **DCP** — Discovery & Configuration Protocol

### EtherCAT
- **Master + slaves on shared ring/line topology**
- **Distributed clocks (DC)** — sub-µs sync
- **CoE (CANopen over EtherCAT)** — object dictionary
- **EoE, SoE, FoE** — Ethernet/Servo/File over EtherCAT
- **ESI XML** — device description

### EtherNet/IP, DeviceNet, ControlNet (ODVA)
- **CIP (Common Industrial Protocol)** common app layer
- **EtherNet/IP** = CIP over TCP+UDP
- **DeviceNet** = CIP over CAN (rare new installs)
- **ControlNet** = CIP over coax (legacy)

### CANopen
- Object dictionary + PDOs + SDOs + heartbeat
- Sits on top of CAN 2.0

### POWERLINK, Sercos III, CC-Link IE
- Industrial Ethernet alternatives, motion-control focus

### OPC UA
- **Address space** — nodes, references, types
- **Services** — discovery, browse, read/write, subscribe, method call
- **Information models** — companion specs (e.g., for robotics, energy, packaging)
- **Security modes** — None, Sign, SignAndEncrypt
- **PubSub** — newer, broker-less (UDP / MQTT / AMQP)

### Building automation
- **BACnet** — over IP / MS-TP (RS-485) / Ethernet / ARCnet; objects + services + COV subscription
- **KNX** — TP1 / IP / RF; group addresses
- **LonWorks** — neuron chips, deprecated but installed base
- **DALI** — 9600 baud Manchester-coded, 16-bit forward / 8-bit backward frames
- **DMX512** — 250 kbaud, up to 512 channels, RS-485
- **M-Bus** — meter bus (heat, water, electric); IEC 13757

### Process automation
- **HART** — analog 4-20 mA loop + 1200 baud Bell 202 superimposed
- **WirelessHART** — 2.4 GHz mesh
- **Foundation Fieldbus H1** — 31.25 kbps; H2 ≈ HSE (Ethernet)
- **ISA100.11a** — wireless industrial

### Energy / utility
- **IEC 61850** — substation automation; GOOSE (L2 multicast), SV (Sampled Values), MMS (TCP)
- **DNP3** — SCADA in utilities (North America)
- **IEC 60870-5-101/-104** — SCADA in utilities (Europe)
- **OpenADR** — demand response

### Automotive — vehicle networks
- **CAN 2.0A (11-bit ID), 2.0B (29-bit)** — up to 1 Mb/s
- **CAN-FD** — flexible data rate; up to 8 Mb/s data phase, 64 B payload
- **CAN-XL** — up to 10 Mb/s, 2048 B payload
- **LIN** — single-wire 1-19.2 kbaud; cheap subnet under CAN
- **FlexRay** — dual-channel 10 Mb/s, static + dynamic slots, time-triggered
- **MOST** — multimedia infotainment ring (legacy)
- **Automotive Ethernet** — 100BASE-T1 / 1000BASE-T1 / 2.5/5/10GBASE-T1
- **SOME/IP** — service-oriented in-vehicle middleware
- **DDS** — used for autonomy stacks (ROS 2 default)
- **TSN (Time-Sensitive Networking)** — automotive + industrial Ethernet QoS

### Automotive — diagnostics
- **OBD-II (ISO 15765-4)** — emissions, mandatory
- **UDS (ISO 14229)** — generic diag services (0x10–0x3E)
- **KWP2000 (ISO 14230)** — predecessor
- **J1939** — heavy-duty (trucks, ag, marine); 29-bit IDs with PGN
- **DoIP (ISO 13400)** — diagnostics over IP

### AUTOSAR (cross-link [18](../18_Embedded_Systems/))
- **Classic Platform** vs **Adaptive Platform** (POSIX-based)
- **PDU, I-PDU, N-PDU**
- **COM stack**, **PduR**, **CanIf**, **CanTp**, **DCM**, **DEM**

### ICS / OT security (cross-link [14](../14_Security/))
- **Purdue Reference Model** — IT/OT zones
- **NERC CIP** — US utility regs
- **ISA/IEC 62443** — industrial cybersecurity standard family
- **IDS for OT** — Claroty, Dragos, Nozomi, Tenable.OT
- **Notable incidents** — Stuxnet (2010), Industroyer (2016), Triton/Trisis (2017), Colonial Pipeline (2021), Industroyer2 (2022), Frostygoop (2024)

---

## Protocols

### What is in this section

```text
  Fieldbus, industrial Ethernet, automotive buses, and OT protocols.

  ┌─── fieldbus (serial) ─────────────────────────────────────────────────┐
  │  Modbus RTU/ASCII · PROFIBUS DP/PA · AS-i · DeviceNet               │
  │  Foundation Fieldbus H1 · CC-Link                                    │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── industrial Ethernet ───────────────────────────────────────────────┐
  │  PROFINET (RT/IRT/TSN) · EtherNet/IP (CIP) · EtherCAT               │
  │  POWERLINK · Sercos III · Modbus TCP · OPC UA (TSN/FX)               │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── automotive & SCADA ────────────────────────────────────────────────┐
  │  CAN 2.0 / CAN-FD / CAN-XL · LIN · FlexRay · MOST                   │
  │  SOME/IP · UDS (ISO 14229) · J1939 · AUTOSAR PDU                    │
  │  DNP3 · IEC 61850 · IEC 60870-5 · KNX · BACnet · DALI / DMX        │
  └──────────────────────────────────────────────────────────────────────┘
```

> Fieldbus, SCADA, and OT-network protocols: Modbus, OPC UA, PROFINET, DNP3.

### Dedicated Protocol References

| File | Covers |
|------|--------|
| [Modbus](modbus.md) | RTU/ASCII/TCP, function codes, register model |
| [OPC UA](opc_ua.md) | Information model, security, PubSub, TSN |

### Fieldbus (serial)

| Protocol | Standard | Notes |
|----------|----------|-------|
| Modbus RTU | Modbus Org (MAP V1.1b3) | RS-485, 1 master / N slaves |
| Modbus ASCII | same | ASCII variant |
| Modbus TCP | same | Port 502 |
| Modbus Secure | RFC 8907-style (TLS) | TLS port 802 |
| PROFIBUS DP | IEC 61158-3-3 / -6-3 | RS-485 |
| PROFIBUS PA | IEC 61158 / IEC 61784 CP3/2 | IS bus |
| AS-i | IEC 62026-2 | Sensor/actuator bus |
| INTERBUS | IEC 61158 CPF6 | Legacy ring |
| DeviceNet | ODVA CIP over CAN | |
| ControlNet | ODVA CIP over coax (legacy) | |
| Foundation Fieldbus H1 | IEC 61158 CPF1 | 31.25 kbps |

### Industrial Ethernet
| Protocol | Owner | Notes |
|----------|-------|-------|
| PROFINET (RT / IRT / TSN) | PI | RT non-IP, IRT real-time, TSN convergent |
| EtherNet/IP | ODVA | CIP over TCP/UDP |
| EtherCAT | ETG | On-the-fly addressing |
| POWERLINK | EPSG | Slot-based |
| Sercos III | IGS | Motion-control |
| CC-Link IE | CLPA | Mitsubishi-led |
| Modbus TCP | Modbus Org | Simple TCP/502 |
| OPC UA (TSN / FX) | OPC Foundation | Field-level OPC UA (UAFX) |

### CANopen / CAN-based
| Protocol | Notes |
|----------|-------|
| CANopen (CiA 301) | Object dict + PDO/SDO |
| CANopen-FD (CiA 1301) | CAN-FD-based |
| SAE J1939 | Heavy-duty vehicle |
| ISOBUS (ISO 11783) | Agriculture |
| NMEA 2000 | Marine |

### Building automation
| Protocol | Spec |
|----------|------|
| BACnet | ASHRAE 135 / ISO 16484-5 |
| BACnet/IP | ASHRAE 135 Annex J |
| BACnet/SC (Secure Connect) | newer over WebSocket+TLS |
| KNX | ISO/IEC 14543-3 |
| LonWorks | ISO/IEC 14908 |
| DALI | IEC 62386 |
| DALI-2 / D4i | DiiA cert |
| DMX512 | ANSI E1.11 |
| RDM (over DMX) | ANSI E1.20 |
| sACN (E1.31) | DMX over IP |
| Art-Net 4 | Artistic Licence |
| M-Bus | EN 13757-2/-3 |
| OPC DA / AE / HDA (Classic) | Microsoft COM/DCOM legacy |

### Process
| Protocol | Spec |
|----------|------|
| HART | FieldComm |
| WirelessHART | IEC 62591 |
| ISA100.11a | IEC 62734 |
| Foundation Fieldbus H1/H2 | IEC 61158 |

### Energy / utility
| Protocol | Spec |
|----------|------|
| IEC 61850 MMS / GOOSE / SV | IEC 61850 |
| DNP3 | IEEE 1815 |
| IEC 60870-5-101 (serial), -104 (TCP) | IEC |
| OpenADR 2.0/3.0 | OpenADR Alliance |

### Semantic / interop
| Protocol | Spec |
|----------|------|
| OPC UA (Binary / HTTPS) | IEC 62541 |
| OPC UA PubSub | IEC 62541-14 |
| MTConnect | ANSI MTC1.4 |
| Sparkplug B | Eclipse Sparkplug WG |

### Automotive — physical / link
| Protocol | Spec |
|----------|------|
| CAN 2.0A/B | ISO 11898-1, -2 |
| CAN-FD | ISO 11898-1:2015 |
| CAN-XL | ISO 11898-1 update |
| LIN | ISO 17987 |
| FlexRay | ISO 17458 |
| MOST 25 / 50 / 150 | MOST Coop. |
| 100/1000/2.5G/5G/10GBASE-T1 | IEEE 802.3 |
| 10BASE-T1S | IEEE 802.3cg |

### Automotive — middleware / app
| Protocol | Spec |
|----------|------|
| SOME/IP, SOME/IP-SD | AUTOSAR |
| DDS-RTPS | OMG |
| TSN (802.1Qbv/Qci/Qbu) | IEEE |

### Automotive — diagnostics
| Protocol | Spec |
|----------|------|
| OBD-II | ISO 15765 / SAE J1979 |
| UDS | ISO 14229 |
| KWP2000 | ISO 14230 |
| J1939 | SAE J1939 family |
| ISO 15765-2 (ISO-TP) | CAN transport |
| DoIP | ISO 13400 |
| XCP | ASAM XCP |

### Cybersecurity standards (cross-link [14](../14_Security/))
| Standard | Scope |
|----------|-------|
| ISA/IEC 62443 | Industrial cybersecurity |
| ISO/SAE 21434 | Automotive cybersec |
| UN R155 / R156 | UNECE vehicle cybersec & SUMS |
| NERC CIP | US bulk electric |
| NIST SP 800-82 | ICS security guide |
