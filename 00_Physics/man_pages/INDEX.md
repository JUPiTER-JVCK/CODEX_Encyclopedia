# Physics — Manual Pages

Simulators rather than system utilities — the tooling at this layer is solvers
you install, not commands the OS ships.

## What solves what

```text
  Solvers, not system utilities — you install these, the OS does not ship
  them. Grouped by the equation each one is actually discretising.

  lumped circuits          ngspice · xyce · gnucap · qucs-s
    modified nodal analysis, time and frequency domain

  fields in space          meep · lumerical
    FDTD — Maxwell on a grid, stepped in time

  coupled physics          comsol · elmer
    FEM — needs a mesh                    gmsh ──▶ both of these

  quantum computing        qiskit · cirq · pennylane
    circuits and algorithms, not atoms — the DFT codes that compute bands
    (Quantum ESPRESSO, VASP, with ASE orchestrating rather than solving)
    are in languages/, not in this table

  the maths itself         sympy (symbolic) · octave (numeric)

  and one that is neither  units — `echo "1 eV" | units -t J`

  Numeric values for the constants below are in this file's second table;
  the laws they appear in are in protocols/INDEX.md.
```

| Tool | Purpose |
|------|---------|
| `ngspice` | Open-source SPICE circuit simulator |
| `xyce` | Sandia parallel SPICE-class simulator |
| `gnucap` | GNU Circuit Analysis Package |
| `qucs-s` | Qt-based SPICE GUI |
| `meep` | Open FDTD electromagnetics (MIT) |
| `lumerical` (commercial) | Photonics FDTD |
| `comsol` (commercial) | Multiphysics FEM |
| `gmsh` | Mesher used by many FEM codes |
| `elmer` | Open-source multiphysics FEM |
| `python3 -c "import sympy"` | Symbolic math |
| `qiskit` / `cirq` / `pennylane` | Quantum SDK CLIs |
| `units` | Unit conversion (GNU) |
| `octave` | Open MATLAB-compatible |

## Physical constants quick-ref
| Symbol | Name | Value |
|--------|------|-------|
| `c` | Speed of light | 2.998 × 10⁸ m/s |
| `e` | Elementary charge | 1.602 × 10⁻¹⁹ C |
| `h` | Planck | 6.626 × 10⁻³⁴ J·s |
| `ħ = h/2π` | Reduced Planck | 1.055 × 10⁻³⁴ J·s |
| `k` | Boltzmann | 1.381 × 10⁻²³ J/K |
| `kT @ 300 K` | Thermal energy | 4.14 × 10⁻²¹ J ≈ 25.85 meV |
| `kT/q @ 300 K` | Thermal voltage Vₜ | 25.85 mV |
| `ε₀` | Vacuum permittivity | 8.854 × 10⁻¹² F/m |
| `μ₀` | Vacuum permeability | 1.257 × 10⁻⁶ H/m |
| `Z₀ = √(μ₀/ε₀)` | Free-space impedance | 376.7 Ω |

Reference for `units` command: `echo "1 eV" | units -t "J"` → `1.602e-19`.
