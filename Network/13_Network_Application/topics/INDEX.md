# Network Application — Topics

## What is in this section

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

## HTTP
- **HTTP/1.1** — text framing, headers, methods, status codes, keep-alive.
- **HTTP/2** — binary framing, multiplexing, HPACK, server push (deprecated).
- **HTTP/3** — over QUIC; no HoL blocking; QPACK.
- **Caching** — `Cache-Control`, ETag, `Last-Modified`, Vary, RFC 9111.
- **CORS** — preflight, credentialed requests.
- **Cookies & Same-Site**, **Set-Cookie** flags (Secure, HttpOnly, Partitioned).
- **WebSocket (RFC 6455)** + extensions, **WebTransport** (QUIC).
- **Server-Sent Events**.
- **Compression** — gzip, br (brotli), zstd (Content-Encoding).

## REST / RPC / API
- **REST principles**, **HATEOAS**, **JSON:API**.
- **gRPC** — protobuf + HTTP/2; client/server/bidi streaming.
- **GraphQL** — schema, queries, mutations, subscriptions; federation.
- **OpenAPI / Swagger** — REST IDL.
- **JSON-RPC, MessagePack-RPC, Thrift, Cap'n Proto**.
- **tRPC** — TS-only RPC.

## DNS
- **Record types** — A, AAAA, CNAME, MX, TXT, SRV, NS, SOA, CAA, HTTPS/SVCB.
- **Resolution flow** — stub → recursor → roots → TLD → authoritative.
- **DNSSEC** — RRSIG, DNSKEY, DS, NSEC/NSEC3.
- **DoH (RFC 8484), DoT (7858), DoQ (9250)** — encrypted transports.
- **EDNS Client Subnet, EDNS0 cookies**.

## TLS
- **TLS 1.2 vs 1.3 handshake** — round trips, 0-RTT.
- **Cipher suites** — AEAD (AES-GCM, ChaCha20-Poly1305); deprecated CBC.
- **Cert chain** — root, intermediate, leaf; SCT (CT logs).
- **SNI**, **ESNI/ECH** (Encrypted ClientHello).
- **ACME (RFC 8555)** — challenges: HTTP-01, DNS-01, TLS-ALPN-01.
- **mTLS**, **SPIFFE/SPIRE** workload identity.

## Auth & identity
- **OAuth 2.0 / 2.1** — Authorization Code + PKCE, Client Credentials, Device Code.
- **OIDC** — id_token (JWT), discovery, scopes (openid/profile/email).
- **JWT** — JWS/JWE; pitfalls (alg=none, key confusion).
- **SAML 2.0**, **Kerberos**, **LDAP bind / SASL**.
- **WebAuthn / passkeys, FIDO2**.

## Mail
- **SMTP / submission (587) / SMTPS (465 implicit) / STARTTLS**.
- **IMAP, POP3, JMAP** — retrieval.
- **SPF (RFC 7208), DKIM (6376), DMARC (7489), ARC, BIMI, MTA-STS, TLS-RPT**.

## File / sharing
- **FTP / FTPS / SFTP / SCP**, **WebDAV / CalDAV / CardDAV**.
- **NFS v3 / v4**, **SMB1/2/3**, **AFP** (legacy), **rsync**.

## Real-time / media
- **RTP / RTCP**, **SIP**, **RTSP**.
- **WebRTC** — ICE, DTLS-SRTP, SCTP-over-DTLS data channels.
- **HLS / MPEG-DASH** — streaming over HTTP.

## IoT / messaging
- **MQTT (5.0)**, **CoAP**, **AMQP 0.9.1 / 1.0**, **NATS**, **Kafka protocol**.

## Management & time
- **SNMP v2c/v3**, **NETCONF / YANG**, **gNMI / gNOI**.
- **syslog (RFC 5424)**, **journald native** export.
- **NTP v4**, **PTPv2 (IEEE 1588)** — high-precision time.

## Security cross-link
- HTTP smuggling, request splitting, JWT bugs, OAuth pitfalls → [14_Security/topics](../../../14_Security/topics/INDEX.md)
- TLS misconfigurations, BEAST/POODLE/etc. → [14_Security/topics](../../../14_Security/topics/INDEX.md)
