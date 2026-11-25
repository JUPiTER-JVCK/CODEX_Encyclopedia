# 12 — Network Transport (OSI L4)

> End-to-end delivery. Sockets, ports, reliability, congestion control, flow
> control. The handshake-and-window machinery that turns IP packets into
> usable byte streams or messages.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  13  Network Application (L7)                │
└───────────────────────┬──────────────────────┘
                        │  TCP / UDP / QUIC sockets
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  12  Network Transport (L4)       ◀── here   ┃
┃      segments · ports · reliability · flow   ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  IP packets, host to host
┌───────────────────────┴──────────────────────┐
│  11  Network Internet (L3)                   │
└──────────────────────────────────────────────┘
```

## At a glance

| Field | Value |
|-------|-------|
| OSI layer | 4 (Transport) |
| Description | End-to-end byte streams or datagrams, with optional reliability/order |
| Protocols | TCP, UDP, QUIC, SCTP, DCCP |
| Medium | IP packets |
| Example | TCP three-way handshake establishes a connection |
| Adjacent | ↓ [11_Network_Internet](../11_Network_Internet/), ↑ [13_Network_Application](../13_Network_Application/) |

## What lives here

- **TCP** — connection-oriented, ordered, reliable, congestion-controlled
- **UDP** — connectionless, unordered, unreliable, lightweight
- **QUIC** — UDP-based, multiplexed streams, built-in TLS 1.3, modern
- **SCTP** — message-oriented, multi-stream, multi-homed (signaling, WebRTC)
- **DCCP** — congestion-controlled UDP variant (niche)
- **Sockets API** — BSD sockets, Winsock, modern alternatives (io_uring, kqueue, IOCP)
- **Congestion control** — Reno, CUBIC, BBR, BBRv2/v3, DCTCP

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | TCP/IP Illustrated v1+v2, QUIC docs |
| [Lessons](#lessons) | [Interactive labs](transport_labs.md) | socket programming → tune TCP → QUIC server |
| [Languages](#languages) | — | socket APIs across languages |
| [Manual Pages](#manual-pages) | [Transport Layer Tools](transport_tools.md) | `ss`, `netstat`, `nc`, `socat`, `iperf3` |
| [Topics](#topics) | — | handshake, cwnd, sack, TFO, MPTCP, BBR |
| [Protocols](#protocols) | [QUIC](quic.md) · [TCP](tcp.md) · [UDP](udp.md) | TCP/UDP/QUIC/SCTP RFC table |

## Cross-references
- IP packets beneath → [11_Network_Internet](../11_Network_Internet/)
- App protocols above → [13_Network_Application](../13_Network_Application/)
- TLS rides on TCP (and is part of QUIC) → [Network Application › Protocols](../13_Network_Application/README.md#protocols)
- Socket-level kernel internals → [OS Kernel › Topics](../05_OS_Kernel/README.md#topics)

---

## References

### What is in this section

```text
  Transport-layer reference sources: books, key RFCs, and online resources.

  ┌─── books ─────────────────────────────────────────────────────────────┐
  │  TCP/IP Illustrated, Vol. 1 & 2 (Stevens/Wright)                     │
  │  UNIX Network Programming Vol.1&2 (Stevens)                          │
  │  High Performance Browser Networking (Grigorik, free online)          │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── key RFCs ──────────────────────────────────────────────────────────┐
  │  RFC 9293 (TCP) · RFC 768 (UDP) · RFC 9000–9002 (QUIC v1)           │
  │  RFC 5681/9438 (TCP CC/CUBIC) · RFC 3168 (ECN) · RFC 7414 (roadmap) │
  │  RFC 4960 (SCTP) · RFC 6824/8684 (MPTCP) · RFC 7413 (TFO)          │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── online ────────────────────────────────────────────────────────────┐
  │  Cloudflare blog (QUIC/BBR/MASQUE) · nghttp2/quiche/msquic docs      │
  │  Beej's Guide to Network Programming (free) · High Perf Browser Net  │
  └───────────────────────────────────────────────────────────────────────┘
