# 11 — Network Internet (OSI L3)

> Packets routed between networks. IP addressing, routing protocols, ICMP,
> tunnels — the layer that makes the internet *internetworked*.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  12  Network Transport (L4)                  │
└───────────────────────┬──────────────────────┘
                        │  IP packets, host to host
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  11  Network Internet (L3)        ◀── here   ┃
┃      packets · IP addressing · routing · TTL ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  frames carrying packets
┌───────────────────────┴──────────────────────┐
│  10  Network Data Link (L2)                  │
└──────────────────────────────────────────────┘
```

## At a glance

| Field | Value |
|-------|-------|
| OSI layer | 3 (Network) |
| Description | Packet routing between hosts on different networks |
| Protocols | IPv4, IPv6, ICMP, ICMPv6, IGMP, MLD, OSPF, IS-IS, BGP |
| Medium | L2 frames carrying IP packets |
| Example | Router picks the next hop for a packet by longest-prefix match |
| Adjacent | ↓ [10_Network_DataLink](../10_Network_DataLink/), ↑ [12_Network_Transport](../12_Network_Transport/) |

## What lives here

- **IP** — IPv4, IPv6, addressing, subnetting, fragmentation
- **ICMP / ICMPv6** — diagnostics, errors, Neighbor Discovery
- **Routing protocols** — interior (OSPF, IS-IS, EIGRP, RIP), exterior (BGP)
- **Tunnels** — GRE, IPIP, IPv6-in-IPv4 (6in4, 6to4), L2TPv3
- **VPN tech (L3)** — IPsec (IKEv2 + ESP/AH), WireGuard, OpenVPN
- **Multicast** — IGMPv2/v3, MLD, PIM-SM/DM/SSM
- **NAT** — SNAT, DNAT, NAT64, CGNAT, hairpinning
- **QoS** — DiffServ (DSCP), MPLS EXP, RED/WRED, ECN

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | TCP/IP Illustrated, RFCs |
| [Lessons](#lessons) | [Interactive labs](internet_labs.md) | subnetting, BGP lab, IPsec setup |
| [Languages](#languages) | — | IP libs, routing daemons |
| [Manual Pages](#manual-pages) | [Internet Layer Commands](ip_commands.md) | `ip route`, `traceroute`, `mtr`, `ipset` |
| [Topics](#topics) | [The OSI Model](osi_model.md) | IPv4/v6, routing, NAT, MTU/PMTUD, ECN |
| [Protocols](#protocols) | [BGP](bgp.md) · [IPv4 / IPv6](ipv4_ipv6.md) · [OSPF](ospf.md) | IP, ICMP, routing, VPNs |

## Cross-references
- L2 framing beneath → [10_Network_DataLink](../10_Network_DataLink/)
- L4 above (TCP/UDP) → [12_Network_Transport](../12_Network_Transport/)
- IPsec, route hijack, BGP security → [Security › Topics](../14_Security/README.md#topics)

---

## References

### What is in this section

```text
  Internet-layer reference sources: books, key RFCs, and online resources.

  ┌─── books ─────────────────────────────────────────────────────────────┐
  │  TCP/IP Illustrated (Stevens/Fall) · Routing TCP/IP (Doyle)          │
  │  Internet Routing Architectures (Halabi) · BGP (van Beijnum)         │
  │  IPv6 Essentials (Hagen)                                              │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── key RFCs ──────────────────────────────────────────────────────────┐
  │  RFC 791/8200 (IPv4/v6) · RFC 792/4443 (ICMP/ICMPv6)                │
  │  RFC 4271 (BGP-4) · RFC 2328/5340 (OSPF) · RFC 7296 (IKEv2)        │
  │  RFC 4302/4303 (AH/ESP) · RFC 1918 (private) · RFC 6480 (RPKI)      │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── online ────────────────────────────────────────────────────────────┐
  │  bgp.tools · bgp.he.net — live BGP looking glasses                   │
  │  RIPE Labs · Cloudflare blog · IETF Working Groups (IDR · SPRING)    │
  └───────────────────────────────────────────────────────────────────────┘
