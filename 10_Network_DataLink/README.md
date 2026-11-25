# 10 — Network Data Link (OSI L2)

> Frames between adjacent nodes on the same logical segment. MAC addresses,
> switching, VLANs, and the framing that turns a raw bit pipe into something
> packets can ride on.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  11  Network Internet (L3)                   │
└───────────────────────┬──────────────────────┘
                        │  frames carrying packets
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  10  Network Data Link (L2)       ◀── here   ┃
┃      frames · MAC addressing · switching     ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  encoded bits on copper, fiber, RF
┌───────────────────────┴──────────────────────┐
│  09  Network Physical (L1)                   │
└──────────────────────────────────────────────┘
```

## At a glance

| Field | Value |
|-------|-------|
| OSI layer | 2 (Data Link) — split into LLC + MAC sublayers |
| Description | Framing, addressing, and forwarding between adjacent nodes |
| Protocols | Ethernet (802.3), Wi-Fi MAC (802.11), ARP, VLAN (802.1Q), STP, LACP |
| Medium | Whatever L1 provides — copper, fiber, RF |
| Example | A switch forwards a frame to the port matching the dest MAC |
| Adjacent | ↓ [09_Network_Physical](../09_Network_Physical/), ↑ [11_Network_Internet](../11_Network_Internet/) |

## What lives here

- Ethernet framing & switching
- ARP / NDP (resolving L3 ↔ L2)
- VLANs (802.1Q), QinQ (802.1ad), VXLAN/Geneve (overlay)
- Spanning Tree (STP/RSTP/MSTP) and modern alternatives (TRILL, SPB)
- Link aggregation (LACP, 802.3ad)
- LLDP, CDP (neighbor discovery)
- 802.1X port-based authentication
- Wi-Fi MAC frames (mgmt, control, data)
- PPP, MPLS (label switching — sits between L2 and L3)

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | 802 standards, networking textbooks |
| [Lessons](#lessons) | [Interactive labs](datalink_labs.md) | packet capture, VLAN lab, bridge build |
| [Languages](#languages) | — | frame parsers, raw socket libs |
| [Manual Pages](#manual-pages) | [Data Link Layer Commands](datalink_commands.md) | `ip link`, `bridge`, `tcpdump`, `arp` |
| [Topics](#topics) | — | switching, ARP, VLANs, STP, EVPN |
| [Protocols](#protocols) | [Ethernet](ethernet.md) | table of L2 protocols & RFCs |

## Cross-references
- PHY beneath → [09_Network_Physical](../09_Network_Physical/)
- L3 above → [11_Network_Internet](../11_Network_Internet/)
- L2 attacks (ARP spoof, VLAN hop) → [Security › Topics](../14_Security/README.md#topics)

---

## References

### What is in this section

```text
  Data link reference sources: books, IEEE standards, and online resources.

  ┌─── books ─────────────────────────────────────────────────────────────┐
  │  Computer Networks (Tanenbaum) · Top-Down Approach (Kurose & Ross)   │
  │  Interconnections (Perlman) · Network Warrior · Routing TCP/IP       │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── standards ─────────────────────────────────────────────────────────┐
  │  IEEE 802.1D/Q/X/AX (STP · VLANs · NAC · LACP) · 802.11 (Wi-Fi)    │
  │  RFC 826 ARP · RFC 4861 NDP · RFC 7348 VXLAN · RFC 8926 Geneve       │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── online ────────────────────────────────────────────────────────────┐
  │  networklessons.com · Packet Pushers podcast · IETF I-Ds             │
  └───────────────────────────────────────────────────────────────────────┘