```

### Books
- *TCP/IP Illustrated, Vol. 1 & 2* — Stevens, Fall (v1); Wright, Stevens (v2 — kernel impl)
- *UNIX Network Programming, Vol. 1 & 2* — W. Richard Stevens
- *High Performance Browser Networking* — Ilya Grigorik (free online)
- *HTTP/2 in Action* — Pollard
- *Learning HTTP/3* — O'Reilly

### Key RFCs
- **RFC 9293** — TCP (current consolidated spec)
- **RFC 768** — UDP
- **RFC 9000–9002** — QUIC v1
- **RFC 4960** — SCTP
- **RFC 4340** — DCCP
- **RFC 6298** — Computing TCP's RTO
- **RFC 5681 / 9438** — TCP Congestion Control / CUBIC
- **RFC 8312** — CUBIC (obsoleted by 9438)
- **RFC 7414** — TCP RFC roadmap
- **RFC 6824 / 8684** — Multipath TCP
- **RFC 7413** — TCP Fast Open
- **RFC 3168** — ECN

### Online
- nghttp2 / quiche / msquic blog posts
- Cloudflare blog (QUIC, BBR, MASQUE)
- aiortc / pion / mediasoup docs for SCTP-over-DTLS (WebRTC data)

---

## Lessons

### What is in this section

```text
  Transport layer hands-on: sockets, I/O models, TCP internals, and QUIC.

  ┌─── dedicated module ──────────────────────────────────────────────────┐
  │  transport_labs.md (TCP handshake · congestion window · UDP load test)│
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── lesson ladder ─────────────────────────────────────────────────────┐
  │  1–4: BSD sockets (C/Go/Rust) · non-blocking I/O · io_uring          │
  │  5–9: handshake · teardown · CUBIC/BBR · Nagle · TFO                 │
  │  10–12: QUIC/HTTP3 server · UDP reliability · SCTP basics            │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated Lesson Modules

| File | Covers |
|------|--------|
| [Network Transport — Interactive Labs](transport_labs.md) | TCP handshake capture, congestion window, UDP load test |

### Lesson ladder

1. **BSD sockets** — TCP echo server in C / Python / Go / Rust.
2. **Non-blocking I/O** — `select`, `poll`, `epoll` (Linux), `kqueue` (BSD/macOS), IOCP (Win).
3. **Modern async** — `io_uring`, `tokio`, asyncio: same echo server, different paradigm.
4. **Three-way handshake observed** — capture with Wireshark; SYN, SYN-ACK, ACK.
5. **TCP teardown** — FIN, TIME_WAIT, half-close.
6. **Congestion control comparison** — `iperf3` runs with `sysctl net.ipv4.tcp_congestion_control` flipped between cubic and bbr.
7. **Nagle vs delayed ACK** — interactive write patterns; the 200ms surprise.
8. **TCP_FASTOPEN** — enable, observe SYN cookies.
9. **TLS-on-TCP socket** — `openssl s_client`/`s_server`; compare overhead to plain TCP.
10. **QUIC server** — `quic-go`, `msquic`, or `quiche`: HTTP/3 hello.
11. **UDP reliability** — write a simple ACK/retransmit protocol; learn why TCP exists.
12. **SCTP basics** — `socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP)` on Linux.

### Suggested external
- Beej's Guide to Network Programming (free, classic)
- *High Performance Browser Networking* online

---

## Languages

### What is in this section

```text
  Socket APIs and async I/O across languages; QUIC library ecosystem.

  ┌─── socket APIs by language ───────────────────────────────────────────┐
  │  C/C++: <sys/socket.h> · Boost.Asio · epoll/kqueue/io_uring          │
  │  Python/Go/Rust: asyncio · goroutines+netpoller · tokio/async-std    │
  │  Java/Kotlin: NIO Selector · Loom · Netty                            │
  │  Node.js/Ruby/.NET: libuv · IOCP · async/await                       │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── QUIC libraries ────────────────────────────────────────────────────┐
  │  quiche (Rust/C · Cloudflare) · msquic (C · Microsoft)               │
  │  quic-go (Go · pure) · ngtcp2+nghttp3 (C) · aioquic (Python)         │
  └───────────────────────────────────────────────────────────────────────┘
```

The BSD sockets API has been ported into every mainstream language. The
interesting comparisons are the *async / event loop* models on top.

