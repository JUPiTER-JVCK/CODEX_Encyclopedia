# Devices — Manual Pages

SPICE simulators and PCB tools, several of them GUI applications rather than
commands with a man page.

## Two benches, one workflow

```text
  Half of this section is software and half is hardware, and they are the
  same loop run twice — you simulate a part, then you measure whether the
  model was telling the truth.

  ┌─ model ──────────────────────┐        ┌─ measure ────────────────────┐
  │  ngspice · xyce   CLI        │        │  DMM · oscilloscope          │
  │  LTspice          GUI        │        │  function generator          │
  │  vendor SPICE / IBIS libs    │        │  programmable PSU (DP832)    │
  │                              │        │  LCR meter · curve tracer    │
  │  KiCad · kicad-cli           │        │  component tester (Mega328)  │
  │  skidl (schematic in Python) │        │  hot air · scope · iron      │
  └──────────────┬───────────────┘        └───────────────┬──────────────┘
                 │                                        │
                 └──────────────▶  disagree?  ◀───────────┘
                        the model is wrong, or the part is

  Octopart sits outside both: it answers "can I still buy this", which no
  simulator and no bench will tell you.
```

| Tool | Purpose |
|------|---------|
| `ngspice` | CLI SPICE simulator |
| LTspice (GUI) | Free SPICE from Analog Devices |
| `xyce` | Sandia parallel SPICE |
| KiCad (GUI) | Schematic capture + PCB + 3D viewer |
| KiCad Symbol/Footprint editor | Build new device representations |
| `python -m skidl` | Schematic-in-Python |
| Octopart API | Cross-vendor part availability/pricing |
| `kicad-cli` | Headless KiCad operations |
| Vendor SPICE libraries | Download IBIS/SPICE models from TI/ADI/etc |

## Bench / lab equipment (not CLI tools but worth listing)
- DMM, oscilloscope, function generator, bench power supply (programmable: Rigol DP832 etc)
- LCR meter, semiconductor curve tracer (e.g., Peak DCA75)
- Hot air station, microscope, soldering iron
- Component testers (e.g., Mega328 transistor tester for quick ID)
