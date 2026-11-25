# 00b — Devices

> Where physics becomes a part you can solder. Diodes, BJTs, MOSFETs,
> passives. The atomic units of every analog and digital circuit above.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  00c  Analog Circuits                        │
└───────────────────────┬──────────────────────┘
                        │  I-V curves, datasheet parameters
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  00b  Devices                     ◀── here   ┃
┃      diodes · transistors · passives         ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  carrier behaviour in silicon
┌───────────────────────┴──────────────────────┐
│  00  Physics                                 │
└──────────────────────────────────────────────┘
```

## At a glance

| Field | Value |
|-------|-------|
| Description | Discrete and integrated electronic components |
| Languages | SPICE (model cards), Verilog-A (behavioral) |
| Medium / Interface | Datasheet parameters, I-V curves, equivalent models |
| Example | A power MOSFET switches 30 A under PWM gate drive |
| Adjacent | ↓ [00_Physics](../00_Physics/), ↑ [00c_Analog_Circuits](../00c_Analog_Circuits/) |

## What lives here

- **Passives** — resistors, capacitors, inductors, transformers, crystals
- **Diodes** — rectifier, Schottky, Zener, LED, varactor, PIN, TVS
- **Transistors** — BJT (NPN/PNP), JFET, MOSFET (enhancement / depletion, NMOS/PMOS), IGBT
- **Optoelectronics** — LEDs, laser diodes, photodiodes, phototransistors, optocouplers
- **Magnetics** — chokes, common-mode chokes, ferrite beads
- **Power devices** — power MOSFETs, IGBTs, GaN, SiC HEMTs
- **Sensors** — Hall, thermistors (NTC/PTC), RTDs, thermocouples, strain gauges
- **MEMS** — accelerometers, gyros, microphones

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | Sedra-Smith, Razavi, datasheets |
| [Lessons](#lessons) | [Interactive labs](device_labs.md) | model a diode → bias a BJT → MOSFET small-signal |
| [Languages](#languages) | — | SPICE model formats, Verilog-A |
| [Manual Pages](#manual-pages) | — | `ngspice`, KiCad, datasheet tools |
| [Topics](#topics) | [MOSFET Cross-Section and Operation](mosfet_cross_section.md) | characteristics, packaging, derating, SOA |
| [Protocols](#protocols) | — | JEDEC packaging & part numbering |

## Cross-references
- Physical mechanism behind every device → [00_Physics](../00_Physics/)
- How devices combine into circuits → [00c_Analog_Circuits](../00c_Analog_Circuits/), [00d_Digital_Circuits](../00d_Digital_Circuits/)
- IC integration on a board → [01_Circuit_Board](../01_Circuit_Board/)

---

## References

### Where to start, by what you need

```text
  circuits with devices in them
    Sedra & Smith ──▶ Razavi, Fundamentals ──▶ Razavi, Analog CMOS
    undergrad workhorse      teaching order       design, IC-level

  the practical side           Horowitz & Hill, The Art of Electronics
                               (also in 01 Circuit Board's references)

  power                        Mohan, Undeland & Robbins
  sensors                      Pallás-Areny

  Then the material that is not in books at all, which at this layer is
  most of it:

  datasheets    TI · ADI · Infineon · ST · NXP · ON · Microchip
                Nexperia · Diodes Inc · Vishay
  can I buy it  Octopart · DigiKey · Mouser · LCSC · Arrow
  what is in it TechInsights die shots · siliconpr0n.org
  the rules     JEDEC · IPC · AEC-Q100/101/200 ──▶ Protocols, below
```

### Books
- *Microelectronic Circuits* — Sedra & Smith. The undergrad workhorse.
- *Design of Analog CMOS Integrated Circuits* — Behzad Razavi.
- *Fundamentals of Microelectronics* — Razavi.
- *The Art of Electronics* — Horowitz & Hill (also cross-link [01](../01_Circuit_Board/README.md#references))
- *Power Electronics: Converters, Applications, and Design* — Mohan, Undeland, Robbins.
- *Sensors and Signal Conditioning* — Pallás-Areny.

### Datasheet sources
- Vendor sites: TI, Analog Devices, Infineon, ST, NXP, ON Semi, Microchip, Nexperia, Diodes Inc, Vishay
- Aggregators: Octopart, DigiKey, Mouser, LCSC, Arrow
- IC photographs / die shots: chipworks (now TechInsights), siliconpr0n.org

### Standards
- **JEDEC** — package standards (TO-220, SOT-23, DFN, QFN, LGA, BGA)
- **IPC** — assembly standards (IPC-A-610)
- **AEC-Q100/101/200** — automotive qualification

### Online
- AllAboutCircuits — `https://www.allaboutcircuits.com/`
- EEVblog — datasheet teardowns
- Phil's Lab YouTube (analog/RF/mixed signal)

---

## Lessons

### The ladder

```text
  Twelve exercises, almost all of them bench work. The file states no
  prerequisites, so the grouping below is editorial — by what you are
  measuring, not by what must come first.

  1  Read a datasheet        1N4148 · BC547 — before touching anything

  diodes
     2  Diode I-V            first measurement: V_f against I_f
     3  Zener regulator      first circuit that does a job

  transistors
     4  BJT operating regions      cutoff · active · saturation
     5  MOSFET as a switch         low-side LED drive — resistive, no flyback
     6  MOSFET as an amplifier     common-source small-signal gain
     7  Op-amp from transistors    diff pair ─▶ mirror ─▶ output stage
                                   a walkthrough here, built in 00c

  passives and isolation
     8  Inductors            back-EMF on switch-off — why an inductive load,
                             unlike 5's LED, needs a flyback diode
     9  Capacitor types      X7R vs C0G vs Y5V, and when the choice bites
     10  Optocoupler         current ─▶ photon ─▶ current, across a barrier

  off the bench
     11  SPICE a circuit     half-wave rectifier in ngspice — bench to model
     12  Power MOSFET thermal   R_θJA, R_θJC ─▶ junction temp ─▶ heatsink

  Lab: device_labs.md — a MOSFET switch (#5) and a BJT LED driver (#4).
```

### Dedicated lesson modules

| Topic | File |
|-------|------|
| Device interactive labs | [Electronic Devices](device_labs.md) — MOSFET switching, LED driver, transistor biasing |

---

1. **Read a datasheet** — pick a 1N4148 diode and BC547 BJT; identify absolute max, characteristic curves, package.
2. **Diode I-V** — measure V_f vs I_f on a breadboard with a series resistor.
3. **Zener regulator** — build a simple shunt regulator; show load regulation limits.
4. **BJT operating regions** — biasing in cutoff, active, saturation; common-emitter amp.
5. **MOSFET as a switch** — drive an LED with a small NMOS; high vs low-side.
6. **MOSFET as an amplifier** — common-source small-signal gain.
7. **Op-amp from transistors** — concept walkthrough of differential pair → mirror → output stage.
8. **Inductors** — measure inductance; observe back-EMF on switch-off.
9. **Capacitor types in practice** — ceramic (X7R/C0G/Y5V), electrolytic, tantalum, film; when to pick what.
10. **Optocoupler isolated link** — TX side current → photon → RX phototransistor.
11. **SPICE a circuit** — model a half-wave rectifier in ngspice; sweep input freq.
12. **Power MOSFET thermal** — calculate junction temperature with R_θJA, R_θJC; pick a heatsink.

### Suggested external
- Razavi's free YouTube lectures on Fundamentals of Microelectronics
- Phil's Lab + EEVblog on practical analog

---

## Languages

### Nothing here is a programming language

```text
  A device is described, not programmed. Four kinds of description, each
  answering a different question about the same part:

  how does it behave?     SPICE .MODEL / .SUBCKT      → the simulator
  │                       Verilog-A / -AMS
  │                       BSIM4 · BSIM-CMG · PSP · EKV
  │                       Touchstone .sNp (RF S-params)
  │                       IBIS (I/O buffers, signal integrity)
  │
  how does it connect?    SPICE deck .cir / .sp / .net
  │                       KiCad symbol · LTspice .asy       → the schematic
  │
  how big is it?          KiCad footprint · IPC-7351 land   → the board, 01
  │
  what will it survive?   datasheet tables — V, I, t, C, R with min/typ/max
                          curves — I-V, C-V, S-parameters
                          thermal — R_θJA, R_θJC, P_D, SOA
                          reliability — MTBF, FIT, MSL

  The first three are all machine-readable; what separates them is which
  tool consumes them — a simulator, a schematic editor, and PCB CAD, which
  is what turns a footprint into the Gerbers a fab actually receives. Only
  the datasheet is written for a person, and it is the one that governs.
```

| Language / format | Use |
|-------------------|-----|
| SPICE model cards | `.MODEL`, `.SUBCKT` describing device IV behavior |
| Verilog-A | Behavioral analog modeling for compact device models |
| Verilog-AMS | Mixed analog-digital |
| BSIM4 / BSIM-CMG | Industry-standard MOSFET models |
| PSP, EKV | Alternative compact MOSFET models |
| IBIS | I/O Buffer Information Spec — signal-integrity simulation |
| Touchstone (.sNp) | RF S-parameter file format |
| Spice deck (.cir, .sp, .net) | SPICE netlist format |
| KiCad symbol/footprint | Schematic + PCB device representation |
| LTspice .asy / .lib | LTspice symbol + model library |
| JEDEC JEP30 | Part marking & ID standard |

### Datasheet "languages"
- **Parameter tables** — V, I, t, C, R, dB values with min/typ/max + conditions
- **I-V / C-V / S-parameter curves**
- **Thermal data** — R_θJA, R_θJC, P_D, SOA (Safe Operating Area)
- **Reliability** — MTBF, MTTF, FIT, mean lifetime under conditions
- **Package drawings** — body dimensions, lead pitch, recommended land pattern

---

## Manual Pages

SPICE simulators and PCB tools, several of them GUI applications rather than
commands with a man page.

### Two benches, one workflow

```text
  Half of this section is software and half is hardware, and they are the
  same loop run twice — you simulate a part, then you measure whether the
  model was telling the truth.

  ┌─ model ──────────────────────┐        ┌─ measure ────────────────────┐
  │  ngspice · xyce   CLI        │        │  DMM · oscilloscope          │
  │  LTspice          GUI        │        │  function generator          │
  │  vendor SPICE / IBIS libs    │        │  programmable PSU (DP832)    │
  │                              │        │  LCR meter · curve tracer    │
  │  KiCad · kicad-cli           │        │  component tester (Mega328)  │
  │  skidl (schematic in Python) │        │  semiconductor analyzer      │
  └──────────────┬───────────────┘        └───────────────┬──────────────┘
                 │                                        │
                 └──────────────▶  disagree?  ◀───────────┘
                  the model is wrong, or the part is not what it claims

  Octopart sits outside both: it answers "can I still buy this", which no
  simulator and no bench will tell you.
```

| Tool | Purpose |
|------|---------|
| `ngspice` | CLI SPICE simulator |
| LTspice (GUI) | Free SPICE from Analog Devices |
| `xyce` | Sandia parallel SPICE |
| KiCad (GUI) | Schematic capture + PCB + 3D viewer |
| KiCad Symbol/Footprint editor | Build new device representations |
| `python -m skidl` | Schematic-in-Python |
| Octopart API | Cross-vendor part availability/pricing |
| `kicad-cli` | Headless KiCad operations |
| Vendor SPICE libraries | Download IBIS/SPICE models from TI/ADI/etc |

### Bench / lab equipment (not CLI tools but worth listing)
- DMM, oscilloscope, function generator, bench power supply (programmable: Rigol DP832 etc)
- LCR meter, semiconductor curve tracer (e.g., Peak DCA75)
- Hot air station, microscope, soldering iron
- Component testers (e.g., Mega328 transistor tester for quick ID)

---

## Topics

### The parts, by what they do

```text
  Parts grouped by what they do to a signal, then two things that are true
  of every one of them.

  store and shape      passives      R · C · L · transformers · crystals
                                     no control terminal, and no power gain
                                     (a transformer trades volts for amps)

  rectify and clamp    diodes        PN · Schottky · Zener · TVS
                                     PIN · varactor · LED · laser
                                     one junction — and Zener, TVS and
                                     varactor all use the reverse side of it

  amplify and switch   BJT           current-controlled — β, V_BE ≈ 0.7 V
                       FET           voltage-controlled — g_m, V_T, R_DS(on)
                       │             JFET · MOSFET · MESFET
                       └─ power      IGBT · GaN HEMT · SiC ──▶ 00c, 18

  cross domains        optoelectronic  LED · photodiode · APD
                                       optocoupler — the isolation barrier
                       MEMS            IMU · microphone · pressure ──▶ 18

  and two things that are true of every part above:

  packaging            through-hole ─── SMD ─── power ─── hi-rel
                       DIP, TO-220     0201…BGA   DPAK    hermetic

  datasheet literacy   Absolute Max (never exceed)
                       Recommended Operating (design within)
                       SOA · derating curves · MTBF, FIT, MSL

  Detail on the MOSFET itself: mosfet_cross_section.md.
```

### Dedicated topic files

| Topic | File |
|-------|------|
| MOSFET Cross-Section | [MOSFET Cross-Section and Operation](mosfet_cross_section.md) — NMOS/PMOS diagrams, CMOS inverter/NAND, FinFET/GAA scaling |

---

### Passive components
- **Resistors** — tolerance, TC, power, noise (E12/E24/E96 series); pull-up/down sizing
- **Capacitors** — ceramic (C0G/X7R/X5R/Y5V), film, electrolytic, tantalum, supercaps; ESR, ESL, derating with V & T
- **Inductors** — wirewound, ferrite, air-core, common-mode chokes; saturation
- **Transformers** — turns ratio, isolation, leakage inductance
- **Crystals & resonators** — load capacitance, ESR, drive level, Pierce oscillator

### Diodes
- **Standard PN** — Si vs Ge; V_f, I_R, t_rr
- **Schottky** — low V_f, fast switching, no t_rr (charge storage)
- **Zener** — voltage reference / clamp; avalanche vs Zener mechanisms
- **TVS** — transient voltage suppression
- **PIN** — RF switch / attenuator
- **Varactor** — voltage-controlled capacitance for VCOs
- **LED** — emission wavelength = f(bandgap); drive with current source, not voltage
- **Laser diode** — population inversion, threshold

### Bipolar transistors (BJT)
- **NPN / PNP**, common-emitter / -collector / -base
- **Operating regions** — cutoff, active (forward), saturation, reverse-active
- **Ebers-Moll / Gummel-Poon** models
- **β (DC current gain)** — temp & I_C dependence
- **V_BE(on) ≈ 0.7 V** rule of thumb
- **Heat issues** — second breakdown, runaway

### FETs
- **JFET vs MOSFET vs MESFET**
- **Enhancement vs depletion mode**
- **NMOS / PMOS / CMOS**
- **Operating regions** — cutoff, triode (linear), saturation; subthreshold (weak inversion)
- **g_m**, **r_o**, **C_GS / C_GD / C_DS**
- **Body effect**, **DIBL**, **short-channel effects**
- **Threshold voltage V_T**, **V_GS(th)** for power FETs
- **R_DS(on)** for power FETs; thermal derating

### Power devices
- **Power MOSFETs** — Q_g charge, R_DS(on), avalanche rating
- **IGBT** — high-voltage switching (motor drives)
- **GaN HEMT** — high freq, low loss switching
- **SiC MOSFETs** — high voltage, high temp

### Optoelectronics
- **LED color vs material** (GaAs, AlGaAs, GaN, etc.)
- **Photodiode**, **PIN photodiode**, **APD**, **phototransistor**
- **Optocoupler / opto-isolator** — isolation barrier
- **Solid-state relay (SSR)**

### MEMS
- **Accelerometer, gyro, magnetometer (IMU)**
- **MEMS microphone**
- **Pressure & flow sensors**

### Packaging
- **Through-hole** — DIP, TO-220, TO-92, TO-3
- **SMD** — 0201/0402/0603/0805/1206, SOT-23, SOIC, SSOP, TSSOP, QFN, DFN, LGA, BGA, WLCSP
- **Power packages** — DPAK, D²PAK, SOT-227, modules
- **Hi-rel** — hermetic, ceramic, military temp rating

### Datasheet literacy
- **Absolute Max Ratings** (never exceed) vs **Recommended Operating Conditions** (design within)
- **SOA** — Safe Operating Area (V·I plane with time)
- **Derating curves** — power vs T
- **Reliability** — MTBF, FIT, HTOL, HAST, MSL

### Cross-link
- Underlying physics → [00_Physics](../00_Physics/)
- Build into circuits → [00c_Analog_Circuits](../00c_Analog_Circuits/), [00d_Digital_Circuits](../00d_Digital_Circuits/)
- Place on a board → [01_Circuit_Board](../01_Circuit_Board/)

---

## Protocols

Packaging, reliability and handling standards rather than wire protocols —
what a physical device must conform to.

### Who owns which rule

```text
  No wire protocols at this layer. These are the standards a physical part
  must satisfy, and they divide cleanly by who writes them.

  JEDEC ── the part itself
  │  JEP95      package outlines — TO, SOIC, QFN, BGA
  │  JESD22     reliability methods ──▶ MTBF · FIT · HALT/HASS
  │  JESD625    ESD handling
  │  JEP30      part marking
  │
  ├─ IPC ── the part on a board
  │  7351       land patterns ──▶ the footprint in Languages
  │  J-STD-001  soldering
  │  J-STD-020  moisture sensitivity ──▶ MSL 1 (unlimited) … 6 (bake first)
  │             — jointly IPC and JEDEC, the one row that is not either/or
  │  A-610      assembly acceptability
  │
  └─ AEC ── the part in a car
     Q100 (IC) · Q101 (discrete) · Q200 (passive)
     Grade 0 (−40…+150 °C) ─── Grade 3 (−40…+85 °C)

  Compact models (BSIM4 · BSIM-CMG · PSP · EKV · VBIC · HICUM · MEXTRAM)
  are a separate standards family — they describe behaviour, not the
  object, and they are what Languages feeds to a simulator.
```

### Packaging
| Standard | Owner | Scope |
|----------|-------|-------|
| JEDEC JEP95 | JEDEC | Package outline drawings (TO, SOIC, QFN, BGA, etc.) |
| JEDEC JESD22 | JEDEC | Component reliability test methods |
| JEDEC JESD625 | JEDEC | ESD handling |
| IPC-A-610 | IPC | Acceptability of electronic assemblies |
| IPC-7351 | IPC | Land pattern naming |
| IPC J-STD-001 | IPC | Soldering requirements |
| IPC/JEDEC J-STD-020 | IPC + JEDEC (joint) | Moisture Sensitivity Level (MSL) |
| AEC-Q100/101/200 | AEC | Automotive qualification (IC / discrete / passive) |

### Compact device models
| Model | Used for |
|-------|----------|
| BSIM4 / BSIM6 | Bulk MOSFET |
| BSIM-CMG | FinFET / GAAFET |
| PSP | MOSFET (industry alt) |
| EKV | MOSFET (analog-friendly) |
| VBIC | BJT |
| HICUM | BJT (high-frequency) |
| MEXTRAM | BJT |

### Standardized part numbering / marking
- **1N4148**, **2N2222**, **2SC1815** — JIS / EIA part conventions
- **JEDEC JEP30** — part marking

### Reliability metrics
- **MTBF / MTTF** — mean time between/to failure
- **FIT** — Failures In Time (1 FIT = 1 failure per 10⁹ device-hours)
- **MSL** — Moisture Sensitivity Level (1 = unlimited, 6 = mandatory bake before use)
- **HALT / HASS** — Highly Accelerated Life / Stress Testing
- **AEC-Q grades** — Grade 0 (–40 to +150 °C) to Grade 3 (–40 to +85 °C)

### Cross-link
- Wire-level bus protocols → [Circuit Board › Protocols](../01_Circuit_Board/README.md#protocols)
- IC enumeration by the OS → [04_Device_Drivers](../04_Device_Drivers/)
