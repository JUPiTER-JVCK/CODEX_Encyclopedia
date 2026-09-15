# Circuit Board — References

## Where to start, by what you are doing

```text
  designing the circuit     Horowitz & Hill, The Art of Electronics
                            └─ shared with 00b and 00c — one book, three
                               layers, which is the point of it

  getting from HDL to CPU   Harris & Harris, Digital Design and Computer
                            Architecture                    ──▶ 00d, 02

  making it work at speed   Johnson & Graham, High-Speed Digital Design
                            (the "black magic" handbook — signal integrity)

  having it manufactured    Coombs, Printed Circuits Handbook

  Below the books, the specs — which at this layer are the real reference
  and are all primary sources:

    JEDEC JESD79 family      DDR electrical and timing
    PCI-SIG Base Spec        PCIe electrical and protocol layers
    USB-IF 2.0 / 3.x / 4     physical and link layer
    Intel chipset datasheets what a given PCH actually exposes

  And the community boards that publish their own schematics: Raspberry Pi,
  Arduino, BeagleBoard.
```

## Books
- *The Art of Electronics* — Horowitz & Hill. The canonical analog/digital electronics text.
- *Digital Design and Computer Architecture* — Harris & Harris. Bridges HDL to CPU.
- *High-Speed Digital Design: A Handbook of Black Magic* — Johnson & Graham. Signal integrity.
- *Printed Circuits Handbook* — Coombs. PCB fabrication and design practice.

## Datasheets & specs
- Intel chipset datasheets — `https://www.intel.com/content/www/us/en/products/docs/`
- JEDEC standards for DDR (JESD79 family) — memory module electrical specs
- PCI-SIG specs (PCIe Base Spec) — bus electrical and protocol layers
- USB-IF specs (USB 2.0 / 3.x / 4) — physical and link layer

## Online
- All About Circuits — `https://www.allaboutcircuits.com/`
- EEVblog forum + YouTube — practical electronics
- OSHW community boards: Raspberry Pi, Arduino, BeagleBoard

## Migration from v1
- General hardware datasheets (v1 collection) → drop them in this folder
- SBC-specific documentation (v1 collection)
- `DL_020_datasheet.pdf` — product datasheet, not yet migrated
