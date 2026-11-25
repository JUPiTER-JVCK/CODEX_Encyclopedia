# 00c — Analog Circuits

> Continuous-valued signals shaped, amplified, filtered, converted. The world
> is analog; digital is a convention enforced by clean voltage thresholds.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  00d  Digital Circuits                       │
└───────────────────────┬──────────────────────┘
                        │  voltage / current waveforms
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  00c  Analog Circuits             ◀── here   ┃
┃      amplifiers · filters · power · signals  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  I-V curves, datasheet parameters
┌───────────────────────┴──────────────────────┐
│  00b  Devices                                │
└──────────────────────────────────────────────┘
```

## At a glance

| Field | Value |
|-------|-------|
| Description | Circuits whose signals are continuous in voltage/current and time |
| Languages | SPICE, MATLAB/Simulink, Verilog-AMS |
| Medium / Interface | Voltage / current / charge waveforms |
| Example | An op-amp instrumentation amplifier conditions a thermistor for an ADC |
| Adjacent | ↓ [00b_Devices](../00b_Devices/), ↑ [00d_Digital_Circuits](../00d_Digital_Circuits/), [01_Circuit_Board](../01_Circuit_Board/) |

## What lives here
- **Amplifiers** — op-amp configurations, instrumentation amps, audio, RF LNAs / PAs
- **Filters** — passive (RC/LC), active (Sallen-Key, MFB), switched-capacitor
- **Oscillators & PLLs** — Pierce, Colpitts, VCO + PLL synthesis
- **Voltage / current references** — bandgap, Zener, Vbe-based
- **Regulators** — LDO, switching (buck/boost/buck-boost/flyback/forward)
- **ADC / DAC** — flash, SAR, ΣΔ, pipeline, R-2R, current-steering
- **Comparators, sample-and-hold, mixers, modulators/demodulators**
- **Sensor interfaces** — Wheatstone bridge, current sense, capacitive touch

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — |  |
| [Lessons](#lessons) | [Interactive labs](analog_labs.md) |  |
| [Languages](#languages) | — |  |
| [Manual Pages](#manual-pages) | — |  |
| [Topics](#topics) | [Op-Amp Configurations](opamp_configurations.md) |  |
| [Protocols](#protocols) | — |  |

## Cross-references
- Where the analog signal eventually becomes a 0/1 → [00d_Digital_Circuits](../00d_Digital_Circuits/)
- RF analog front-ends → [16_RF_Wireless](../16_RF_Wireless/)
- DSP after digitization → [00d](../00d_Digital_Circuits/README.md#topics) + [02_CPU](../02_CPU/README.md#topics) SIMD

---

## References

### Where to start, by what you are designing

```text
  general            Horowitz & Hill, The Art of Electronics
                     the one book that is worth owning before any other

  op-amps            Mancini, Op Amps for Everyone (TI, free PDF)
                     └─ ADI, Linear Circuit Design Handbook

  IC-level analog    Razavi, Analog CMOS
                     └─ Gray, Hurst, Lewis & Meyer — the graduate text

  power              Maniktala, Switching Power Supplies A to Z
                     └─ TI Power Topologies handbook

  PLLs               Best, Phase-Locked Loops

  Application notes are not a lesser source at this layer — they are where
  the field actually documents itself. The Linear Technology catalog under
  Jim Williams and Bob Pease, the Maxim/ADI tutorial archive, and the LT
  Journal back issues answer questions no textbook takes on.
