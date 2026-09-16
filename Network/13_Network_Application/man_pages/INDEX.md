# Network Application — Manual Pages

## What is in this section

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

## Dedicated man page references

| Topic | File |
|-------|------|
| Application protocol tools | [app_protocol_tools.md](app_protocol_tools.md) — curl, openssl s_client, dig, mosquitto |

---

## HTTP
| Command | Purpose |
|---------|---------|
| `curl` | All-purpose HTTP(S) client |
| `wget` | File-download focused |
| `httpie` (`http`) | Friendly JSON-first client |
| `xh` | Rust HTTPie alternative |
| `nghttp` / `h2load` | HTTP/2 client + load tester |
| `caddy`, `nginx`, `apache2ctl` | Web servers |

## TLS / certificates
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

## DNS
| Command | Purpose |
|---------|---------|
| `dig +trace example.com` | Authoritative trace |
| `dig @1.1.1.1 a example.com` | Specific resolver |
| `drill` | LDNS alternative to dig |
| `host`, `nslookup` | Simpler lookups |
| `kdig` | Knot's modern dig |
| `dnscrypt-proxy`, `cloudflared proxy-dns` | DoH/DoT clients |

## SSH / SCP / SFTP
| Command | Purpose |
|---------|---------|
| `ssh`, `scp`, `sftp`, `rsync -e ssh` | Core SSH suite |
| `ssh-keygen`, `ssh-add`, `ssh-agent` | Keys & agent |
| `ssh -L`, `-R`, `-D`, `-J` | Forwards & jumps |
| `mosh` | Mobile shell over UDP |

## Mail / messaging
| Command | Purpose |
|---------|---------|
| `swaks` | SMTP testing |
| `mailx`, `mutt`, `neomutt` | CLI mail clients |
| `mosquitto_pub` / `_sub` | MQTT |
| `kcat` (kafkacat) | Kafka CLI |
| `amqp-tools` | AMQP CLI |

## Misc app-layer
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

## Reverse engineering / inspection
- `mitmproxy`, `proxify`, `wireshark`, `tshark`, `burp` (commercial)
