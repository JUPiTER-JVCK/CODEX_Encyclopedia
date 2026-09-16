# Network Application — References

## What is in this section

```text
  Books, critical RFCs, and online indexes for application layer protocols.

  ┌─── books ─────────────────────────────────────────────────────────────┐
  │  HTTP: The Definitive Guide · High Performance Browser Networking     │
  │  Bulletproof SSL and TLS · DNS and BIND · gRPC: Up and Running       │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── critical RFCs ─────────────────────────────────────────────────────┐
  │  HTTP: 9110/9111/9112/9113/9114 · TLS: 8446/5246/9325               │
  │  DNS: 1034/1035/8484(DoH)/7858(DoT)/9250(DoQ)                        │
  │  Auth: 6749/9700(OAuth) · Mail: 5321/5322 · SSH: 4251                │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── online ────────────────────────────────────────────────────────────┐
  │  IETF RFC index (rfc-editor.org) · IANA port/media-type registries   │
  └───────────────────────────────────────────────────────────────────────┘
```

## Books
- *HTTP: The Definitive Guide* — Gourley, Totty.
- *High Performance Browser Networking* — Ilya Grigorik.
- *Bulletproof SSL and TLS* — Ivan Ristić.
- *DNS and BIND* — Albitz, Liu.
- *gRPC: Up and Running* — Indrasiri, Kuruppu.
- *Designing Data-Intensive Applications* — Kleppmann (covers wire protocols in context).

## Critical RFCs
- **RFC 9110 / 9111 / 9112 / 9113 / 9114** — HTTP/1.1, caching, semantics, HTTP/2, HTTP/3 (the modern set)
- **RFC 8446** — TLS 1.3
- **RFC 5246** — TLS 1.2 (still common)
- **RFC 9325** — TLS BCP
- **RFC 1034 / 1035** — DNS (still load-bearing)
- **RFC 8484** — DoH
- **RFC 7858** — DoT
- **RFC 9250** — DoQ
- **RFC 6749** — OAuth 2.0
- **RFC 9700** — OAuth 2.0 Security BCP
- **RFC 5321 / 5322** — SMTP / Internet Message Format
- **RFC 4251** — SSH protocol architecture
- **RFC 9293** — TCP (cross-link from L4)

## Indexes
- IETF RFC index — `https://www.rfc-editor.org/`
- IANA registries — port numbers, media types, protocol parameters
