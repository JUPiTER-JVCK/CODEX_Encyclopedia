# 13 — Network Application (OSI L5–L7)

> Application-level protocols: HTTP/2/3, DNS, TLS, SSH, mail, file transfer,
> messaging. The protocols that user-facing software actually speaks on the
> wire.

## In the stack

```text
┌──────────────────────────────────────────────┐
│  08  User Applications                       │
└───────────────────────┬──────────────────────┘
                        │  application protocol messages
┏━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┓
┃  13  Network Application (L7)     ◀── here   ┃
┃      HTTP · DNS · TLS · SMTP · SSH           ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  TCP / UDP / QUIC sockets
┌───────────────────────┴──────────────────────┐
│  12  Network Transport (L4)                  │
└──────────────────────────────────────────────┘
```

## At a glance

| Field | Value |
|-------|-------|
| OSI layers | 5 (Session), 6 (Presentation), 7 (Application) |
| Description | App-level protocols, sessions, encoding |
| Protocols | HTTP/1.1/2/3, gRPC, DNS, TLS, SSH, SMTP, IMAP, FTP, MQTT, AMQP, WebSocket |
| Medium | TCP / UDP / QUIC |
| Example | Browser issues `GET / HTTP/2` over TLS over TCP |
| Adjacent | ↓ [12_Network_Transport](../12_Network_Transport/), ↑ [08_User_Applications](../08_User_Applications/) |

## What lives here

