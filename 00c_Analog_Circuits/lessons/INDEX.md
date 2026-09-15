# Analog Circuits — Lessons

## The ladder

```text
  Twelve exercises. #1 is the op-amp everything else is built on; #2 and #3
  are the first two things you build out of it.

  1  Op-amp basics           inverting · non-inverting · buffer · summer
  │                          the two golden rules
  ├─ 2  Sallen-Key filter    2nd-order low-pass at 1 kHz, measure rolloff
  ├─ 3  Instrumentation amp  3-op-amp INA from discretes, high CMRR
  │
  ├─ 4  Voltage reference    bandgap ─▶ LM385 / LM4040
  │  ├─ 5  LDO               C_in/C_out, dropout, thermal limits
  │  └─ 6  Buck converter    L, C_out, duty · CCM vs DCM · loop comp
  │
  ├─ 7  PLL fundamentals     detector + LPF + VCO · lock vs capture range
  │
  ├─ 8  ADC sampling         Nyquist · aliasing · anti-alias · SAR vs ΣΔ
  │  └─ 9  DAC reconstruction   sinc roll-off, reconstruction filter
  │
  ├─ 10  Audio amp           Class A/B/AB/D — THD against efficiency
  └─ 11  RF LNA              noise figure · IP3 · S-parameters  → 16 RF

  12  Mixed-signal layout pitfalls    ground bounce · decoupling · return
      paths — the one that ruins any of the eleven above  → 01 Circuit Board

  Lab: analog_labs.md covers 1, 2 and 8 (op-amp, active filter, sampling).
```

## Dedicated lesson modules

| Topic | File |
|-------|------|
| Analog interactive labs | [analog_labs.md](analog_labs.md) — Op-amp, active filter, ADC sampling |

---

1. **Op-amp basics** — inverting, non-inverting, buffer, summer, differential amp; "golden rules".
2. **Sallen-Key filter** — design a 2nd-order low-pass at 1 kHz; measure rolloff.
3. **Instrumentation amplifier** — 3-op-amp INA from discretes; high CMRR.
4. **Voltage reference** — bandgap concept; LM385 / LM4040 in practice.
5. **LDO design** — pick C_in/C_out, calc dropout, thermal limits.
6. **Buck converter** — pick L, C_out, D; CCM vs DCM; loop comp basics.
7. **PLL fundamentals** — phase detector + LPF + VCO; lock range vs capture range.
8. **ADC sampling** — Nyquist, aliasing, anti-alias filtering; SAR vs ΣΔ tradeoffs.
9. **DAC reconstruction** — sinc roll-off, reconstruction filter.
10. **Audio amp** — Class A vs B vs AB vs D; THD vs efficiency.
11. **RF LNA** — noise figure, IP3, S-parameters intro.
12. **Mixed-signal layout pitfalls** — ground bounce, supply decoupling, return paths.

## Suggested external
- TI Precision Labs (free video course library)
- Jim Williams' app notes (LT AN-1, AN-47, AN-65)
