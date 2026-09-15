# Devices — Topics

## The parts, by what they do

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

## Dedicated topic files

| Topic | File |
|-------|------|
| MOSFET Cross-Section | [mosfet_cross_section.md](mosfet_cross_section.md) — NMOS/PMOS diagrams, CMOS inverter/NAND, FinFET/GAA scaling |

---

## Passive components
- **Resistors** — tolerance, TC, power, noise (E12/E24/E96 series); pull-up/down sizing
- **Capacitors** — ceramic (C0G/X7R/X5R/Y5V), film, electrolytic, tantalum, supercaps; ESR, ESL, derating with V & T
- **Inductors** — wirewound, ferrite, air-core, common-mode chokes; saturation
- **Transformers** — turns ratio, isolation, leakage inductance
- **Crystals & resonators** — load capacitance, ESR, drive level, Pierce oscillator

## Diodes
- **Standard PN** — Si vs Ge; V_f, I_R, t_rr
- **Schottky** — low V_f, fast switching, no t_rr (charge storage)
- **Zener** — voltage reference / clamp; avalanche vs Zener mechanisms
- **TVS** — transient voltage suppression
- **PIN** — RF switch / attenuator
- **Varactor** — voltage-controlled capacitance for VCOs
- **LED** — emission wavelength = f(bandgap); drive with current source, not voltage
- **Laser diode** — population inversion, threshold

## Bipolar transistors (BJT)
- **NPN / PNP**, common-emitter / -collector / -base
- **Operating regions** — cutoff, active (forward), saturation, reverse-active
- **Ebers-Moll / Gummel-Poon** models
- **β (DC current gain)** — temp & I_C dependence
- **V_BE(on) ≈ 0.7 V** rule of thumb
- **Heat issues** — second breakdown, runaway

## FETs
- **JFET vs MOSFET vs MESFET**
- **Enhancement vs depletion mode**
- **NMOS / PMOS / CMOS**
- **Operating regions** — cutoff, triode (linear), saturation; subthreshold (weak inversion)
- **g_m**, **r_o**, **C_GS / C_GD / C_DS**
- **Body effect**, **DIBL**, **short-channel effects**
- **Threshold voltage V_T**, **V_GS(th)** for power FETs
- **R_DS(on)** for power FETs; thermal derating

## Power devices
- **Power MOSFETs** — Q_g charge, R_DS(on), avalanche rating
- **IGBT** — high-voltage switching (motor drives)
- **GaN HEMT** — high freq, low loss switching
- **SiC MOSFETs** — high voltage, high temp

## Optoelectronics
- **LED color vs material** (GaAs, AlGaAs, GaN, etc.)
- **Photodiode**, **PIN photodiode**, **APD**, **phototransistor**
- **Optocoupler / opto-isolator** — isolation barrier
- **Solid-state relay (SSR)**

## MEMS
- **Accelerometer, gyro, magnetometer (IMU)**
- **MEMS microphone**
- **Pressure & flow sensors**

## Packaging
- **Through-hole** — DIP, TO-220, TO-92, TO-3
- **SMD** — 0201/0402/0603/0805/1206, SOT-23, SOIC, SSOP, TSSOP, QFN, DFN, LGA, BGA, WLCSP
- **Power packages** — DPAK, D²PAK, SOT-227, modules
- **Hi-rel** — hermetic, ceramic, military temp rating

## Datasheet literacy
- **Absolute Max Ratings** (never exceed) vs **Recommended Operating Conditions** (design within)
- **SOA** — Safe Operating Area (V·I plane with time)
- **Derating curves** — power vs T
- **Reliability** — MTBF, FIT, HTOL, HAST, MSL

## Cross-link
- Underlying physics → [00_Physics](../../00_Physics/)
- Build into circuits → [00c_Analog_Circuits](../../00c_Analog_Circuits/), [00d_Digital_Circuits](../../00d_Digital_Circuits/)
- Place on a board → [01_Circuit_Board](../../01_Circuit_Board/)