```

### Books
- *The Art of Electronics* — Horowitz & Hill. Indispensable.
- *Design of Analog CMOS Integrated Circuits* — Behzad Razavi.
- *Analysis and Design of Analog Integrated Circuits* — Gray, Hurst, Lewis, Meyer.
- *Op Amps for Everyone* — Ron Mancini (TI, free PDF).
- *Linear Circuit Design Handbook* — Analog Devices.
- *Switching Power Supplies A to Z* — Sanjaya Maniktala.
- *Phase-Locked Loops: Design, Simulation, and Applications* — Roland Best.

### Application notes (gold mines)
- Analog Devices Linear Tech app notes (the Bob Pease / Jim Williams catalog)
- TI Power Topologies handbook
- Maxim/ADI tutorials archive
- LT Journal of Analog Innovation (archived issues)

### Online
- Designing Analog Chips (book by Hans Camenzind, free)
- Razavi's IEEE Solid-State Circuits Magazine columns
- Phil's Lab — practical mixed-signal
- All About Circuits

---

## Lessons

### The ladder

```text
  Twelve exercises. The file states no prerequisites; the grouping below is
  editorial. #1 is the op-amp, and #2 and #3 are built out of it — but much
  of what follows is not: a passive LC filter, a ring oscillator and an R-2R
  ladder contain no amplifier at all.

  amplifiers
     1  Op-amp basics        inverting · non-inverting · buffer · summer
     2  Sallen-Key filter    2nd-order low-pass at 1 kHz, measure rolloff
     3  Instrumentation amp  3-op-amp INA from discretes, high CMRR

  power
     4  Voltage reference    bandgap ─▶ LM385 / LM4040
     5  LDO                  C_in/C_out, dropout, thermal limits
     6  Buck converter       L, C_out, duty · CCM vs DCM · loop comp

  frequency and conversion
     7  PLL fundamentals     detector + LPF + VCO · lock vs capture range
     8  ADC sampling         Nyquist · aliasing · anti-alias · SAR vs ΣΔ
     9  DAC reconstruction   sinc roll-off, reconstruction filter

  output stages
     10  Audio amp           Class A/B/AB/D — THD against efficiency
     11  RF LNA              noise figure · IP3 · S-parameters  → 16 RF

  12  Mixed-signal layout pitfalls    ground bounce · decoupling · return
      paths — the one that ruins any of the eleven above  → 01 Circuit Board

  Lab: analog_labs.md covers 1, 2 and 8 (op-amp, active filter, sampling).
```

### Dedicated lesson modules

| Topic | File |
|-------|------|
| Analog interactive labs | [Analog Circuits interactive labs](analog_labs.md) — Op-amp, active filter, ADC sampling |

---

1. **Op-amp basics** — inverting, non-inverting, buffer, summer, differential amp; "golden rules".
2. **Sallen-Key filter** — design a 2nd-order low-pass at 1 kHz; measure rolloff.
3. **Instrumentation amplifier** — 3-op-amp INA from discretes; high CMRR.
4. **Voltage reference** — bandgap concept; LM385 / LM4040 in practice.
5. **LDO design** — pick C_in/C_out, calc dropout, thermal limits.
6. **Buck converter** — pick L, C_out, D; CCM vs DCM; loop comp basics.
7. **PLL fundamentals** — phase detector + LPF + VCO; lock range vs capture range.
8. **ADC sampling** — Nyquist, aliasing, anti-alias filtering; SAR vs ΣΔ tradeoffs.
9. **DAC reconstruction** — sinc roll-off, reconstruction filter.
10. **Audio amp** — Class A vs B vs AB vs D; THD vs efficiency.
11. **RF LNA** — noise figure, IP3, S-parameters intro.
12. **Mixed-signal layout pitfalls** — ground bounce, supply decoupling, return paths.

### Suggested external
- TI Precision Labs (free video course library)
- Jim Williams' app notes (LT AN-1, AN-47, AN-65)

---

## Languages

### One netlist, four descendants

```text
  The first group is SPICE and the simulators that read its netlists —
  component-level circuits, solved numerically. Not all are Berkeley
  descendants: gnucap and Spectre were written independently and are
  SPICE-*compatible* rather than SPICE-derived. The behavioural languages
  under them are a separate family again, for describing what a block *does*
  when simulating what it is made of costs too much.

  SPICE (Berkeley, 1973)          netlist + transient / AC / DC
  │
  ├─ ngspice                      open-source, a direct descendant
  ├─ LTspice · PSpice             free / commercial, SPICE-derived
  └─ gnucap · Spectre             independent engines, SPICE-compatible
        │
        └─ behaviour instead of components, when the netlist is too slow.
           Three separate languages, not three versions of one:

             Verilog-A      analog only, Verilog-derived
             Verilog-AMS    mixed signal, Verilog-derived
             VHDL-AMS       VHDL's own analog extension, unrelated lineage

  Above the circuit, where you stop drawing parts and start drawing blocks:

    MATLAB / Simulink · Octave          system-level, control loops
    Python — scipy.signal, control      filter design, Bode, root locus

  And two interchange formats that carry behaviour rather than topology —
  Touchstone .sNp (S-parameters, measured or simulated, → 16 RF) and IBIS
  (a behavioural I/O-buffer model for signal integrity, → 01 Circuit Board).

  Schematic capture — KiCad · Altium · OrCAD — produces the netlist the
  first group reads. It feeds nothing else here.