```

### Books
- *TCP/IP Illustrated, Vol. 1: The Protocols* — W. Richard Stevens, Kevin Fall. The canonical.
- *Routing TCP/IP, Vol. I & II* — Jeff Doyle.
- *Internet Routing Architectures* — Bassam Halabi.
- *BGP* — Iljitsch van Beijnum.
- *IPv6 Essentials* — Silvia Hagen.

### Key RFCs
- **RFC 791** — IPv4
- **RFC 8200** — IPv6 (was RFC 2460)
- **RFC 792 / 4443** — ICMP / ICMPv6
- **RFC 1918** — Private IPv4 address space
- **RFC 6890** — Special-purpose IP address registries
- **RFC 4271** — BGP-4
- **RFC 2328 / 5340** — OSPFv2 / OSPFv3
- **RFC 5302 / 5308** — IS-IS for IP / IPv6
- **RFC 2784 / 7676** — GRE
- **RFC 7296** — IKEv2
- **RFC 4302 / 4303** — AH / ESP (IPsec)
- **RFC 6346 / 6877** — CGN / 464XLAT
- **RFC 6296** — IPv6-to-IPv6 NPT

### Online
- bgp.tools, bgp.he.net — live BGP looking glasses
- RIPE Labs articles
- Cloudflare blog (routing/L3 deep dives)

---

## Lessons

### What is in this section

```text
  Internet layer hands-on: subnetting, routing, VPNs, NAT, and multicast.

  ┌─── dedicated module ──────────────────────────────────────────────────┐
  │  internet_labs.md (subnetting drill · traceroute analysis · BGP sim)  │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── lesson ladder ─────────────────────────────────────────────────────┐
  │  1–4: subnetting · IPv6 fluency · routing table · static routes/PBR  │
  │  5–8: OSPF lab · BGP lab · GRE tunnel · IPsec site-to-site           │
  │  9–12: WireGuard VPN · NAT/nftables · PMTUD · multicast/PIM          │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated Lesson Modules

| File | Covers |
|------|--------|
| [Network Internet — Interactive Labs](internet_labs.md) | Subnetting drill, traceroute analysis, BGP simulation |

### Lesson ladder

1. **Subnetting drills** — `/24`, `/25`, `/22`, VLSM; do by hand, verify with `ipcalc`.
2. **IPv6 fluency** — link-local, ULA, GUA; SLAAC vs DHCPv6.
3. **Read a routing table** — `ip route show`, `ip -6 route`; understand metric, source, dev.
4. **Static routes & default gateway** — multi-homed host with policy routing.
5. **OSPF lab** — three Linux routers running FRR; areas, LSAs, SPF.
6. **BGP lab** — two ASes, eBGP peering, prefix announce, AS_PATH, communities.
7. **GRE tunnel** — point-to-point GRE between two hosts; encapsulation overhead.
8. **IPsec site-to-site** — strongSwan/Libreswan IKEv2 between two networks.
9. **WireGuard** — set up a hub-and-spoke VPN; routing table changes.
10. **NAT mechanics** — write iptables/nftables rules for SNAT, DNAT, masquerade.
11. **Path MTU discovery** — break it on purpose with ICMP filtering; watch failures.
12. **Multicast** — IGMP join, watch with `tcpdump`; PIM in a small lab.

### Suggested external
- Practical Networking on YouTube — Ed Harmoush
- INE / CBT Nuggets (paid CCNA/CCNP courseware)
- Cloudflare Learning Center

---

## Languages

### What is in this section

```text
  IP-layer libraries, routing daemons, SDN tools, and config APIs.

  ┌─── packet & routing libraries ────────────────────────────────────────┐
  │  Scapy · dpkt · gopacket · pnet (Rust) · netaddr/ipaddress (Python)  │
  │  iproute2 (Linux) · libnl · NETCONF/YANG · gNMI · RESTCONF          │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── routing daemons & SDN ─────────────────────────────────────────────┐
  │  FRRouting (OSPF/IS-IS/BGP) · BIRD · GoBGP · ExaBGP · OpenBGPD      │
  │  ONOS/OpenDaylight · Faucet (Python) · P4 programs · eBPF/XDP       │
  └───────────────────────────────────────────────────────────────────────┘
```

### Packet / routing libraries
| Library | Language | Notes |
|---------|----------|-------|
| Scapy | Python | Craft & dissect IP/ICMP/etc. |
| dpkt | Python | Fast parsing |
| gopacket | Go | Live + offline packet processing |
| pnet | Rust | Cross-platform packet libs |
| netaddr / ipaddress | Python | Address arithmetic |
| iproute2 (Linux) | C | The reference CLI implementation |
| libnl | C | Netlink in C |

### Routing daemons (open source)
| Daemon | Languages | Notes |
|--------|-----------|-------|
| FRRouting | C | Fork of Quagga; OSPF/IS-IS/BGP/PIM/EVPN |
| BIRD | C | Lightweight, BGP-focused; widely used at IXPs |
| GoBGP | Go | BGP only; embeddable |
| ExaBGP | Python | Programmable BGP "speaker" |
| OpenBGPD | C | OpenBSD-grown |

