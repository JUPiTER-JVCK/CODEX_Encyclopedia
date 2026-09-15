# Digital Circuits — Manual Pages

HDL toolchain commands — simulators, synthesis and place-and-route — rather
than system utilities.

## The open flow, end to end

```text
  These commands chain. Running them in order is the whole FPGA toolchain,
  and every one of them is free:

  design.v ──▶ iverilog ──▶ vvp ──▶ dump.vcd ──▶ gtkwave · surfer
     │           simulate first: a bug found here costs seconds
     │
     ├──▶ verilator ──▶ C++ model        when the testbench is large
     ├──▶ ghdl                           if the design is VHDL
     ├──▶ cocotb-config                  if the testbench is Python
     ├──▶ sby (SymbiYosys)               if you want a proof, not a test
     │
     └──▶ yosys ──▶ netlist ──▶ nextpnr-ice40 ──▶ icepack ──▶ .bin
                                nextpnr-ecp5  ──▶ ecppack
                                nextpnr-gowin
                                    └──▶ icetime      timing report

  The vendor flows (vivado · quartus_sh · vcs · xrun · vsim · dc_shell ·
  genus · innovus) collapse those stages into one tool and one licence.

  On the bench, a logic analyzer closes the loop — Saleae, DSLogic or any
  sigrok device, driven by sigrok-cli or PulseView. The decoder catalog is
  in 01 Circuit Board's protocols section.
```

## Open-source HDL flow
| Command | Purpose |
|---------|---------|
| `iverilog` | Icarus Verilog compiler |
| `vvp` | Icarus Verilog runtime |
| `verilator` | Verilog → C++ converter |
| `ghdl` | VHDL sim |
| `yosys` | Synthesis |
| `nextpnr-ice40` / `-ecp5` / `-gowin` | Place & route |
| `icepack` / `icetime` | iCE40 bitstream / timing |
| `ecppack` | ECP5 bitstream |
| `gtkwave` | Waveform viewer |
| `surfer` | Modern Rust waveform viewer |
| `cocotb-config` | cocotb framework |
| `sby` (SymbiYosys) | Formal verification driver |

## Commercial / vendor
| Tool | Vendor |
|------|--------|
| `vivado` | AMD/Xilinx |
| `quartus_sh` | Intel/Altera |
| `vcs`, `simv` | Synopsys VCS |
| `xrun` (Xcelium) | Cadence |
| `vsim` (ModelSim/QuestaSim) | Siemens EDA |
| `dc_shell` | Synopsys Design Compiler |
| `genus`, `innovus` | Cadence digital implementation |

## Number / bit utilities
| Command | Purpose |
|---------|---------|
| `printf '%b' 255` | Decimal → binary |
| `printf '%x' 255` | Decimal → hex |
| `printf '%d' 0xFF` | Hex → decimal |
| `bc <<< "obase=2; ibase=10; 255"` | Arbitrary base in `bc` |
| `python3 -c "print(bin(255))"` | Python one-liner |

## Lab
- Logic analyzer (Saleae, DSLogic, sigrok-supported devices)
- `sigrok-cli`, PulseView GUI — open-source LA software (see [01/protocols](../../01_Circuit_Board/protocols/INDEX.md) for the decoder list)
- FPGA dev boards — TinyFPGA, iCEBreaker, Tang Nano, ULX3S (open-toolchain friendly)