```

| Tool / language | Use |
|-----------------|-----|
| SPICE (Berkeley) | Foundational netlist + transient/AC/DC sim |
| ngspice | Open-source SPICE descendant |
| LTspice | Free SPICE GUI from Analog Devices |
| Cadence Spectre / PSpice | Commercial production SPICE |
| Verilog-AMS / Verilog-A | Behavioral / mixed analog-digital |
| VHDL-AMS | VHDL analog extension |
| MATLAB / Simulink | System-level analog modeling |
| Python (scipy.signal, control) | Filter design, control loops |
| Octave | Free MATLAB alt |
| KiCad / Altium / OrCAD | Schematic capture for analog design |
| Touchstone (.sNp) | S-parameter exchange (RF) |
| IBIS | Buffer behavior for SI/PI sim |

---

## Manual Pages

Simulation and bench tooling rather than system utilities.

### Four benches

```text
  Analog work moves left to right across these, and back again whenever the
  measurement disagrees with the model.

  simulate            lay out             build            measure
  ─────────           ─────────           ─────            ────────
  ngspice · xyce      KiCad               iron · hot air   DMM
  gnucap · qucs-s     kicad-cli           rework station   oscilloscope
  LTspice             Altium              microscope       function gen
  Spectre · PSpice    Allegro · Virtuoso                   bench PSU
                      Eagle (legacy)                       LCR meter
  MATLAB/Simulink                                          spectrum an.
  octave                                                   VNA
  scipy.signal                                             calibrator
  python-control
  lcapy (symbolic)

        └──────────────────── disagreement ────────────────────┘
              which is the useful output of the whole loop

  Mixed-signal lives entirely in the first column and is its own problem:
  the two halves are an analog engine and a digital one, not simulation and
  layout. Cadence AMS Designer runs both together; the open route is a
  co-simulation harness wiring a digital simulator to an analog one. ADMS is
  not that — it compiles a Verilog-A compact model into simulator source,
  which builds the analog half rather than running both.
```

### Simulation
| Tool | Purpose |
|------|---------|
| `ngspice` | CLI SPICE |
| `xyce` | Sandia parallel SPICE |
| `gnucap` | GNU circuit analysis |
| `qucs-s` | Qt SPICE GUI |
| LTspice | ADI free SPICE GUI |
| Cadence Spectre | Commercial |
| PSpice | OrCAD commercial |
| MATLAB / Simulink | Modeling |
| `octave` | Free MATLAB-like |
| Python: `scipy.signal`, `python-control`, `lcapy` | Filter / control / symbolic |

### Bench / lab
- DMM (Fluke 87V / Keysight U1273A class)
- Oscilloscope (Rigol DHO800/900, Siglent SDS, Keysight DSOX)
- Function generator (Rigol DG, Siglent SDG)
- Bench PSU (Rigol DP832, Korad)
- LCR meter, semiconductor analyzer
- Spectrum analyzer (TinySA, Siglent SSA, Keysight N9000)
- Network analyzer (NanoVNA, Keysight ENA)
- Calibrator / voltage reference

### Layout / EDA
- KiCad (`kicad`, `kicad-cli`)
- Altium Designer (commercial)
- Cadence Allegro / Virtuoso (commercial)
- Eagle (legacy, now Fusion Electronics)

### Mixed-signal
- Verilator (digital), with ADMS adapter for Verilog-AMS
- Cadence AMS Designer

---

## Topics

### The blocks, and what they are made of

```text
  The op-amp is the recurring building block rather than a universal one —
  passive LC filters, ring and LC oscillators and R-2R DACs contain none.
  Where a block really is assembled from the ones above, the line below it
  says so.

  op-amps            ideal rules ─▶ real limits (GBW, SR, V_OS, CMRR)
  │                  configurations · stability · INA · chopper
  │                  detail: opamp_configurations.md
  │
  ├─▶ filters        Butterworth · Chebyshev · Bessel · elliptic
  │                  as Sallen-Key · MFB · state-variable · biquad · SC
  │
  ├─▶ references     bandgap · Zener · XFET — TC in ppm/°C
  │                  needed by anything that regulates or converts; a
  │                  passive filter or free-running oscillator needs none
  │
  ├─▶ signal cond.   bridge · current sense · thermocouple · TIA · touch
  │                  = op-amp + reference, pointed at a sensor
  │
  ├─▶ power mgmt     LDO · buck/boost/SEPIC/flyback/bridge
  │                  CCM vs DCM · voltage vs current mode · Type II/III
  │                  charge pumps · harvesting · battery CC/CV
  │                  a closed-loop switcher is reference + error amp +
  │                  a switch; an LDO uses a pass element instead, and an
  │                  open-loop charge pump neither                ──▶ 00b
  │
  ├─▶ oscillators    Pierce · Colpitts · ring · VCO
  │   & PLLs         detector + charge pump + loop filter + divider
  │                  integer-N · fractional-N · jitter & phase noise
  │
  ├─▶ data conv.     ADC  flash · SAR · pipeline · ΣΔ · dual-slope
  │                  DAC  R-2R · current-steering · segmented · ΣΔ
  │                  specs INL/DNL · SNR · SFDR · ENOB
  │                  an ADC is reference + comparator + a clock; a DAC has
  │                  no comparator, and either may take its clock from
  │                  outside rather than from the PLL above     ──▶ 00d
  │
  ├─▶ audio          Class A/AB/B/D · THD, IMD · codec ICs
  └─▶ RF analog      LNA · mixer · PA · balun          ──▶ 16 RF
