# Devices — Languages

## Nothing here is a programming language

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
  tool consumes them — a simulator, a schematic editor, a fab. Only the
  datasheet is written for a person, and it is the one that governs.
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

## Datasheet "languages"
- **Parameter tables** — V, I, t, C, R, dB values with min/typ/max + conditions
- **I-V / C-V / S-parameter curves**
- **Thermal data** — R_θJA, R_θJC, P_D, SOA (Safe Operating Area)
- **Reliability** — MTBF, MTTF, FIT, mean lifetime under conditions
- **Package drawings** — body dimensions, lead pitch, recommended land pattern
