# Analog Circuits — Manual Pages

Simulation and bench tooling rather than system utilities.

## Four benches

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

## Simulation
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

## Bench / lab
- DMM (Fluke 87V / Keysight U1273A class)
- Oscilloscope (Rigol DHO800/900, Siglent SDS, Keysight DSOX)
- Function generator (Rigol DG, Siglent SDG)
- Bench PSU (Rigol DP832, Korad)
- LCR meter, semiconductor analyzer
- Spectrum analyzer (TinySA, Siglent SSA, Keysight N9000)
- Network analyzer (NanoVNA, Keysight ENA)
- Calibrator / voltage reference

## Layout / EDA
- KiCad (`kicad`, `kicad-cli`)
- Altium Designer (commercial)
- Cadence Allegro / Virtuoso (commercial)
- Eagle (legacy, now Fusion Electronics)

## Mixed-signal
- Verilator (digital), with ADMS adapter for Verilog-AMS
- Cadence AMS Designer