```

### Books
- *Computer Networks* — Andrew Tanenbaum & David Wetherall. Comprehensive.
- *Computer Networking: A Top-Down Approach* — Kurose & Ross.
- *Interconnections: Bridges, Routers, Switches, and Internetworking Protocols* — Radia Perlman. The classic.
- *Network Warrior* — Gary Donahue. Practical Cisco-flavored.
- *Routing TCP/IP, Vol. I & II* — Jeff Doyle.

### Standards
- **IEEE 802.1D** — bridging (legacy STP)
- **IEEE 802.1Q** — VLANs, RSTP/MSTP, dot1ad
- **IEEE 802.1X** — port-based NAC
- **IEEE 802.3ad / 802.1AX** — Link Aggregation (LACP)
- **IEEE 802.11** — Wi-Fi MAC frames
- **RFC 826** — ARP
- **RFC 4861** — Neighbor Discovery (IPv6 NDP)
- **RFC 7348** — VXLAN
- **RFC 8926** — Geneve

### Online
- IETF I-Ds for emerging L2 work
- Network Lessons (`https://networklessons.com/`) — pragmatic walkthroughs
- Packet Pushers podcast

---

## Lessons

### What is in this section

```text
  Data link hands-on: bridging, VLANs, STP, overlays, and L2 attacks.

  ┌─── dedicated module ──────────────────────────────────────────────────┐
  │  datalink_labs.md (VLAN config · ARP cache observation)              │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── lesson ladder ─────────────────────────────────────────────────────┐
  │  1–4: Ethernet frames · ARP trace · Linux bridge · VLAN lab          │
  │  5–8: STP convergence · LACP bond · Wi-Fi mgmt frames · VXLAN       │
  │  9–10: EVPN/MP-BGP · L2 attack lab (ARP spoof/MAC flood/VLAN hop)   │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated Lesson Modules

| File | Covers |
|------|--------|
| [Network Data Link — Interactive Labs](datalink_labs.md) | VLAN config, ARP cache observation, STP |

### Lesson ladder

1. **Read an Ethernet frame** — capture with `tcpdump -e`; decode preamble/SFD, MAC, EtherType, FCS.
2. **Trace an ARP exchange** — `arping`, then full `who-has` and `is-at` in Wireshark.
3. **Build a Linux bridge** — `ip link add br0 type bridge`, attach two veth pairs.
4. **VLAN lab** — create `eth0.10` and `eth0.20`; trunk and access port semantics.
5. **STP convergence** — make a triangle of bridges; observe blocking ports; cut a link.
6. **LACP bond** — `bonding` driver in mode 4; verify with `ip -d link`.
7. **Wi-Fi mgmt frames** — capture beacons, probe requests, deauth.
8. **VXLAN overlay** — two hosts, VXLAN tunnel, ping over it; inspect outer/inner frames.
9. **EVPN/MP-BGP** — read FRR or sonic configs; understand RT/RD.
10. **L2 attack lab** — ARP spoof, MAC flood, VLAN hop, DHCP starvation — all in an isolated VM.

### Suggested external
- David Mahler's networking YouTube series
- Wireshark sample captures: `https://wiki.wireshark.org/SampleCaptures`

---

## Languages

### What is in this section

```text
  Packet-crafting libraries, switching dataplanes, and config languages.

  ┌─── packet libraries ──────────────────────────────────────────────────┐
  │  Scapy (Python) · dpkt · pyshark · gopacket (Go) · libpcap (C)      │
  │  libpnet (Rust) · PF_PACKET · AF_XDP · eBPF/XDP (in-kernel)         │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── switching dataplanes & config ─────────────────────────────────────┐
  │  Linux bridge/nftables/tc · Open vSwitch · DPDK · VPP (FD.io)       │
  │  P4 (programmable dataplanes) · IOS/NX-OS/Junos/SONiC CLI           │
  └───────────────────────────────────────────────────────────────────────┘
```

L2 is about frame formats, not programming languages. The relevant "languages"
are the **packet libraries** that let code parse / craft L2 frames.

