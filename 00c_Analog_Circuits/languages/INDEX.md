# Analog Circuits — Languages

## One netlist, four descendants

```text
  Everything in the first group is Berkeley SPICE or a child of it. The
  split that matters is what each one can represent.

  SPICE (Berkeley, 1973)          netlist + transient / AC / DC
  │
  ├─ ngspice · gnucap             open-source, CLI
  ├─ LTspice                      free, GUI, ADI's model library
  └─ Spectre · PSpice             commercial, production sign-off
        │
        └─ behaviour instead of components, when the netlist is too slow:
           Verilog-A ─── Verilog-AMS ─── VHDL-AMS
           analog only  mixed signal     VHDL's analog extension

  Above the circuit, where you stop drawing parts and start drawing blocks:

    MATLAB / Simulink · Octave          system-level, control loops
    Python — scipy.signal, control      filter design, Bode, root locus

  And two interchange formats that carry measured behaviour rather than a
  model of it — Touchstone .sNp (S-parameters, → 16 RF) and IBIS (I/O
  buffers for signal integrity, → 01 Circuit Board).

  Schematic capture — KiCad · Altium · OrCAD — feeds all of the above.
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
