# Physics — Lessons

## The ladder

```text
  The numbered path below is two independent chains. The first runs from the
  maths to devices and forks three ways once the field equations are in
  place; the second, #11–#13, starts over from thermodynamics and owes
  nothing to it.

  1  Math prerequisites          vector calc · complex · ODE/PDE · Fourier
  │
  └─ 2  Electrostatics & magnetostatics
     └─ 3  Maxwell's equations   ◀── everything below forks from here
        │
        ├─ 4  Plane waves & transmission lines   → 01 PCB · 16 RF · 09 PHY
        │
        ├─ 5  Crystals & band theory
        │  └─ 6  Doping & the p-n junction
        │     └─ 7  Diode physics
        │        └─ 8  BJT & MOSFET            → 00b Devices · 00c Analog
        │
        ├─ 9  Quantum tunnelling               Zener · subthreshold · flash
        │     explains behaviour inside 7 and 8 rather than preceding them
        │
        └─ 10  Photonics primer                needs 3 and 5 both

  11  Thermal & noise            kT/q · Johnson-Nyquist · shot · 1/f
  └─ 12  Landauer's principle    kT ln 2 per erased bit — the floor
     └─ 13  Information theory   entropy · channel capacity → 12 Transport

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