- **Web** — HTTP/1.1, HTTP/2, HTTP/3, WebSocket, WebTransport
- **APIs** — REST, gRPC, GraphQL, JSON-RPC, SOAP (legacy), tRPC
- **DNS / DoH / DoT / DoQ**
- **TLS 1.2 / 1.3, mTLS, certificate ecosystems (ACME / Let's Encrypt)**
- **SSH** — interactive, SFTP, scp, port forwarding
- **Mail** — SMTP, IMAP, POP3, JMAP; SPF/DKIM/DMARC/ARC; MTA-STS
- **File transfer** — FTP/FTPS, SFTP, rsync, WebDAV
- **Real-time** — RTP, RTCP, SIP, RTSP, WebRTC (DTLS-SRTP, SCTP-over-DTLS data channels)
- **IoT / messaging** — MQTT, AMQP, CoAP, NATS, Kafka protocol
- **Auth / identity** — OAuth 2.x, OIDC, SAML, Kerberos, LDAP, WebAuthn
- **Directory / DBs over wire** — LDAP, NFS, SMB, AFP, RDP, VNC
- **Network management** — SNMP, NETCONF, gNMI, syslog
- **Time** — NTP, PTP

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | RFCs, RFC index, IANA registries |
| [Lessons](#lessons) | [Interactive labs](application_labs.md) | build an HTTP server → HTTPS → HTTP/3 → mTLS |
| [Languages](#languages) | — | server frameworks, client libs |
| [Manual Pages](#manual-pages) | [Application Layer Protocol Tools](app_protocol_tools.md) | `curl`, `dig`, `ssh`, `openssl s_client` |
| [Topics](#topics) | — | HTTP semantics, DNS, TLS, mail auth, OAuth |
| [Protocols](#protocols) | [DHCP](dhcp.md) · [DNS](dns.md) · [HTTP](http.md) · [MQTT](mqtt.md) · [OAuth 2.0 / 2.1](oauth2.md) · [SSH](ssh.md) · [TLS](tls.md) | exhaustive L7 protocol table |

## Cross-references
- Where these run from → [08_User_Applications](../08_User_Applications/)
- Transport beneath → [12_Network_Transport](../12_Network_Transport/)
- TLS / certs / OAuth attacks → [Security › Topics](../14_Security/README.md#topics)

---

## References

### What is in this section

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

### Books
- *HTTP: The Definitive Guide* — Gourley, Totty.
- *High Performance Browser Networking* — Ilya Grigorik.
- *Bulletproof SSL and TLS* — Ivan Ristić.
- *DNS and BIND* — Albitz, Liu.
- *gRPC: Up and Running* — Indrasiri, Kuruppu.
- *Designing Data-Intensive Applications* — Kleppmann (covers wire protocols in context).

### Critical RFCs
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

### Indexes
- IETF RFC index — `https://www.rfc-editor.org/`
- IANA registries — port numbers, media types, protocol parameters

---

## Lessons

### What is in this section

```text
  Application layer hands-on: HTTP, TLS, DNS, auth, WebRTC, and messaging.

  ┌─── dedicated module ──────────────────────────────────────────────────┐
  │  application_labs.md (DNS trace · TLS decode · HTTP/2 framing)       │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── lesson ladder ─────────────────────────────────────────────────────┐
  │  1–5: HTTP/1.1 by hand · HTTP/2 · HTTP/3 · TLS handshake · ACME     │
  │  6–10: mTLS · DNS/DNSSEC/DoH · OAuth2+PKCE · WebSocket · gRPC       │
  │  11–15: MQTT · SMTP+SPF/DKIM/DMARC · SSH tricks · WebRTC data       │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated Lesson Modules

| File | Covers |
|------|--------|
| [Network Application — Interactive Labs](application_labs.md) | DNS trace, TLS decode, HTTP/2 framing |

### Lesson ladder

1. **HTTP/1.1 by hand** — `telnet` (or `nc`) to port 80; type `GET / HTTP/1.1\r\nHost: ...\r\n\r\n`.
2. **HTTP/2 server** — nginx or h2o; verify with `curl --http2`.
3. **HTTP/3 server** — quiche/caddy/H2O; verify with `curl --http3`.
4. **TLS handshake** — `openssl s_client -connect host:443 -tls1_3`; read the certs.
5. **ACME / Let's Encrypt** — issue a cert via `certbot` or `acme.sh`; auto-renew.
6. **mTLS** — issue client cert + private CA; nginx `ssl_verify_client on`.
7. **DNS zone** — author a zone file; sign with DNSSEC; serve with BIND/Knot.
8. **DoH/DoT clients** — `dnscrypt-proxy`, `cloudflared`, `stubby`.
9. **OAuth 2.1 flow** — implement Authorization Code + PKCE end-to-end.
10. **WebSocket** — chat server (gorilla/ws, ws (npm), websockets (py)).
11. **gRPC** — define a .proto, generate code, call from two languages.
12. **MQTT** — Mosquitto broker, paho client, QoS levels.
13. **SMTP triad** — set up SPF + DKIM + DMARC for a domain; test with mail-tester.com.
14. **SSH cheats** — port forwarding (`-L`, `-R`, `-D`), ProxyJump, certs not keys.
15. **WebRTC data channel** — STUN/TURN + SCTP-over-DTLS hello.

### Suggested external
- web.dev "Performance" track
- Cloudflare Learning Center
- HTTP/3 explained (Daniel Stenberg, free)

---

## Languages

### What is in this section

```text
  Web frameworks, HTTP clients, RPC stacks, and protocol-specific libraries.

  ┌─── server-side web frameworks ────────────────────────────────────────┐
  │  Node.js: Express/Fastify/Hono · TS full-stack: Next.js/SvelteKit    │
  │  Python: Django/FastAPI/Flask · Go: Gin/Echo/Fiber                   │
  │  Rust: Axum/Actix-web · JVM: Spring Boot/Quarkus · .NET: ASP.NET Core│
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── HTTP clients & RPC ────────────────────────────────────────────────┐
  │  HTTP clients: curl/libcurl · requests/httpx · reqwest · okhttp      │
  │  RPC: gRPC+Protobuf · GraphQL · JSON-RPC · Thrift · tRPC (TS)        │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── DNS, mail, SSH & real-time ────────────────────────────────────────┐
  │  DNS: getdns/c-ares/unbound/Knot/BIND                                │
  │  mail: Postfix/Exim/OpenSMTPD · IMAP: Dovecot · SMTP libs            │
  │  SSH: OpenSSH/libssh · real-time: WebRTC/RTP/SIP · MQTT/AMQP/Kafka  │
  └───────────────────────────────────────────────────────────────────────┘
```

### Server-side web frameworks
| Framework | Language |
|-----------|----------|
| Express, Fastify, NestJS, Hono | Node.js / TS |
| Next.js, SvelteKit, Astro, Remix | TS (full-stack) |
| Django, FastAPI, Flask, Starlette | Python |
| Rails, Sinatra, Hanami | Ruby |
| Gin, Echo, Fiber, Chi, net/http | Go |
| Axum, Actix-web, Rocket, Warp, Tower | Rust |
| Spring Boot, Quarkus, Micronaut, Ktor | JVM |
| ASP.NET Core, Minimal API | .NET |
| Laravel, Symfony, Slim | PHP |
| Phoenix, Plug | Elixir |

### HTTP client libraries
| Library | Language |
|---------|----------|
| `curl` / `libcurl` | C |
| `requests`, `httpx`, `aiohttp` | Python |
| `axios`, `fetch`, `got`, `undici` | JS/TS |
| `reqwest`, `hyper`, `ureq` | Rust |
| `net/http`, `resty` | Go |
| `okhttp`, `apache hc`, `java.net.http` | Java |
| `HttpClient` (System.Net.Http) | .NET |

### RPC / IDL ecosystems
| Stack | Languages |
|-------|-----------|
| gRPC + Protobuf | Generators for ~12 languages |
| Cap'n Proto | C++, Rust, Python, ... |
| Thrift | Many |
| Avro | Java/JVM-centric |
| GraphQL (relay/apollo/urql) | Cross-language |
| tRPC | TS-only end-to-end typing |

### DNS / mail / SSH (libraries)
| Use | Libraries |
|-----|-----------|
| DNS resolver / server | `getdns`, `c-ares`, `unbound`, `dnsmasq`, `knot`, BIND |
| SMTP server | Postfix, Exim, OpenSMTPD, Haraka |
| IMAP server | Dovecot, Cyrus |
| SSH | OpenSSH, libssh, libssh2, paramiko |

### Real-time
| Use | Libraries |
|-----|-----------|
| WebRTC | mediasoup, pion, aiortc, libwebrtc |
| RTP / SIP | PJSIP, FreeSWITCH, Asterisk |
| MQTT | Eclipse Paho, Mosquitto, mqtt-go |
| AMQP | RabbitMQ client libs |
| Kafka | librdkafka, confluent-kafka-* |

---

## Manual Pages

### What is in this section

```text
  Application layer commands: HTTP, TLS, DNS, SSH, mail, and inspection.

  ┌─── dedicated subfile ─────────────────────────────────────────────────┐
  │  app_protocol_tools.md (curl · openssl s_client · dig · mosquitto)   │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── inline command groups ─────────────────────────────────────────────┐
  │  HTTP: curl · wget · httpie · xh · nghttp/h2load · caddy/nginx       │
  │  TLS/certs: openssl s_client · certbot · mkcert · testssl.sh         │
  │  DNS: dig +trace · drill · kdig · dnscrypt-proxy · cloudflared       │
  │  SSH/SCP: ssh · scp · sftp · ssh-keygen · mosh · port forwards       │
  │  mail/IoT: swaks · mosquitto_pub/_sub · kcat · amqp-tools            │
  │  inspect: mitmproxy · wireshark · tshark · burp · mtr · nmap         │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated man page references

| Topic | File |
|-------|------|
| Application protocol tools | [Application Layer Protocol Tools](app_protocol_tools.md) — curl, openssl s_client, dig, mosquitto |

---

### HTTP
| Command | Purpose |
|---------|---------|
| `curl` | All-purpose HTTP(S) client |
| `wget` | File-download focused |
| `httpie` (`http`) | Friendly JSON-first client |
| `xh` | Rust HTTPie alternative |
| `nghttp` / `h2load` | HTTP/2 client + load tester |
| `caddy`, `nginx`, `apache2ctl` | Web servers |

### TLS / certificates
| Command | Purpose |
|---------|---------|
| `openssl s_client -connect host:443` | TLS connect, show cert chain |
| `openssl s_server` | TLS test server |
| `openssl x509 -in cert.pem -noout -text` | Decode cert |
| `openssl req` / `genrsa` / `genpkey` | Keys & CSRs |
| `certbot` / `acme.sh` / `lego` | ACME clients |
| `mkcert` | Local trusted certs |
| `step ca` / `step cli` | smallstep CA |
| `testssl.sh` | TLS server config scanner |

### DNS
| Command | Purpose |
|---------|---------|
| `dig +trace example.com` | Authoritative trace |
| `dig @1.1.1.1 a example.com` | Specific resolver |
| `drill` | LDNS alternative to dig |
| `host`, `nslookup` | Simpler lookups |
| `kdig` | Knot's modern dig |
| `dnscrypt-proxy`, `cloudflared proxy-dns` | DoH/DoT clients |

### SSH / SCP / SFTP
| Command | Purpose |
|---------|---------|
| `ssh`, `scp`, `sftp`, `rsync -e ssh` | Core SSH suite |
| `ssh-keygen`, `ssh-add`, `ssh-agent` | Keys & agent |
| `ssh -L`, `-R`, `-D`, `-J` | Forwards & jumps |
| `mosh` | Mobile shell over UDP |

### Mail / messaging
| Command | Purpose |
|---------|---------|
| `swaks` | SMTP testing |
| `mailx`, `mutt`, `neomutt` | CLI mail clients |
| `mosquitto_pub` / `_sub` | MQTT |
| `kcat` (kafkacat) | Kafka CLI |
| `amqp-tools` | AMQP CLI |

### Misc app-layer
| Command | Purpose |
|---------|---------|
| `whois` | Registry data |
| `traceroute --tcp -p 443` | App-port path probe |
| `mtr --tcp --port 443` | Same continuous |
| `nmap -sV -p 443` | Service / version detect |
| `ldapsearch` | LDAP queries |
| `smbclient` / `cifs-utils` | SMB clients |
| `snmpwalk`, `snmpget` | SNMP queries |
| `chronyc tracking` / `ntpq -p` | NTP status |
| `ptp4l`, `phc2sys` | PTP daemons |

### Reverse engineering / inspection
- `mitmproxy`, `proxify`, `wireshark`, `tshark`, `burp` (commercial)

---

## Topics

### What is in this section

```text
  Application layer topics: HTTP, RPC, DNS, TLS, auth, mail, and IoT.

  ┌─── HTTP & REST/RPC ───────────────────────────────────────────────────┐
  │  HTTP/1.1/2/3 · caching · CORS · cookies · WebSocket · SSE           │
  │  REST/HATEOAS · gRPC · GraphQL · tRPC · OpenAPI · JSON-RPC           │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── DNS & TLS ─────────────────────────────────────────────────────────┐
  │  DNS records (A/AAAA/MX/SRV/HTTPS) · resolution flow · DNSSEC        │
  │  DoH/DoT/DoQ · TLS 1.2/1.3 · ciphers · cert chain · SNI/ECH · ACME  │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── auth & mail ───────────────────────────────────────────────────────┐
  │  OAuth 2.0/2.1+PKCE · OIDC · JWT/JOSE · SAML · WebAuthn/passkeys    │
  │  SMTP/IMAP/JMAP · SPF/DKIM/DMARC · ARC · MTA-STS                    │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── real-time, IoT & management ───────────────────────────────────────┐
  │  RTP/RTCP · SIP · WebRTC (ICE/DTLS-SRTP/SCTP) · HLS/DASH            │
  │  MQTT 5.0 · CoAP · AMQP · NATS · Kafka                              │
  │  SNMP v3 · NETCONF/YANG · gNMI · syslog · NTP v4 · PTPv2            │
  └───────────────────────────────────────────────────────────────────────┘
```

### HTTP
- **HTTP/1.1** — text framing, headers, methods, status codes, keep-alive.
- **HTTP/2** — binary framing, multiplexing, HPACK, server push (deprecated).
- **HTTP/3** — over QUIC; no HoL blocking; QPACK.
- **Caching** — `Cache-Control`, ETag, `Last-Modified`, Vary, RFC 9111.
- **CORS** — preflight, credentialed requests.
- **Cookies & Same-Site**, **Set-Cookie** flags (Secure, HttpOnly, Partitioned).
- **WebSocket (RFC 6455)** + extensions, **WebTransport** (QUIC).
- **Server-Sent Events**.
- **Compression** — gzip, br (brotli), zstd (Content-Encoding).

### REST / RPC / API
- **REST principles**, **HATEOAS**, **JSON:API**.
- **gRPC** — protobuf + HTTP/2; client/server/bidi streaming.
- **GraphQL** — schema, queries, mutations, subscriptions; federation.
- **OpenAPI / Swagger** — REST IDL.
- **JSON-RPC, MessagePack-RPC, Thrift, Cap'n Proto**.
- **tRPC** — TS-only RPC.

### DNS
- **Record types** — A, AAAA, CNAME, MX, TXT, SRV, NS, SOA, CAA, HTTPS/SVCB.
- **Resolution flow** — stub → recursor → roots → TLD → authoritative.
- **DNSSEC** — RRSIG, DNSKEY, DS, NSEC/NSEC3.
- **DoH (RFC 8484), DoT (7858), DoQ (9250)** — encrypted transports.
- **EDNS Client Subnet, EDNS0 cookies**.

### TLS
- **TLS 1.2 vs 1.3 handshake** — round trips, 0-RTT.
- **Cipher suites** — AEAD (AES-GCM, ChaCha20-Poly1305); deprecated CBC.
- **Cert chain** — root, intermediate, leaf; SCT (CT logs).
- **SNI**, **ESNI/ECH** (Encrypted ClientHello).
- **ACME (RFC 8555)** — challenges: HTTP-01, DNS-01, TLS-ALPN-01.
- **mTLS**, **SPIFFE/SPIRE** workload identity.

### Auth & identity
- **OAuth 2.0 / 2.1** — Authorization Code + PKCE, Client Credentials, Device Code.
- **OIDC** — id_token (JWT), discovery, scopes (openid/profile/email).
- **JWT** — JWS/JWE; pitfalls (alg=none, key confusion).
- **SAML 2.0**, **Kerberos**, **LDAP bind / SASL**.
- **WebAuthn / passkeys, FIDO2**.

### Mail
- **SMTP / submission (587) / SMTPS (465 implicit) / STARTTLS**.
- **IMAP, POP3, JMAP** — retrieval.
- **SPF (RFC 7208), DKIM (6376), DMARC (7489), ARC, BIMI, MTA-STS, TLS-RPT**.

### File / sharing
- **FTP / FTPS / SFTP / SCP**, **WebDAV / CalDAV / CardDAV**.
- **NFS v3 / v4**, **SMB1/2/3**, **AFP** (legacy), **rsync**.

### Real-time / media
- **RTP / RTCP**, **SIP**, **RTSP**.
- **WebRTC** — ICE, DTLS-SRTP, SCTP-over-DTLS data channels.
- **HLS / MPEG-DASH** — streaming over HTTP.

### IoT / messaging
- **MQTT (5.0)**, **CoAP**, **AMQP 0.9.1 / 1.0**, **NATS**, **Kafka protocol**.

### Management & time
- **SNMP v2c/v3**, **NETCONF / YANG**, **gNMI / gNOI**.
- **syslog (RFC 5424)**, **journald native** export.
- **NTP v4**, **PTPv2 (IEEE 1588)** — high-precision time.

### Security cross-link
- HTTP smuggling, request splitting, JWT bugs, OAuth pitfalls → [Security › Topics](../14_Security/README.md#topics)
- TLS misconfigurations, BEAST/POODLE/etc. → [Security › Topics](../14_Security/README.md#topics)

---

## Protocols

### What is in this section

```text
  Application layer protocols: web, RPC, TLS, DNS, auth, mail, and IoT.

  ┌─── dedicated protocol refs ───────────────────────────────────────────┐
  │  http.md · tls.md · dns.md · ssh.md · dhcp.md · mqtt.md · oauth2.md  │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── web & RPC ─────────────────────────────────────────────────────────┐
  │  HTTP/1.1 (text) → HTTP/2 (binary/HPACK) → HTTP/3 (QUIC/QPACK)      │
  │  WebSocket · WebTransport · SSE · gRPC+Protobuf · GraphQL            │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── TLS, DNS & auth ───────────────────────────────────────────────────┐
  │  TLS 1.3/1.2 · DTLS · ALPN · ECH · ACME · Certificate Transparency  │
  │  DNS/DNSSEC · DoH/DoT/DoQ · EDNS(0) · SVCB/HTTPS records            │
  │  OAuth 2.0/2.1 · OIDC · JWT/JOSE · WebAuthn/FIDO2 · Kerberos        │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── mail, file, real-time & IoT ───────────────────────────────────────┐
  │  SMTP/IMAP/JMAP · SPF/DKIM/DMARC · ARC · MTA-STS                    │
  │  FTP/FTPS/SFTP · WebDAV · NFS v4 · SMB 3 · rsync                    │
  │  RTP/RTCP · SIP · WebRTC (ICE+DTLS-SRTP+SCTP) · HLS · DASH          │
  │  MQTT 5.0 · CoAP · AMQP · NATS · Kafka · SNMP v3 · NTP/PTP          │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated protocol references

| Protocol | File |
|----------|------|
| HTTP (1.1 / 2 / 3) | [http.md](http.md) — versions, framing, methods, caching, security headers |
| TLS (1.2 / 1.3) | [TLS](tls.md) — handshake diagrams, cipher suites, certificates, ACME |
| DNS | [DNS](dns.md) — resolution flow, records, DNSSEC, encrypted DNS |
| SSH | [SSH](ssh.md) — protocol layers, key exchange, auth methods, port forwarding, hardening |
| DHCP | [DHCP](dhcp.md) — DORA process, DHCPv6, relay, snooping, options table |
| MQTT | [MQTT](mqtt.md) — pub/sub architecture, QoS levels, MQTT 5.0, LWT, retained messages |
| OAuth 2.0 | [OAuth 2.0 / 2.1](oauth2.md) — authorization code + PKCE flow, tokens, OIDC, security BCP |

---

### Web / HTTP family
| Protocol | RFC(s) | Notes |
|----------|--------|-------|
| HTTP/1.1 | 9112 + 9110/9111 | Text, headers, keep-alive |
| HTTP/2 | 9113 | Binary, multiplexed |
| HTTP/3 | 9114 | Over QUIC |
| WebSocket | 6455 | Upgrade-based bidirectional |
| WebTransport | drafts | Over HTTP/3 |
| Server-Sent Events | (W3C / WHATWG) | One-way streaming |
| HPACK / QPACK | 7541 / 9204 | Header compression |
| HTTP caching | 9111 | Cache-Control semantics |

### RPC / APIs
| Protocol | Owner | Notes |
|----------|-------|-------|
| gRPC | CNCF | HTTP/2 + protobuf |
| JSON-RPC 2.0 | jsonrpc.org | Spec |
| GraphQL | GraphQL Foundation | Schema + query language |
| OData | OASIS | RESTful conventions |
| SOAP / WS-* | W3C / OASIS | Legacy XML RPC |
| Cap'n Proto / Thrift / Avro | various | IDL-based |

### TLS / crypto transport
| Protocol | RFC | Notes |
|----------|-----|-------|
| TLS 1.3 | 8446 | Current |
| TLS 1.2 | 5246 | Still widely deployed |
| DTLS 1.2 / 1.3 | 6347 / 9147 | TLS over UDP |
| ALPN | 7301 | App-layer protocol negotiation |
| ESNI / ECH | drafts | Encrypted ClientHello |
| ACME | 8555 | Cert issuance protocol |
| CT (Certificate Transparency) | 9162 | Auditable cert logs |

### DNS
| Protocol | RFC | Notes |
|----------|-----|-------|
| DNS | 1034 / 1035 | Foundational |
| DNSSEC | 4033–4035 | Signed records |
| DoH | 8484 | DNS over HTTPS |
| DoT | 7858 | DNS over TLS |
| DoQ | 9250 | DNS over QUIC |
| EDNS(0) | 6891 | Extension mechanism |
| SVCB / HTTPS | 9460 | Service binding records |

### Auth / identity
| Protocol | RFC / Spec | Notes |
|----------|------------|-------|
| OAuth 2.0 | 6749 + 9700 (BCP) | Authorization framework |
| OAuth 2.1 | drafts | Consolidates 2.0 BCP |
| OIDC | OpenID | Identity layer on OAuth |
| SAML 2.0 | OASIS | Enterprise SSO |
| WebAuthn / FIDO2 | W3C / FIDO | Passkeys |
| JWT | 7519 | JSON token |
| JOSE | 7515–7520 | JWS/JWE/JWK/JWA |
| Kerberos v5 | 4120 | Ticket-based |
| LDAP v3 | 4511 | Directory access |
| SASL | 4422 | Auth framework |

### Mail
| Protocol | RFC | Notes |
|----------|-----|-------|
| SMTP | 5321 | Transport |
| Submission | 6409 | Port 587 |
| IMAP4rev2 | 9051 | Retrieval |
| POP3 | 1939 | Retrieval (legacy) |
| JMAP | 8620+ | Modern mail/contacts/cal API |
| SPF | 7208 | Sender Policy Framework |
| DKIM | 6376 | Signed mail |
| DMARC | 7489 | Alignment policy |
| ARC | 8617 | Forwarding chain |
| MTA-STS | 8461 | TLS policy discovery |
| TLS-RPT | 8460 | Reporting |

### File transfer
| Protocol | RFC | Notes |
|----------|-----|-------|
| FTP | 959 | Active/passive |
| FTPS | 4217 | FTP over TLS |
| SFTP | (SSH spec) | Distinct from FTPS |
| WebDAV | 4918 | HTTP-based |
| NFS v4.x | 7530 | Network filesystem |
| SMB 3 | MS-SMB2 | Microsoft FS |
| rsync | (de facto) | Delta sync |

### Real-time / media
| Protocol | RFC | Notes |
|----------|-----|-------|
| RTP / RTCP | 3550 | Media transport |
| SIP | 3261 | Signaling |
| RTSP | 7826 | Streaming control |
| SDP | 8866 | Session description |
| SRTP | 3711 | Secure RTP |
| WebRTC | (W3C bundle) | ICE + DTLS-SRTP + SCTP |
| HLS | 8216 | Apple HTTP streaming |
| DASH | ISO 23009 | MPEG DASH |

### IoT / messaging
| Protocol | Spec | Notes |
|----------|------|-------|
| MQTT 5.0 | OASIS | Pub/sub |
| AMQP 0.9.1 | RabbitMQ | Brokered |
| AMQP 1.0 | OASIS | Different model |
| CoAP | RFC 7252 | UDP REST-ish for IoT |
| NATS | (de facto) | High-throughput pub/sub |
| Kafka protocol | (de facto) | Log-based |

### Management / time
| Protocol | RFC | Notes |
|----------|-----|-------|
| SNMP v3 | 3411–3418 | With security |
| NETCONF | 6241 | XML config |
| RESTCONF | 8040 | HTTP analog |
| gNMI / gNOI | OpenConfig | gRPC-based |
| syslog | 5424 | Structured logging |
| NTP v4 | 5905 | Time sync |
| NTS | 8915 | NTP authentication |
| PTPv2 | IEEE 1588 | Precision time |
| BMC / Redfish | DMTF | Out-of-band mgmt (cross-link [03_Firmware_BIOS](../03_Firmware_BIOS/)) |