| Library | Language | Notes |
|---------|----------|-------|
| Scapy | Python | Most ergonomic for crafting/replaying frames |
| dpkt | Python | Fast read-only parsing |
| pyshark | Python | Wireshark wrapper |
| libpnet | Rust | Cross-platform raw packet |
| gopacket | Go | Comprehensive parsing & live capture |
| libpcap | C | The base capture library on Unix |
| Npcap / WinPcap | C (Win) | Windows packet capture |
| PF_PACKET | Linux kernel | Raw L2 sockets |
| AF_XDP | Linux kernel | High-perf zero-copy capture |
| eBPF/XDP | C (compiled to BPF) | Programmable in-kernel L2/L3 |

### Switching dataplanes
- **Linux bridge / nftables / tc** — kernel software dataplane
- **Open vSwitch (OVS)** — production-grade SDN-friendly bridge
- **DPDK** — userspace fast path (poll-mode drivers)
- **VPP (FD.io)** — vectorized packet processing
- **eBPF/XDP** — programmable kernel-bypass-ish
- **P4** — declarative dataplane language for programmable switches/NICs

### Config languages
- Cisco IOS / NX-OS CLI, Junos CLI/JSON, FRR (Quagga-derived), SONiC YANG
- NETCONF/RESTCONF/gNMI for programmatic config

---

## Manual Pages

### What is in this section

```text
  Data link commands: bridging, VLAN, ARP, capture, and aggregation.

  ┌─── dedicated subfile ─────────────────────────────────────────────────┐
  │  datalink_commands.md (ip link · bridge · tc · arp · arping)         │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── inline command groups ─────────────────────────────────────────────┐
  │  Interface/bridge/VLAN: ip link · bridge · vlan/vxlan subinterfaces  │
  │  ARP/NDP: ip neigh · arping · arp · ndisc6                            │
  │  Capture: tcpdump -e · tshark · tcpreplay · ettercap · bettercap     │
  │  Bonding: ip link add bond0 type bond · teamdctl                      │
  │  macOS: ifconfig · networksetup · Windows: Get-NetAdapter             │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated man page references

| Topic | File |
|-------|------|
| Data link layer commands | [Data Link Layer Commands](datalink_commands.md) — ip link, bridge, tc, arp, arping |

---

### Interface / bridge / VLAN
| Command | Purpose |
|---------|---------|
| `ip link` | Interface admin (up/down, mtu, mac) |
| `ip link add type bridge` | Create a bridge |
| `bridge` | Bridge fdb, vlan, link control (iproute2) |
| `ip link add link eth0 name eth0.10 type vlan id 10` | Tagged subinterface |
| `ip link add link eth0 name vxlan0 type vxlan ...` | VXLAN endpoint |
| `bridge fdb show` | View MAC forwarding database |
| `nmcli` / `nmtui` | NetworkManager CLI/TUI |
| `networkctl` | systemd-networkd status |

### ARP / NDP
| Command | Purpose |
|---------|---------|
| `ip neigh` | ARP/NDP table |
| `arp -a` | Legacy ARP view |
| `arping` | Send ARP probes |
| `ndisc6` | IPv6 neighbor discovery utilities |

### Capture / inspect
| Command | Purpose |
|---------|---------|
| `tcpdump -i eth0 -e -nn` | Live capture with link-layer info |
| `tshark` | Wireshark CLI |
| `tcpreplay` | Replay PCAPs onto a wire |
| `ettercap` | L2 MitM toolkit (audit only) |
| `bettercap` | Modern alternative |

### Bonding / aggregation
| Command | Purpose |
|---------|---------|
| `ip link add bond0 type bond mode 802.3ad` | LACP bond |
| `/proc/net/bonding/bond0` | Bond status |
| `teamdctl` | Team driver alternative |

### macOS
- `ifconfig`, `networksetup -listallhardwareports`, `arp -a`
- `tcpdump`, `pktap` (special interface for sandboxed captures)

### Windows
- `Get-NetAdapter`, `Get-NetNeighbor`, `Get-NetSwitchTeam`
- `arp -a`, `netsh interface`

---

## Topics

### What is in this section

```text
  Data link layer topics: framing, switching, VLANs, STP, MACsec, and Wi-Fi.

  ┌─── framing & addressing ──────────────────────────────────────────────┐
  │  Ethernet frame (preamble/SFD/MAC/EtherType/payload/FCS)             │
  │  MAC: unicast/multicast/broadcast · OUI · I/G · U/L bits · randomized│
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── switching, VLANs & overlays ───────────────────────────────────────┐
  │  MAC learning · flooding · storm control · port security              │
  │  802.1Q VLAN · QinQ · VXLAN · Geneve · EVPN/MP-BGP                  │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── loop prevention, auth & Wi-Fi ─────────────────────────────────────┐
  │  STP/RSTP/MSTP · LACP · MLAG · ARP/NDP spoofing defenses            │
  │  802.1X/EAPOL · MACsec · Wi-Fi frames (mgmt/control/data) · PMF     │
  └───────────────────────────────────────────────────────────────────────┘