### SDN / programmable
| Tool | Language |
|------|----------|
| ONOS / OpenDaylight | Java |
| Faucet | Python |
| P4 programs | P4 |
| eBPF/XDP | C → BPF |

### Config DSLs / APIs
- NETCONF / YANG, RESTCONF, gNMI/gNOI
- Ansible / SaltStack network modules

---

## Manual Pages

### What is in this section

```text
  Internet layer commands: IP addresses, routes, diagnostics, firewall, and VPN.

  ┌─── dedicated subfile ─────────────────────────────────────────────────┐
  │  ip_commands.md (ip addr/route · traceroute · mtr · ping · nmap)     │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── inline command groups ─────────────────────────────────────────────┐
  │  addresses/routes: ip addr · ip route · ip rule · ipcalc/sipcalc     │
  │  diagnostics: ping · traceroute · mtr · hping3 · nmap · conntrack    │
  │  firewall/NAT: iptables · nft · ipset · pf · firewalld · ufw         │
  │  routing daemons: vtysh (FRR) · birdc (BIRD) · gobgp · bgpq4        │
  │  VPN: wg/wg-quick (WireGuard) · swanctl (strongSwan) · openvpn      │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated man page references

| Topic | File |
|-------|------|
| IP & routing commands | [Internet Layer Commands](ip_commands.md) — ip addr/route, traceroute, mtr, ping, nmap |

---

### Addresses & routes
| Command | Purpose |
|---------|---------|
| `ip addr` | Show/assign IP addresses |
| `ip route` | Show/manage routing table |
| `ip -6 route` | IPv6 routing |
| `ip rule` | Policy routing (multiple tables) |
| `ipcalc` | Subnet math |
| `sipcalc` | More detailed subnet calc |
| `route -n` | Legacy routing display |

### Diagnostics
| Command | Purpose |
|---------|---------|
| `ping` / `ping6` | ICMP/ICMPv6 echo |
| `traceroute` / `traceroute6` / `tracepath` | Path discovery |
| `mtr` | Continuous traceroute + stats |
| `nmap -sn` | Host discovery (sweep) |
| `hping3` | Crafted ICMP/TCP/UDP probes |
| `arping -I eth0` | L2 reachability (cross-layer) |

### Firewall / NAT
| Command | Purpose |
|---------|---------|
| `iptables` / `ip6tables` | Legacy Linux firewall |
| `nft` (nftables) | Modern Linux firewall |
| `ipset` | Sets of IPs/ports for nft/iptables |
| `pf` (pfctl) | OpenBSD/macOS packet filter |
| `firewalld` | RHEL/Fedora firewall front-end |
| `ufw` | Ubuntu uncomplicated firewall |
| `conntrack` | View/modify conntrack table |

### Routing daemons
| Command | Purpose |
|---------|---------|
| `vtysh` | FRR unified CLI |
| `birdc` | BIRD client |
| `gobgp` | GoBGP CLI |
| `bgpq4` | Build prefix-lists from RIR data |

### VPN
| Command | Purpose |
|---------|---------|
| `wg` / `wg-quick` | WireGuard config |
| `swanctl` / `ipsec` | strongSwan |
| `ipsec` (Libreswan) | IKEv2/IKEv1 |
| `openvpn` | OpenVPN |

### macOS
- `route`, `netstat -rn`, `scutil --proxy`, `networksetup -setdnsservers`

### Windows
- `Get-NetIPAddress`, `Get-NetRoute`, `New-NetIPAddress`
- `route print`, `tracert`, `pathping`, `Get-NetIPInterface`

---

## Topics

### What is in this section

```text
  IP addressing, routing protocols, NAT, QoS, VPN tunnels, and multicast.

  ┌─── dedicated topic file ──────────────────────────────────────────────┐
  │  osi_model.md (7 layers · TCP/IP mapping · encapsulation · PDUs)     │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── IP addressing & routing ───────────────────────────────────────────┐
  │  IPv4: CIDR/VLSM · private RFC 1918 · fragmentation                  │
  │  IPv6: GUA/ULA/link-local · SLAAC/DHCPv6 · EUI-64 · privacy addrs   │
  │  ICMP/ICMPv6 · routing: LPM/FIB/RIB · BGP/OSPF/IS-IS/EIGRP          │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── NAT, QoS, VPN & multicast ─────────────────────────────────────────┐
  │  NAT: SNAT/DNAT · CGN · NAT64/DNS64 · hairpinning                    │
  │  QoS: DSCP/ECN · AQM (fq_codel/CAKE/PIE) · PMTUD · TCP MSS clamp    │
  │  VPN: IPsec · WireGuard · OpenVPN · multicast: PIM-SM/DM/SSM         │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated topic files