```

### Dedicated topic files

| Topic | File |
|-------|------|
| Op-Amp Configurations | [Op-Amp Configurations](opamp_configurations.md) — inverting, non-inverting, buffer, summing, differential, instrumentation, integrator, filters |

---

### Op-amps
- **Ideal op-amp rules** — infinite gain, infinite Z_in, zero Z_out
- **Real-world** — finite GBW, slew rate, input offset, input bias/offset current, CMRR, PSRR
- **Standard configurations** — inverting, non-inverting, buffer, summer, differential, integrator, differentiator, transimpedance
- **Stability** — phase margin, gain margin, dominant-pole compensation
- **Instrumentation amps**, **chopper amps**, **autozero**
- **Rail-to-rail input/output**

### Filters
- **Topologies** — Butterworth, Chebyshev (I/II), Bessel, elliptic
- **Realizations** — passive RC/LC, Sallen-Key, MFB, state-variable, biquad, switched-capacitor
- **Notch / band-stop**
- **Filter design from spec** — order from atten + transition; pole-zero placement

### Voltage / current references
- **Bandgap reference** — Vbe + ΔVbe; temp coefficient
- **Zener-based**, **XFET**, **floating-gate**
- **Precision spec** — initial accuracy, TC (ppm/°C), drift, noise

### Power management
- **Linear regulators (LDO)** — dropout, PSRR, transient response, stability with output cap
- **Switching converters**:
  - **Topology**: buck, boost, buck-boost, SEPIC, Ćuk, flyback, forward, push-pull, half/full bridge
  - **Mode**: CCM vs DCM, PWM vs PFM
  - **Control**: voltage-mode, current-mode, COT, hysteretic
  - **Loop compensation** — Type II/III, transfer functions, bode plots
- **Charge pumps**
- **Energy harvesting** — TEG, PV, vibration, RF
- **Battery management** — Li-ion charging stages (CC/CV), gas gauges, protection

### Oscillators & PLLs
- **Crystal oscillators** — Pierce, Colpitts, Hartley
- **RC oscillators** — relaxation, ring
- **VCO** — varactor-tuned LC, ring
- **PLL** — phase detector, charge pump, loop filter, divider
- **Frequency synthesis** — integer-N, fractional-N
- **Jitter & phase noise**

### Data converters
- **ADC architectures**:
  - **Flash** — fast, low res, high power
  - **SAR** — balanced, 8–18 bit
  - **Pipeline** — high speed, medium res
  - **ΣΔ (Sigma-Delta)** — high res, oversampling
  - **Dual-slope integrating** — high accuracy, slow (DMMs)
- **DAC architectures** — R-2R ladder, current-steering, segmented, ΣΔ
- **Key specs** — INL, DNL, SNR, SFDR, ENOB, THD, settling time
- **Sampling theory** — Nyquist, aliasing, oversampling, dithering, decimation

### Signal conditioning
- **Wheatstone bridge** — strain, RTDs
- **Current sense** — high-side vs low-side, shunt + amp
- **Thermocouple** — cold-junction compensation, linearization
- **Capacitive touch** — self / mutual cap
- **Photodiode** — transimpedance amp, dark current

### Audio
- **Class A / AB / B / D** amps
- **THD, IMD, SNR, dynamic range**
- **Codec ICs** — combined ADC+DAC

### RF analog (cross-link)
- **LNA**, **mixer**, **PA**, **VCO**, **filter**, **balun** → [RF / Wireless › Topics](../16_RF_Wireless/README.md#topics)

### Mixed-signal layout pitfalls
- **Ground plane partitioning** (when not to split)
- **Star vs Kelvin connections**
- **Bypassing** — bulk + HF caps, where to place
- **Return-current paths** — under high-speed traces
- **Crosstalk** — guard rings/traces

### Cross-link
- Components → [00b_Devices](../00b_Devices/)
- The other side of A/D boundary → [00d_Digital_Circuits](../00d_Digital_Circuits/)

---

## Protocols

Analog deals with *measurements* more than *protocols*. The "specs" here are
the standardized characterizations and audio/video formats that sit on top of
analog signals.

### Specifications, not protocols

```text
  The first half of this section is not negotiated on anything — it is the
  agreed vocabulary for saying how good a part is, clustered by what it
  measures. The power-supply rules after it include two that genuinely do
  negotiate.

  how faithful is the amplifier?      GBW · SR · V_OS · I_B/I_OS
  │                                   CMRR · PSRR · THD+N · e_n · i_n
  │
  how faithful is the conversion?     INL/DNL · SNR · SFDR · ENOB
  │                                   THD · settling time
  │   both feed ──▶
  ├─ audio levels      dBu · dBV · +4 dBu pro vs −10 dBV consumer
  │                    PCM · DSD (1-bit ΣΔ) · Dolby · THX
  │                    ──▶ digital transport is 13 Network Application
  │
  └─ RF figures        VSWR · return loss · NF · P1dB · IP2/IP3
                       carried in Touchstone .sNp    ──▶ 16 RF

  Separately, the rules a power supply has to obey — these *are* binding,
  and two of them genuinely negotiate:

    negotiated    USB-PD (USB-IF) · Qi (WPC)
    conformance   ATX 12VO / 3.x ──▶ 01 Circuit Board
    safety        IEC 60950-1 ──▶ 62368-1
    emissions     EN 55032/55035 · FCC Part 15 Subpart B
    efficiency    80 PLUS · Energy Star · DOE Level VI
