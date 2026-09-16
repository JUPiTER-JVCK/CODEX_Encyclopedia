# Network Data Link — Manual Pages

## What is in this section

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

## Dedicated man page references

| Topic | File |
|-------|------|
| Data link layer commands | [datalink_commands.md](datalink_commands.md) — ip link, bridge, tc, arp, arping |

---

## Interface / bridge / VLAN
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

## ARP / NDP
| Command | Purpose |
|---------|---------|
| `ip neigh` | ARP/NDP table |
| `arp -a` | Legacy ARP view |
| `arping` | Send ARP probes |
| `ndisc6` | IPv6 neighbor discovery utilities |

## Capture / inspect
| Command | Purpose |
|---------|---------|
| `tcpdump -i eth0 -e -nn` | Live capture with link-layer info |
| `tshark` | Wireshark CLI |
| `tcpreplay` | Replay PCAPs onto a wire |
| `ettercap` | L2 MitM toolkit (audit only) |
| `bettercap` | Modern alternative |

## Bonding / aggregation
| Command | Purpose |
|---------|---------|
| `ip link add bond0 type bond mode 802.3ad` | LACP bond |
| `/proc/net/bonding/bond0` | Bond status |
| `teamdctl` | Team driver alternative |

## macOS
- `ifconfig`, `networksetup -listallhardwareports`, `arp -a`
- `tcpdump`, `pktap` (special interface for sandboxed captures)

## Windows
- `Get-NetAdapter`, `Get-NetNeighbor`, `Get-NetSwitchTeam`
- `arp -a`, `netsh interface`