```

### Ethernet frame
- **Preamble + SFD** (7 + 1 bytes)
- **Dest MAC (6) + Src MAC (6)**
- **EtherType / length (2)** — 0x0800 IPv4, 0x86DD IPv6, 0x0806 ARP, 0x8100 802.1Q
- **Payload (46–1500)** — MTU; jumbo frames 9000+
- **FCS (4)** — CRC-32
- **IFG** — inter-frame gap

### Addressing
- **MAC address** — 6 bytes; OUI (24) + NIC-assigned (24)
- **Unicast / multicast / broadcast** — LSB of first octet for I/G bit
- **Universally vs locally administered** (U/L bit)
- **Randomized MAC** — privacy in Wi-Fi/BT

### ARP & NDP
- **ARP (IPv4)** — request/reply, gratuitous, proxy, ARP cache aging
- **NDP (IPv6)** — RS/RA, NS/NA, redirect; SLAAC interaction

### Switching
- **MAC learning** — populate fdb from src MAC
- **Flooding** — unknown unicast & broadcast
- **Storm control**, **MAC limit**, **port security**

### VLANs & overlays
- **802.1Q tag** — 4 bytes: TPID + PCP/DEI/VID
- **Native VLAN** vs **access** vs **trunk** ports
- **QinQ (802.1ad)** — provider tagging
- **VXLAN (RFC 7348)**, **Geneve (RFC 8926)** — L2 over UDP/IP
- **EVPN (RFC 7432)** — MP-BGP control plane for overlays
- **NVGRE, STT** — legacy alternatives

### Loop prevention / redundancy
- **STP (802.1D)** → **RSTP (802.1w)** → **MSTP (802.1s)**
- **BPDU**, **root bridge**, **port roles** (root, designated, alt, backup)
- **LACP (802.3ad/802.1AX)** — link aggregation control
- **TRILL**, **SPB (802.1aq)** — modern multipath alternatives
- **MC-LAG / VPC / MLAG** — vendor-specific multi-chassis aggregation

### Neighbor discovery (control plane)
- **LLDP (802.1AB)** — vendor-neutral
- **CDP** — Cisco

### Authentication / NAC
- **802.1X** — EAPOL, RADIUS, supplicant/authenticator/server roles
- **MACsec (802.1AE)** — link-layer encryption

### Wi-Fi MAC specifics
- **Frame classes** — management (beacon, probe, auth, assoc, deauth), control (RTS/CTS, ACK), data
- **4-address frames** (WDS, mesh)
- **PMF (Protected Management Frames)** — 802.11w

### MPLS (between L2 & L3)
- **Label-switched paths**, **LDP**, **RSVP-TE**, **Segment Routing (SR-MPLS)**

### Security cross-link
- ARP/NDP spoofing, DHCP starvation, VLAN hopping, deauth attacks → [Security › Topics](../14_Security/README.md#topics)

---

## Protocols

### What is in this section

```text
  Data link protocols: framing, VLANs, overlays, spanning tree, and 802.1X.

  ┌─── dedicated protocol reference ──────────────────────────────────────┐
  │  ethernet.md (frame · VLANs · MAC · ARP · STP · speed evolution)     │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── framing & addressing ──────────────────────────────────────────────┐
  │  Ethernet II/802.3 · ARP/RARP · NDP · LLDP · CDP                    │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── VLAN, overlay & loop prevention ───────────────────────────────────┐
  │  802.1Q · 802.1ad (QinQ) · VXLAN · Geneve · EVPN                    │
  │  STP/RSTP/MSTP · LACP · TRILL · SPB                                  │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── auth, Wi-Fi MAC & WAN ─────────────────────────────────────────────┐
  │  802.1X (EAPOL) · EAP · MACsec · Wi-Fi mgmt/control frames          │
  │  PPP/PPPoE · L2TP · MPLS/LDP/RSVP-TE/Segment Routing                │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated protocol references