### Socket APIs by language
| Language | Sync sockets | Async / event |
|----------|--------------|---------------|
| C | `<sys/socket.h>` | `epoll`/`kqueue`/`io_uring`, libevent, libev, libuv |
| C++ | same as C, Boost.Asio, ASIO | Asio + coroutines, libuv |
| Python | `socket` | `asyncio`, `trio`, `anyio`; `selectors` |
| Go | `net` | goroutines + netpoller (epoll/kqueue under the hood) |
| Rust | `std::net` (sync) | `tokio`, `async-std`, `smol`, `monoio` (io_uring) |
| Java | `java.net.Socket`, NIO | NIO `Selector`, Project Loom virtual threads, Netty |
| Kotlin | same as Java | `kotlinx.coroutines` |
| Node.js | `net`, `dgram` | built on libuv |
| .NET | `System.Net.Sockets` | async/await, `IOCP` under the hood |
| Erlang/Elixir | `gen_tcp`, `gen_udp` | BEAM-native concurrency |
| Ruby | `Socket` | `async` gem, Fiber scheduler |
| Swift | `Network.framework` | Combine, async/await |

### QUIC libraries
| Library | Language | Notes |
|---------|----------|-------|
| quiche | Rust + C ABI | Cloudflare |
| msquic | C | Microsoft, cross-platform |
| quic-go | Go | Pure Go |
| ngtcp2 + nghttp3 | C | OpenSSL/BoringSSL bindings |
| aioquic | Python | Reference-ish |
| s2n-quic | Rust | AWS |

### SCTP
- `lksctp-tools` (Linux), `usrsctp` (userspace), `socket(2)` with `IPPROTO_SCTP`.

---

## Manual Pages

### What is in this section

```text
  Transport commands: socket inspection, load testing, capture, and tuning.

  ┌─── dedicated subfile ─────────────────────────────────────────────────┐
  │  transport_tools.md (ss · netstat · nc · socat · iperf3 · tcpdump)   │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── inline command groups ─────────────────────────────────────────────┐
  │  socket inspection: ss -tnp/unp · netstat -tunap · lsof -i · fuser   │
  │  active testing: nc · socat · iperf3 · tcpkali · wrk/vegeta          │
  │  capture: tcpdump · tshark · tcptrace · mtr --tcp                    │
  │  tuning: sysctl tcp_cc · socket buffers · TFO · ethtool offloads     │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated man page references

| Topic | File |
|-------|------|
| Transport layer tools | [Transport Layer Tools](transport_tools.md) — ss, netstat, nc, socat, iperf3, tcpdump |

---

### Socket / connection inspection
| Command | Purpose |
|---------|---------|
| `ss -tnp` | Listening + established TCP, with PIDs |
| `ss -unp` | UDP sockets |
| `ss -ltp` | Listening TCP only |
| `ss -i` | Per-socket info (cwnd, rtt, retrans) |
| `netstat -tunap` | Legacy equivalent |
| `lsof -i` | Open network files |
| `fuser -n tcp 443` | Which PIDs own a port |

### Active testing
| Command | Purpose |
|---------|---------|
| `nc` / `ncat` | TCP/UDP client+server swiss army knife |
| `socat` | Proxy/relay between addresses |
| `iperf3` | Throughput tests (TCP/UDP) |
| `tcpkali` | Stress test client |
| `wrk` / `wrk2` / `vegeta` | HTTP/TCP load test |

### Capture & analysis
| Command | Purpose |
|---------|---------|
| `tcpdump -i eth0 tcp port 443` | Live capture |
| `tshark -Y "tcp.analysis.retransmission"` | Filter retransmits |
| `wireshark` / `tshark -z conv,tcp` | Conversation summaries |
| `tcptrace` | Per-connection analysis from PCAP |
| `mtr --tcp` | Path probe via TCP SYN |

### Tuning
| Command | Purpose |
|---------|---------|
| `sysctl net.ipv4.tcp_congestion_control` | View/set CC algorithm |
| `sysctl net.core.rmem_max` etc | Socket buffer sizes |
| `sysctl net.ipv4.tcp_fastopen` | TFO mode |
| `ethtool -K eth0 gso on` | Offloads (GRO/GSO/TSO/LRO) |
| `tc qdisc` | Queueing disciplines (fq, fq_codel, cake) |

### QUIC / HTTP/3
| Command | Purpose |
|---------|---------|
| `curl --http3` | HTTP/3 request (build-dependent) |
| `quiche-client`, `quic-go` examples | QUIC clients/servers |
| `chrome://flags` (Chrome) | Toggle QUIC versions |

