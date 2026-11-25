# 00 — Physics (Foundations)

> The base layer beneath everything in the codex. Charges, fields, photons,
> quanta, thermodynamics — the rules that semiconductors, transistors, and
> ultimately CPUs are obeying when they compute.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  00b  Devices                                │
└───────────────────────┬──────────────────────┘
                        │  carrier behaviour in silicon
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  00  Physics                      ◀── here   ┃
┃      charges · fields · quanta · heat        ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

## At a glance

| Field | Value |
|-------|-------|
| Description | Physical laws underlying electronic computation |
| Languages | Math (calculus, linear algebra), MATLAB/Python for sim |
| Medium / Interface | Reality |
| Example | Electron drift in a doped silicon channel under an applied gate voltage |
| Adjacent | ↑ [00b_Devices](../00b_Devices/) |

## What lives here

- **Classical electromagnetism** — Maxwell's equations, fields, waves, transmission lines
- **Solid-state physics** — band theory, doping, p-n junctions, carrier transport
- **Quantum mechanics** (just the parts you need) — tunneling, energy bands, photon emission
- **Thermodynamics & statistical mechanics** — kT, Boltzmann, Johnson-Nyquist noise
- **Optics & photonics** — fiber propagation, photodetectors, lasers
- **Information theory & physical limits** — Landauer limit, Shannon capacity

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | Griffiths, Kittel, Sze, Feynman |
| [Lessons](#lessons) | [Interactive labs](physics_labs.md) | from E&M → semiconductor physics → quantum tunneling |
| [Languages](#languages) | — | math + simulation languages |
| [Manual Pages](#manual-pages) | — | SPICE, COMSOL, FDTD tools |
| [Topics](#topics) | — | concepts mapped to what they enable in hardware |
| [Protocols](#protocols) | — | N/A here (physics has laws, not protocols) — see units/constants |

## Cross-references
- The first place these laws become a component → [00b_Devices](../00b_Devices/)
- Where signals become information → [00c_Analog_Circuits](../00c_Analog_Circuits/)
- RF propagation in air → [16_RF_Wireless](../16_RF_Wireless/README.md#topics)
- Cryptographic randomness from physical sources → [Security › Topics](../14_Security/README.md#topics)
- Quantum crypto (migrated from the v1 encryption notes)

## Layer ladder

This layer is the bottom rung of the whole codex — every compute layer above
resolves, eventually, to something happening here:

```text
  08  User Applications
  07  Runtime Environment
  06  System Libraries
  05  OS Kernel
  04  Device Drivers
  03  Firmware / BIOS
  02  CPU
  01  Circuit Board          ◀── the board the rest of this ladder sits on
 00d  Digital Circuits
 00c  Analog Circuits
 00b  Devices
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  00  Physics                      ◀── here   ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

The prose version of this ladder used to read *Architecture →
Microarchitecture → Logic → Digital Circuits → Analog Circuits → Devices →
Physics*, which was the naming of a reference diagram rather than of this
codex, and which left out **01 Circuit Board** entirely. The rungs above are
the codex's own, in the order [LAYERS.md](../LAYERS.md) gives them. The five
network layers (09–13) branch off 01, and the six cross-cutting layers
(14–19) intersect the ladder rather than sitting on it.

---

## References

### Where to start, by depth

```text
  Each column is one subject, read downward. The top row is where to start
  cold; the bottom is where the subject stops being introductory.

            classical EM        solid state         quantum
  first     Hayt                Pierret             Feynman Vol. III
            Engineering E&M     Semiconductor Dev.
              │                   │                   │
  core      Griffiths           Streetman           Griffiths QM
            Electrodynamics     & Banerjee
              │                   │                   │
  deep      Jackson             Kittel · Sze        Shankar
            Ramo/Whinnery       (the device bible)

  thermal & noise   Kittel & Kroemer ─▶ Pathria
  optics/photonics  Hecht ─▶ Saleh & Teich          (needs classical EM)
  physical limits   Shannon ─▶ Landauer             → 12 Transport, 14 Security
```

### Classical EM
- *Introduction to Electrodynamics* — David J. Griffiths. The canonical undergrad text.
- *Classical Electrodynamics* — J. D. Jackson. Graduate level.
- *Engineering Electromagnetics* — William Hayt.
- *Fields and Waves in Communication Electronics* — Ramo, Whinnery, Van Duzer.

### Solid-state / semiconductor
- *Introduction to Solid State Physics* — Charles Kittel.
- *Physics of Semiconductor Devices* — S. M. Sze. The device-physics bible.
- *Semiconductor Device Fundamentals* — Robert F. Pierret.
- *Solid State Electronic Devices* — Streetman & Banerjee.

### Quantum
- *Introduction to Quantum Mechanics* — David J. Griffiths.
- *Principles of Quantum Mechanics* — R. Shankar.
- *The Feynman Lectures on Physics, Vol. III* — quantum.

### Statistical / thermodynamics
- *Thermal Physics* — Kittel & Kroemer.
- *Statistical Mechanics* — R. K. Pathria.

### Optics & photonics
- *Optics* — Eugene Hecht.
- *Photonics* — Saleh & Teich.

### Information / physical limits
- *The Mathematical Theory of Communication* — Shannon (free PDF).
- "Irreversibility and Heat Generation in the Computing Process" — Rolf Landauer.

### Online
- Hyperphysics — `http://hyperphysics.phy-astr.gsu.edu/`
- MIT OCW 8.02 (E&M), 8.04 (Quantum), 6.012 (Microelectronics)
- nptel.ac.in physics courses

### V1 cross-reference
- Quantum-cryptography notes (v1 collection) — also referenced from
  [14_Security](../14_Security/)

---

## Lessons

### The ladder

```text
  The file numbers thirteen exercises and states no prerequisites between
  them, so the grouping below is editorial: three strands, each rooted in
  the maths rather than in each other.

  1  Math prerequisites       vector calc · complex · ODE/PDE · Fourier
  │
  ├─ classical EM
  │     2  Electrostatics & magnetostatics
  │     3  Maxwell's equations
  │     4  Plane waves & transmission lines   → 01 PCB · 16 RF · 09 PHY
  │
  ├─ solid state — from quantum mechanics and crystal structure, not
  │                from the field equations above
  │     5  Crystals & band theory
  │     6  Doping & the p-n junction
  │     7  Diode physics
  │     8  BJT & MOSFET                       → 00b Devices · 00c Analog
  │     9  Quantum tunnelling — Zener breakdown and flash erase, not
  │        ordinary junction or channel conduction, which is drift,
  │        diffusion and thermionic emission
  │
  ├─ 10  Photonics primer     draws on both strands above
  │
  └─ thermodynamics and information — independent of everything above
        11  Thermal & noise         kT/q · Johnson-Nyquist · shot · 1/f
        12  Landauer's principle    kT ln 2 per irreversibly erased bit
        13  Information theory      entropy · capacity → 12 Transport

  Lab: physics_labs.md — Ohm's law, an RC time constant, a diode I-V curve.
  Only the last of those corresponds to a numbered exercise above (#7).
```

### Dedicated lesson modules

| Topic | File |
|-------|------|
| Physics interactive labs | [Physics interactive labs](physics_labs.md) — RC circuit, Ohm's law, diode I-V curve |

---

1. **Math prerequisites** — vector calculus (div, grad, curl), complex numbers, ODEs/PDEs, Fourier transforms.
2. **Electrostatics & magnetostatics** — Coulomb's law, Gauss, Ampère; capacitance, inductance.
3. **Maxwell's equations** — in differential and integral form; derive the wave equation.
4. **Plane waves & transmission lines** — Z₀, reflection, VSWR, Smith chart.
5. **Crystal structures & band theory** — Brillouin zones, E-k diagrams, effective mass.
6. **Doping & p-n junction** — depletion region, built-in voltage, I–V curve.
7. **Diode physics** — Shockley equation, breakdown, Zener.
8. **BJT & MOSFET** — operating regions, transconductance, small-signal models.
9. **Quantum tunneling** — WKB approximation, applications (Zener, FET subthreshold, flash erase).
10. **Photonics primer** — photon energy hν, absorption, photodetector, LED, laser.
11. **Thermal & noise** — kT/q, Johnson-Nyquist (4kTRΔf), shot noise (2qIΔf), 1/f noise.
12. **Landauer's principle** — kT ln 2 per irreversible bit erase; ties physics to computing limits.
13. **Information theory** — entropy, channel capacity, Shannon limit.

### Suggested external
- MIT OCW 8.02 (Walter Lewin's E&M lectures), 6.012 (Microelectronics)
- *3Blue1Brown* visual intuition for math
- Sabine Hossenfelder / PBS Spacetime YouTube (general physics)

---

## Languages

Mostly math + simulation tooling — physics speaks math first.

### Two kinds of tool

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

### Simulation languages / formats
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

---

## Manual Pages

Simulators rather than system utilities — the tooling at this layer is solvers
you install, not commands the OS ships.

### What solves what

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
    are under Languages, not in this table

  the maths itself         sympy (symbolic) · octave (numeric)

  and one that is neither  units — `units -t "1 eV" J` → 1.602e-19

  Numeric values for the constants below are in this file's second table;
  the laws they appear in are under Protocols, below.
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

### Physical constants quick-ref
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

Reference for `units`: `units -t "1 eV" J` → `1.602e-19`. Both the source
and the target unit are arguments; one alone asks for its definition.

---

## Topics

Each topic links to what it *enables* one layer up.

### What each group enables

```text
  This section is organised by what a topic lets you build one layer up,
  so here is that mapping rather than a list of the groups again.

  classical EM ────────┬──▶ capacitors, inductors             00b Devices
                       ├──▶ transmission lines, integrity     01 Circuit Board
                       └──▶ propagation in air and fibre      09 PHY · 16 RF

  solid state ─────────┬──▶ the p-n junction                  00b Devices
                       └──▶ the MOS capacitor ──▶ MOSFET      00b → 00d gates

  quantum ─────────────┬──▶ tunnelling: Zener, flash erase,   00b Devices
  │                    │    gate leakage, tunnel FETs
                       ├──▶ confinement ──▶ optoelectronics   09 PHY
                       └──▶ Holevo bound, QKD                 14 Security

  thermo & noise ──────┬──▶ noise floors, phase noise         00c Analog · 16 RF
                       └──▶ kT ln 2 per *irreversibly* erased bit

  optics ──────────────┬──▶ total internal reflection ──▶ fibre    09 PHY
                       └──▶ direct vs indirect gap: why Si LEDs fail

  information ─────────┬──▶ C = B log₂(1 + S/N)               12 Transport
                       └──▶ reversible computing (Bennett)
```

### Classical EM
- **Coulomb / Gauss** → capacitor design ([00b_Devices](../00b_Devices/))
- **Ampère / Faraday** → inductors, transformers
- **Maxwell's equations** → all EM theory (light, radio, transmission lines)
- **Plane waves & polarization** → fiber and RF propagation ([09](../09_Network_Physical/), [16](../16_RF_Wireless/))
- **Transmission line theory** — Z₀, reflection coefficient, Smith chart → PCB signal integrity ([01](../01_Circuit_Board/))

### Solid-state
- **Crystal lattice, Bravais, reciprocal lattice**
- **Band theory** — valence vs conduction; insulators vs semiconductors vs metals
- **Effective mass**, **density of states**
- **Doping** — donors (n-type), acceptors (p-type), Fermi level shifts
- **Carrier transport** — drift (μE), diffusion (D∇n); Einstein relation
- **p-n junction** — depletion region, built-in voltage, depletion capacitance, breakdown
- **MOS capacitor** — accumulation, depletion, inversion → MOSFET ([00b_Devices](../00b_Devices/))

### Quantum
- **Wave-particle duality, de Broglie**
- **Schrödinger equation** — bound states, tunneling
- **Tunneling** → Zener, flash erase, gate leakage, tunnel FETs (ordinary
  subthreshold conduction is diffusion, not tunnelling)
- **Energy bands from periodic potential** (Kronig-Penney intuition)
- **Pauli exclusion** → why bands fill
- **Quantum dots / wells / wires** — confinement → optoelectronics

### Thermodynamics & noise
- **kT energy scale** at room temp ≈ 25.85 meV
- **Boltzmann distribution** — carriers in semiconductors
- **Johnson-Nyquist (thermal) noise** — `Vn² = 4kTRΔf`
- **Shot noise** — `In² = 2qIΔf`
- **1/f flicker noise** — process-dependent
- **Phase noise** — oscillator quality

### Optics / photonics
- **Snell, Fresnel, total internal reflection** → optical fiber
- **Photon energy** `E = hν = hc/λ`
- **Absorption / emission** — direct vs indirect bandgap → why Si LEDs are bad and GaAs LEDs work
- **Lasers** — population inversion, stimulated emission, threshold

### Information & physical limits
- **Landauer's principle** — minimum energy per irreversible bit erase = kT ln 2 ≈ 2.85 × 10⁻²¹ J at 300 K
- **Reversible computing** — Bennett; theoretical zero-energy
- **Shannon channel capacity** — `C = B log₂(1 + S/N)` (cross-link [12](../12_Network_Transport/))
- **Holevo bound** — quantum information limit

### Cross-link
- All of this feeds upward into → [00b_Devices](../00b_Devices/)
- RF propagation specifics live in → [RF / Wireless › Topics](../16_RF_Wireless/README.md#topics)
- Quantum security implications → [Security › Topics](../14_Security/README.md#topics)

---

## Protocols

Physics has *laws*, not protocols. This section collects the standard formal
statements you'll cross-reference everywhere.

### How the units derive

```text
  Seven base units are defined. Everything else is built from them, which
  is why a volt is energy per unit charge rather than a primitive.

  s · m · kg · A · K · mol · cd              ◀── the seven
  │
  ├─ N  = kg·m/s²                            force
  │   └─ J = N·m                             energy
  │       ├─ W = J/s                         power
  │       └────────────┐
  ├─ C  = A·s          │                     charge
  │   └────────────────┤
  │                    ▼
  │               V = J/C                    voltage
  │                    │
  │                    ├─ Ω  = V/A           resistance
  │                    ├─ F  = C/V           capacitance
  │                    ├─ H  = V·s/A         inductance
  │                    └─ Wb = V·s           magnetic flux
  │                        └─ T = Wb/m²      flux density
  └─ Hz = 1/s                                frequency

  The laws below are relations among these. BIPM defines the units, CODATA
  evaluates the world's measurements and recommends a value for each
  constant, and NIST publishes those recommendations.
```

### SI base units
| Quantity | Unit | Symbol |
|----------|------|--------|
| Time | second | s |
| Length | metre | m |
| Mass | kilogram | kg |
| Electric current | ampere | A |
| Temperature | kelvin | K |
| Amount of substance | mole | mol |
| Luminous intensity | candela | cd |

### SI derived units (selected)
| Quantity | Unit | Equivalent |
|----------|------|------------|
| Force | newton (N) | kg·m/s² |
| Energy | joule (J) | N·m |
| Power | watt (W) | J/s |
| Charge | coulomb (C) | A·s |
| Voltage | volt (V) | J/C |
| Resistance | ohm (Ω) | V/A |
| Capacitance | farad (F) | C/V |
| Inductance | henry (H) | V·s/A |
| Frequency | hertz (Hz) | 1/s |
| Magnetic flux | weber (Wb) | V·s |
| Magnetic flux density | tesla (T) | Wb/m² |

### Key laws
- **Ohm's law** — `V = IR`
- **Joule heating** — `P = I²R = V²/R`
- **Kirchhoff's current law (KCL)** — Σ I = 0 at a node
- **Kirchhoff's voltage law (KVL)** — Σ V = 0 around a loop
- **Capacitor I-V** — `I = C dV/dt`
- **Inductor I-V** — `V = L dI/dt`
- **Maxwell's equations** (vacuum, differential form):
  - ∇·E = ρ/ε₀
  - ∇·B = 0
  - ∇×E = −∂B/∂t
  - ∇×B = μ₀ε₀ ∂E/∂t + μ₀ J
- **Lorentz force** — `F = q(E + v×B)`
- **Planck-Einstein** — `E = hν`
- **Schrödinger (time-dependent)** — `iħ ∂Ψ/∂t = ĤΨ`

### Standards bodies
- **BIPM** — Bureau International des Poids et Mesures (SI custodian)
- **NIST** — US measurement standards
- **CODATA** — fundamental constants

See [Manual Pages](#manual-pages) for numeric constants.