```

### Op-amp / amplifier specs (industry-standard parameters)
| Parameter | Unit | Means |
|-----------|------|-------|
| GBW | MHz | Gain-bandwidth product |
| SR | V/μs | Slew rate |
| V_OS | mV / μV | Input offset voltage |
| I_B / I_OS | nA / pA | Input bias / offset current |
| CMRR | dB | Common-mode rejection ratio |
| PSRR | dB | Power-supply rejection ratio |
| THD+N | % or dB | Total harmonic distortion + noise |
| e_n | nV/√Hz | Input voltage noise density |
| i_n | pA/√Hz | Input current noise density |

### Data-converter specs
| Parameter | Unit | Means |
|-----------|------|-------|
| INL / DNL | LSB | Integral / differential nonlinearity |
| SNR | dB | Signal-to-noise ratio |
| SFDR | dBc | Spurious-free dynamic range |
| ENOB | bits | Effective number of bits |
| THD | dB | Total harmonic distortion |
| Settling time | ns | To 0.5 LSB |

### Audio standards (analog domain)
- **dBu, dBV, dBV(A)** — voltage references
- **+4 dBu pro** vs **−10 dBV consumer** line level
- **THX**, **Dolby**, **DSD (1-bit ΣΔ)**, **PCM** (digital but tightly linked to ADC/DAC)

### Power-supply standards / safety
- **ATX 12VO / ATX 3.x** — PC PSU specs (cross-link [01](../01_Circuit_Board/))
- **USB-PD (USB-IF)** — Power Delivery negotiation
- **Qi (WPC)** — wireless power
- **IEC 60950-1 / 62368-1** — equipment safety
- **EN 55032/55035, FCC Part 15 Subpart B** — EMC
- **80 PLUS** — efficiency certification
- **Energy Star**, **DOE Level VI** — external PSU efficiency

### RF analog (cross-link)
- **Touchstone .sNp** for S-parameter exchange
- **VSWR**, **Return Loss**, **NF**, **IP3/IP2/P1dB** — RF metrics

### Cross-link
- Digital transport of digitized audio/video → [Network Application › Protocols](../13_Network_Application/README.md#protocols)
- Power & signal integrity → [Circuit Board › Topics](../01_Circuit_Board/README.md#topics)