### Windows
- `Get-NetTCPConnection`, `Get-NetUDPEndpoint`
- `netsh interface tcp show global`
- `Test-NetConnection -Port 443`

### macOS
- `nettop`, `netstat -an`, `lsof -i`, `tcpdump`

---

## Topics

### What is in this section

```text
  TCP internals, congestion control, fast features, UDP, QUIC, and SCTP.

  ┌─── TCP fundamentals & reliability ────────────────────────────────────┐
  │  3WHS · state machine · seq/ACK · retransmit (RTO/fast) · SACK       │
  │  window scaling (rwnd) · Nagle · delayed ACK · TIME-WAIT             │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── congestion control & fast features ────────────────────────────────┐
  │  CUBIC (Linux default) · BBR/BBRv3 · Reno/NewReno · Vegas · DCTCP   │
  │  TFO · ECN/L4S · MPTCP · pacing (fq+BBR) · zero-copy/offloads       │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── UDP, QUIC, SCTP & I/O models ──────────────────────────────────────┐
  │  UDP: connectionless · datagram boundaries · GRO/GSO offloads         │
  │  QUIC: streams/migration/TLS1.3 built-in · 0-RTT · RFC 9000–9002     │
  │  SCTP: multi-stream/multi-home · I/O: epoll/kqueue/io_uring/IOCP     │
  └───────────────────────────────────────────────────────────────────────┘
```

### TCP fundamentals
- **Three-way handshake** — SYN → SYN-ACK → ACK; SYN cookies under flood.
- **State machine** — LISTEN, SYN-SENT, ESTABLISHED, FIN-WAIT, TIME-WAIT, etc.
- **Sequence/ACK numbers** — byte-level; PAWS protection.
- **Window** — receive (rwnd) + congestion (cwnd); MSS announce.
- **Options** — MSS, WSCALE, SACK, TS, MP_TCP.

### Reliability
- **Retransmission** — RTO computation (Karn, RFC 6298), fast retransmit (3 dup ACKs).
- **SACK / DSACK** — selective + duplicate.
- **Reordering tolerance** — RACK.
- **PRR** — Proportional Rate Reduction during loss.

### Congestion control
- **AIMD baseline** — additive increase, multiplicative decrease.
- **Reno / NewReno** — classic.
- **CUBIC** — Linux/Windows default (BIC successor).
- **BBR / BBRv2 / BBRv3** — bandwidth-RTT model.
- **DCTCP / ABE** — datacenter ECN-aware.
- **HTCP**, **Vegas**, **Westwood+** — historical / niche.

### Flow control & window scaling
- **Receive window** + **WSCALE** option.
- **Silly Window Syndrome** mitigations.

### Fast features
- **TCP Fast Open (RFC 7413)** — data in SYN with cookie.
- **TLS 1.3 0-RTT** — application layer counterpart.
- **Pacing** — fq qdisc + BBR.

### Multipath
- **MPTCP (RFC 8684)** — multiple subflows, single byte-stream.
- **Connection migration** in QUIC.

### UDP
- **No connection / no ACKs.**
- **Datagram boundaries preserved.**
- **Use cases** — DNS, NTP, video/audio (RTP), QUIC, custom protocols.
- **GSO/GRO for UDP** — modern Linux performance.

### QUIC
- **Header** — short vs long, connection ID, packet number.
- **Streams** — bidi/uni, flow control per-stream + per-connection.
- **0-RTT** and resumption.
- **Connection migration** — survives address change.
- **Built-in TLS 1.3** — no separate handshake.
- **Loss recovery (RFC 9002)**.

### SCTP
- **Multi-streaming** — head-of-line blocking per-stream only.
- **Multi-homing** — multiple IPs per association.
- **Partial reliability** (PR-SCTP).
- **Used in WebRTC data channels (over DTLS)**, **Diameter, SIGTRAN**.

### Sockets & I/O models
- **Blocking / non-blocking / multiplexed** (`select`/`poll`/`epoll`/`kqueue`).
- **Async submission** — `io_uring` (Linux), IOCP (Windows), Network.framework (Apple).
- **Zero-copy** — `sendfile`, `splice`, MSG_ZEROCOPY.
- **Offloads** — TSO/GSO/LRO/GRO/RSS/RPS.

### ECN / L4S
- **Classic ECN (RFC 3168)**.
- **L4S (RFC 9331/9332)** — DCTCP-style marking in the open internet.

