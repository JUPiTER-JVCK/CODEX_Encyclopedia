# Physics — Languages

Mostly math + simulation tooling — physics speaks math first.

## Two kinds of tool

```text
  you write the maths                         you run the maths
  ◀──────────────── symbolic ── numerical ────────────────▶

  SymPy · Mathematica      Sage       Julia · Python + NumPy/SciPy
  Maple · LaTeX                       MATLAB / Octave

  and then the solvers. None is general; each owns one domain:

  ┌────────────┬─────────────┬──────────────┬────────────┬────────────┐
  │ circuits   │ EM fields   │ multiphysics │ materials  │ quantum    │
  ├────────────┼─────────────┼──────────────┼────────────┼────────────┤
  │ SPICE      │ Meep (FDTD) │ COMSOL       │ Quantum    │ Qiskit     │
  │ ngspice    │ HFSS        │ ANSYS        │ ESPRESSO   │ Cirq       │
  │ LTspice    │ Maxwell     │ Elmer        │ VASP · ASE │ PennyLane  │
  │ → 00c, 01  │ → 16 RF     │ (FEM)        │ (DFT)      │ → 15 AI/ML │
  └────────────┴─────────────┴──────────────┴────────────┴────────────┘
```

| Language / tool | Use |
|-----------------|-----|
| Mathematics (the language) | Vector calc, complex analysis, linear algebra, PDEs |
| MATLAB / Octave | Numerical PDEs, FEM/FDTD, control |
| Python + NumPy/SciPy | General numerical work |
| SymPy / Mathematica / Maple | Symbolic computation |
| Julia | High-performance numerical PDE / DiffEq |
| Sage | CAS for mathematical research |
| LaTeX | Writing physics — equations, figures, papers |

## Simulation languages / formats
| Tool | Domain |
|------|--------|
| SPICE / ngspice / LTspice | Circuit simulation (analog) |
| COMSOL Multiphysics | Multiphysics FEM (commercial) |
| ANSYS HFSS / Maxwell | RF & EM FEM (commercial) |
| Meep / MEEP-FDTD | Open-source FDTD electromagnetics |
| GNU Radio (sim) | DSP / RF baseband |
| Atomistic Simulation Environment (ASE) | DFT / molecular |
| Quantum ESPRESSO / VASP | Density Functional Theory |
| Qiskit / Cirq / PennyLane | Quantum computing simulation |