| Topic | File |
|-------|------|
| OSI Model | [The OSI Model](osi_model.md) — 7-layer ladder, TCP/IP mapping, encapsulation diagrams, PDU names |

---

### IPv4
- **Header** — 20 bytes minimum: VER/IHL, DSCP/ECN, total length, ID/flags/frag-offset, TTL, proto, checksum, src/dst, options.
- **Addressing** — classful (historical), CIDR, VLSM.
- **Private space** — RFC 1918 (10/8, 172.16/12, 192.168/16); CGNAT 100.64/10.
- **Special** — loopback 127/8, link-local 169.254/16, multicast 224/4.
- **Fragmentation** — IPv4 fragments on routers; reassembly at dest.

### IPv6
- **Header** — fixed 40 bytes + extension headers.
- **Address types** — global unicast, ULA (fc00::/7), link-local (fe80::/10), multicast (ff00::/8).
- **SLAAC** vs **DHCPv6** vs **DHCPv6-PD**.
- **EUI-64**, **privacy addresses** (RFC 4941).
- **Flow label**, **traffic class** (DSCP/ECN).
- **No router fragmentation** — PMTUD mandatory.

### ICMP
- **ICMPv4** — echo, dest-unreachable, time-exceeded, redirect, frag-needed.
- **ICMPv6** — additionally carries NDP, MLD, "Packet Too Big".
- **Don't filter PMTUD ICMP** — breaks paths.

### Routing
- **Longest-prefix match**, **FIB vs RIB**.
- **Static routes**, **default route**.
- **IGPs**: OSPFv2/v3, IS-IS, EIGRP (Cisco), RIP (legacy).
- **EGP**: BGP-4 (eBGP / iBGP), route reflectors, confederations.
- **BGP attributes** — AS_PATH, NEXT_HOP, LOCAL_PREF, MED, communities.
- **Policy routing / source routing** (ip rule).
- **ECMP** — equal-cost multi-path.

### NAT
- **SNAT / DNAT / Masquerade** (Linux conntrack).
- **PAT / PNAT** (port translation).
- **Stateful vs stateless** NAT.
- **CGN (RFC 6888)** — shared address space pitfalls.
- **NAT64 / DNS64** — IPv6-only to IPv4 services.
- **Hairpinning / NAT loopback**.

### MTU & PMTUD
- **Path MTU Discovery** (RFC 1191 / 8201).
- **TCP MSS clamping** as workaround.
- **Black holes** — silently dropped "Frag Needed".

### QoS
- **DSCP** (RFC 2474) — DiffServ code points.
- **ECN** (RFC 3168), **L4S** (RFC 9331/9332).
- **AQM** — fq_codel, CAKE, PIE.

### VPN / tunneling
- **IPsec** — AH vs ESP, transport vs tunnel mode, IKEv2.
- **WireGuard** — Noise-IK based, in-kernel since Linux 5.6.
- **OpenVPN** — TLS-based, TCP/UDP, userspace.
- **GRE / IP-in-IP / 6in4 / 6to4 / Teredo**.

### Multicast
- **IGMPv2/v3** (IPv4), **MLDv1/v2** (IPv6).
- **PIM-SM / DM / SSM**.
- **MSDP**, **Anycast RP**.