| Protocol | File |
|----------|------|
| Ethernet (802.3) | [Ethernet](ethernet.md) — frame format, VLANs, MAC, ARP, STP, speed evolution |

---

### Framing & addressing
| Protocol | Spec | Purpose |
|----------|------|---------|
| Ethernet II / 802.3 | IEEE 802.3 | Standard frame format |
| ARP | RFC 826 | IPv4 ↔ MAC resolution |
| RARP | RFC 903 | MAC → IPv4 (legacy) |
| IPv6 NDP | RFC 4861 | Neighbor discovery (also covers RA/RS) |
| LLDP | IEEE 802.1AB | Link-layer neighbor discovery |
| CDP | Cisco | Cisco proprietary neighbor discovery |

### VLAN / overlay
| Protocol | Spec | Purpose |
|----------|------|---------|
| 802.1Q | IEEE 802.1Q | VLAN tagging (4-byte tag) |
| 802.1ad (QinQ) | IEEE 802.1ad | Provider stacked tags |
| VXLAN | RFC 7348 | L2-over-UDP, VNI = 24 bits |
| Geneve | RFC 8926 | Extensible L2-over-UDP |
| NVGRE | RFC 7637 | L2 over GRE (legacy) |
| EVPN | RFC 7432 | MP-BGP control plane for overlays |

### Loop prevention / redundancy
| Protocol | Spec | Purpose |
|----------|------|---------|
| STP | 802.1D | Spanning Tree (legacy) |
| RSTP | 802.1w | Rapid STP |
| MSTP | 802.1s | Multiple STP instances |
| LACP | 802.1AX (was 802.3ad) | Link aggregation |
| TRILL | RFC 6325 | Multipath bridging |
| SPB | 802.1aq | Shortest Path Bridging |

### Authentication / security
| Protocol | Spec | Purpose |
|----------|------|---------|
| 802.1X | IEEE 802.1X | Port-based NAC (EAPOL) |
| EAP | RFC 3748 | Extensible Auth (PEAP, TLS, TTLS, MSCHAPv2, FAST) |
| MACsec | 802.1AE | Layer-2 frame encryption + integrity |
| PAE / MKA | 802.1X | MACsec key agreement |

### Wi-Fi MAC (802.11)
- Beacon, Probe Req/Resp, Authentication, Association/Reassociation
- RTS/CTS, ACK, Block ACK
- Power Save (PS-Poll, TWT)
- PMF (802.11w)

### PPP & related (still found on WAN links)
| Protocol | Spec | Purpose |
|----------|------|---------|
| PPP | RFC 1661 | Point-to-Point Protocol |
| PPPoE | RFC 2516 | PPP over Ethernet (DSL CPE) |
| PPPoA | RFC 2364 | PPP over ATM (legacy DSL) |
| L2TP | RFC 3931 | L2 tunneling (often L2TP/IPsec) |

### MPLS (label-switched between L2 & L3)
| Protocol | Spec |
|----------|------|
| MPLS | RFC 3031 |
| LDP | RFC 5036 |
| RSVP-TE | RFC 3209 |
| Segment Routing (SR-MPLS) | RFC 8660 |
