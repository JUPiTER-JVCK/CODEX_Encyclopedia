# Analog Circuits — Manual Pages

Simulation and bench tooling rather than system utilities.

## Four benches

```text
  Analog work moves left to right across these, and back again whenever the
  measurement disagrees with the model.

  simulate            lay out             build            measure
  ─────────           ─────────           ─────            ────────
  ngspice · xyce      KiCad               the board        DMM
  gnucap · qucs-s     kicad-cli                            oscilloscope
  LTspice             Altium                               function gen
  Spectre · PSpice    Allegro · Virtuoso                   bench PSU
                      Eagle (legacy)                       LCR meter
  MATLAB/Simulink                                          spectrum an.
  octave                                                   VNA
  scipy.signal                                             calibrator
  python-control
  lcapy (symbolic)

        └──────────────────── disagreement ────────────────────┘
              which is the useful output of the whole loop

  Mixed-signal spans the first two columns and is its own problem:
  Verilator for the digital half, ADMS for Verilog-AMS, or Cadence AMS
  Designer for both at once.
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
