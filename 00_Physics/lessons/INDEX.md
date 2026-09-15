# Physics — Lessons

## The ladder

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
  │     9  Quantum tunnelling — what is happening inside 7 and 8
  │
  ├─ 10  Photonics primer     draws on both strands above
  │
  └─ thermodynamics and information — independent of everything above
        11  Thermal & noise         kT/q · Johnson-Nyquist · shot · 1/f
        12  Landauer's principle    kT ln 2 per irreversibly erased bit
        13  Information theory      entropy · capacity → 12 Transport

  Lab: physics_labs.md exercises 2, 6 and 7 (Ohm, RC, diode I-V).
```

## Dedicated lesson modules

| Topic | File |
|-------|------|
| Physics interactive labs | [physics_labs.md](physics_labs.md) — RC circuit, Ohm's law, diode I-V curve |

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

## Suggested external
- MIT OCW 8.02 (Walter Lewin's E&M lectures), 6.012 (Microelectronics)
- *3Blue1Brown* visual intuition for math
- Sabine Hossenfelder / PBS Spacetime YouTube (general physics)
