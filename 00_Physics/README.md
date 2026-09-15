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

## Sub-sections

- [references/](references/INDEX.md) — Griffiths, Kittel, Sze, Feynman
- [lessons/](lessons/INDEX.md) — from E&M → semiconductor physics → quantum tunneling
- [languages/](languages/INDEX.md) — math + simulation languages
- [man_pages/](man_pages/INDEX.md) — SPICE, COMSOL, FDTD tools
- [topics/](topics/INDEX.md) — concepts mapped to what they enable in hardware
- [protocols/](protocols/INDEX.md) — N/A here (physics has laws, not protocols) — see units/constants

## Cross-references
- The first place these laws become a component → [00b_Devices](../00b_Devices/)
- Where signals become information → [00c_Analog_Circuits](../00c_Analog_Circuits/)
- RF propagation in air → [16_RF_Wireless](../16_RF_Wireless/topics/INDEX.md)
- Cryptographic randomness from physical sources → [14_Security/topics](../14_Security/topics/INDEX.md)
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