### Security cross-link
- TCP RST / SYN flood / amplification → [Security › Topics](../14_Security/README.md#topics)
- QUIC's TLS 1.3 → [Network Application › Protocols](../13_Network_Application/README.md#protocols)

---

## Protocols

### What is in this section

```text
  Transport protocols: TCP, UDP, QUIC, SCTP; extensions, NAT traversal.

  ┌─── dedicated protocol references ─────────────────────────────────────┐
  │  tcp.md (segment header · state machine · congestion control)         │
  │  udp.md (datagram format · offloads · amplification attacks)          │
  │  quic.md (packet structure · handshake · streams · migration)         │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── core protocols & extensions ───────────────────────────────────────┐
  │  TCP (RFC 9293) · UDP (RFC 768) · SCTP (RFC 4960) · DCCP (RFC 4340)  │
  │  QUIC (RFC 9000–9002) over UDP · MPTCP (RFC 8684)                    │
  │  TCP extensions: SACK · WSCALE · ECN · TFO · BBR/CUBIC · RACK        │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── QUIC ecosystem & NAT traversal ────────────────────────────────────┐
  │  HTTP/3 (RFC 9114) · QUIC datagram · MASQUE · QUIC v2                │
  │  NAT traversal: STUN (RFC 8489) · TURN (RFC 8656) · ICE (RFC 8445)   │
  │  sockets: Berkeley · SOCKS5 · PROXY proto (HAProxy)                  │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated protocol references

| Protocol | File |
|----------|------|
| TCP | [TCP](tcp.md) — segment header, state machine, congestion control, ASCII diagrams |
| UDP | [UDP](udp.md) — datagram format, offloads, amplification attacks |
| QUIC | [QUIC](quic.md) — packet structure, handshake, stream multiplexing, migration |

---

### Core transport protocols
| Protocol | RFC(s) | IP proto # | Properties |
|----------|--------|-----------|------------|
| TCP | 9293 (consolidated; supersedes 793) | 6 | Connection, ordered, reliable, congestion-controlled |
| UDP | 768 | 17 | Connectionless, unordered, unreliable |
| QUIC | 9000, 9001, 9002 | 17 (over UDP) | Multiplexed streams, built-in TLS 1.3, conn migration |
| SCTP | 4960 | 132 | Message-oriented, multi-stream, multi-homed |
| DCCP | 4340 | 33 | UDP-like with congestion control (niche) |
| UDP-Lite | 3828 | 136 | UDP with partial checksum coverage |

### TCP extensions
| RFC | Feature |
|-----|---------|
| 1323 / 7323 | Window scaling, TS, PAWS |
| 2018 / 2883 | SACK / DSACK |
| 3168 | ECN |
| 5681 | Standard congestion control (Reno) |
| 9438 | CUBIC |
| 7413 | TCP Fast Open |
| 7414 | RFC roadmap |
| 8684 | Multipath TCP (MPTCP v1) |
| 8985 | RACK-TLP loss detection |

### QUIC ecosystem
| RFC | Title |
|-----|-------|
| 9000 | QUIC v1 transport |
| 9001 | Using TLS to secure QUIC |
| 9002 | QUIC loss detection & congestion control |
| 9114 | HTTP/3 |
| 9221 | Unreliable Datagram Extension |
| 9298 | MASQUE / CONNECT-UDP |
| 9484 | QUIC version 2 (v2) |

### SCTP extensions
| RFC | Feature |
|-----|---------|
| 3758 | PR-SCTP (partial reliability) |
| 5061 | Dynamic Address Reconfiguration |
| 8260 | Stream Schedulers |

### ECN / L4S
| RFC | Title |
|-----|-------|
| 3168 | Explicit Congestion Notification |
| 8311 | Updates for L4S experimentation |
| 9331 | L4S architecture |
| 9332 | DualQ Coupled AQM |

### Sockets / shim protocols
- **Berkeley sockets** — de-facto API
- **SOCKS5 (RFC 1928)** — proxy protocol
- **PROXY protocol v1/v2** (HAProxy) — preserve client info through L4 LB

### NAT traversal / signaling
| Protocol | RFC | Purpose |
|----------|-----|---------|
| STUN | 8489 | NAT discovery |
| TURN | 8656 | Relayed transport |
| ICE | 8445 | Combined STUN/TURN candidate gathering |
