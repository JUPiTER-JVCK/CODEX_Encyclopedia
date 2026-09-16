# Network Transport — References

## What is in this section

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

## Books
- *TCP/IP Illustrated, Vol. 1 & 2* — Stevens, Fall (v1); Wright, Stevens (v2 — kernel impl)
- *UNIX Network Programming, Vol. 1 & 2* — W. Richard Stevens
- *High Performance Browser Networking* — Ilya Grigorik (free online)
- *HTTP/2 in Action* — Pollard
- *Learning HTTP/3* — O'Reilly

## Key RFCs
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

## Online
- nghttp2 / quiche / msquic blog posts
- Cloudflare blog (QUIC, BBR, MASQUE)
- aiortc / pion / mediasoup docs for SCTP-over-DTLS (WebRTC data)