### Security cross-link
- BGP hijacks / RPKI → [Security › Topics](../14_Security/README.md#topics)
- IPsec/WireGuard crypto → [Security › Topics](../14_Security/README.md#topics)
- DDoS at L3/L4 → [Security › Topics](../14_Security/README.md#topics)

---

## Protocols

### What is in this section

```text
  Internet-layer protocols: IP family, routing, security, tunneling, and multicast.

  ┌─── dedicated protocol references ─────────────────────────────────────┐
  │  ipv4_ipv6.md (headers · addressing · ICMP · PMTUD)                  │
  │  bgp.md (path attributes · best-path selection · MP-BGP · security)  │
  │  ospf.md (packet types · neighbor FSM · area design · SPF algorithm) │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── routing protocols & security ──────────────────────────────────────┐
  │  IGPs: OSPFv2/v3 · IS-IS · EIGRP · RIP (legacy)                      │
  │  EGP: BGP-4 · eBGP/iBGP · route reflectors · confederations          │
  │  RPKI · ROA · BGPsec · ASPA (BGP route origin/path security)         │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── tunneling, VPN, NAT & multicast ───────────────────────────────────┐
  │  tunneling: GRE · IP-in-IP · 6in4 · L2TPv3                           │
  │  VPN: IPsec (AH/ESP/IKEv2) · WireGuard · OpenVPN                    │
  │  NAT: SNAT/DNAT/masquerade · NAT64/DNS64 · CGN · 464XLAT            │
  │  multicast: IGMPv2/v3 · MLDv1/v2 · PIM-SM/DM/SSM · MSDP            │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated protocol references

| Protocol | File |
|----------|------|
| IPv4 / IPv6 | [IP](ipv4_ipv6.md) — header layouts, addressing, ICMP, PMTUD |
| BGP | [BGP](bgp.md) — path attributes, best-path selection, MP-BGP, security |
| OSPF | [OSPF](ospf.md) — packet types, neighbor state machine, area design, LSA types, SPF algorithm |

---

### Internet Protocol family
| Protocol | RFC | Purpose |
|----------|-----|---------|
| IPv4 | 791 | Internet Protocol v4 |
| IPv6 | 8200 | Internet Protocol v6 |
| ICMP (IPv4) | 792 | Diagnostics & error messages |
| ICMPv6 | 4443 | Diagnostics + NDP + MLD |
| IGMP v1/v2/v3 | 1112 / 2236 / 3376 | IPv4 multicast group mgmt |
| MLD v1/v2 | 2710 / 3810 | IPv6 multicast listener |

### Routing protocols
| Protocol | RFC | Type | Use |
|----------|-----|------|-----|
| RIP v2 | 2453 | IGP, distance-vector | Legacy / small nets |
| OSPFv2 | 2328 | IGP, link-state | IPv4 enterprise |
| OSPFv3 | 5340 | IGP, link-state | IPv6 (and v4 via AF) |
| IS-IS | ISO 10589 / RFC 5302 | IGP, link-state | Large ISPs |
| EIGRP | 7868 | IGP, hybrid | Cisco-centric |
| BGP-4 | 4271 | EGP, path-vector | Internet, large enterprise |
| MP-BGP | 4760 | EGP extension | Multi-AF (IPv6, EVPN, VPNv4) |
| BFD | 5880 | Bidirectional Forwarding Detection | Fast fault detection |

### Routing security & policy
| Protocol | RFC | Purpose |
|----------|-----|---------|
| RPKI | 6480 | Resource PKI for prefix origin validation |
| BGPsec | 8205 | AS path crypto validation |
| ROA | 6482 | Route Origin Authorization records |
| ASPA | drafts | Autonomous System Provider Authorization (in progress) |

### Tunneling
| Protocol | RFC | Purpose |
|----------|-----|---------|
| GRE | 2784 / 7676 | Generic Routing Encapsulation |
| IP-in-IP (IPIP) | 2003 | Encapsulate IP in IP |
| 6in4 | 4213 | IPv6 in IPv4 |
| 6to4 | 3056 | Auto IPv6 over IPv4 (deprecated) |
| Teredo | 4380 | IPv6 through NAT (deprecated) |
| L2TPv3 | 3931 | L2 tunneling |

### VPN
| Protocol | RFC | Purpose |
|----------|-----|---------|
| IPsec AH | 4302 | Authentication Header |
| IPsec ESP | 4303 | Encapsulating Security Payload |
| IKEv2 | 7296 | Key exchange |
| WireGuard | (draft / live impl) | Modern minimal VPN |
| OpenVPN | (de facto) | TLS-based VPN |

### NAT-related
| Protocol | RFC | Purpose |
|----------|-----|---------|
| NAT64 | 6146 | IPv6 → IPv4 translation |
| DNS64 | 6147 | Synthesize AAAA from A |
| 464XLAT | 6877 | Hybrid for IPv6-only clients |
| CGN | 6888 | Carrier-grade NAT considerations |
| NAT-PMP | 6886 | Apple's NAT port-mapping |
| PCP | 6887 | Successor to NAT-PMP/UPnP IGD |

### Multicast routing
| Protocol | RFC | Purpose |
|----------|-----|---------|
| PIM-SM | 7761 | Sparse Mode |
| PIM-DM | 3973 | Dense Mode (rare today) |
| PIM-SSM | 4607 | Source-Specific Multicast |
| MSDP | 3618 | Multicast Source Discovery |
