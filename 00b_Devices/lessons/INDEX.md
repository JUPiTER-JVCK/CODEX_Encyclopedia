# Devices — Lessons

## The ladder

```text
  Twelve exercises, and almost all of them are bench work. The order is not
  arbitrary — each one assumes the measurement skill of the last.

  1  Read a datasheet        1N4148 · BC547 — before touching anything
  │
  ├─ 2  Diode I-V            first measurement: V_f against I_f
  │  └─ 3  Zener regulator   first circuit that does a job
  │
  ├─ 4  BJT operating regions   cutoff · active · saturation
  ├─ 5  MOSFET as a switch      low-side LED drive — resistive, no flyback
  ├─ 6  MOSFET as an amplifier  common-source small-signal gain
  │  └─ 7  Op-amp from transistors   diff pair ─▶ mirror ─▶ output stage
  │        needs 4, 5 and 6 together — a walkthrough here, built in 00c
  │
  ├─ 8  Inductors           back-EMF on switch-off — why an inductive load,
  │                         unlike 5's LED, needs a flyback diode
  ├─ 9  Capacitor types     X7R vs C0G vs Y5V, and when the choice bites
  ├─ 10  Optocoupler        current ─▶ photon ─▶ current, across a barrier
  │
  ├─ 11  SPICE a circuit    half-wave rectifier in ngspice — bench to model
  └─ 12  Power MOSFET thermal   R_θJA, R_θJC ─▶ junction temp ─▶ heatsink

  Lab: device_labs.md covers 5, 6 and 12 (switching, biasing, LED drive).
```

## Dedicated lesson modules

| Topic | File |
|-------|------|
| Device interactive labs | [device_labs.md](device_labs.md) — MOSFET switching, LED driver, transistor biasing |

---

1. **Read a datasheet** — pick a 1N4148 diode and BC547 BJT; identify absolute max, characteristic curves, package.
2. **Diode I-V** — measure V_f vs I_f on a breadboard with a series resistor.
3. **Zener regulator** — build a simple shunt regulator; show load regulation limits.
4. **BJT operating regions** — biasing in cutoff, active, saturation; common-emitter amp.
5. **MOSFET as a switch** — drive an LED with a small NMOS; high vs low-side.
6. **MOSFET as an amplifier** — common-source small-signal gain.
7. **Op-amp from transistors** — concept walkthrough of differential pair → mirror → output stage.
8. **Inductors** — measure inductance; observe back-EMF on switch-off.
9. **Capacitor types in practice** — ceramic (X7R/C0G/Y5V), electrolytic, tantalum, film; when to pick what.
10. **Optocoupler isolated link** — TX side current → photon → RX phototransistor.
11. **SPICE a circuit** — model a half-wave rectifier in ngspice; sweep input freq.
12. **Power MOSFET thermal** — calculate junction temperature with R_θJA, R_θJC; pick a heatsink.

## Suggested external
- Razavi's free YouTube lectures on Fundamentals of Microelectronics
- Phil's Lab + EEVblog on practical analog
