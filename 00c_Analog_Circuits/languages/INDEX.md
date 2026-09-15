# Analog Circuits — Languages

## One netlist, four descendants

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
