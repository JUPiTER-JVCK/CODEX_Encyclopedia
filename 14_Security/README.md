# 14 — Security (Cross-cutting)

> Security is not a layer above the stack — it lives at every layer. This
> folder organizes offensive, defensive, and assurance material with explicit
> pointers back to the layer where the issue originates.

## Across the stack

```text
this layer cuts across the stack rather than sitting in one place

  13  Network Application  ─┐
  11  Network Internet     ─┤
  08  User Applications    ─┤      ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  07  Runtime Environment  ─┼──────┃  14  Security                         ◀── here   ┃
  05  OS Kernel            ─┤      ┃      breaking and defending every other layer    ┃
  04  Device Drivers       ─┤      ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  01  Circuit Board        ─┘

one adversary chains a kernel bug (05) to a phishing mail (13)
```

## At a glance

| Field | Value |
|-------|-------|
| Spans | Layers 01 through 13 and 15/16 |
| Description | Securing, breaking, and verifying every other layer |
| Languages | Polyglot — Python, C/C++, Rust, Go, Bash, PowerShell, Assembly |
| Subdomains | OSINT, AppSec, NetSec, EndpointSec, CloudSec, IR/Forensics, Crypto, Privacy, GRC |
| Example | Adversary chains a kernel CVE (L5) with a phishing email (L13) |

## Major subdomains

- **OSINT** — open-source intelligence gathering
- **Reconnaissance & enumeration** — DNS, BGP, ports, services, web fingerprinting
- **Network security** — IDS/IPS, firewalls, VPNs, segmentation
- **Endpoint / host** — EDR, hardening, allowlisting, exploit mitigations
- **AppSec** — SAST, DAST, IAST, SCA; OWASP Top 10; SSDLC
- **Cloud security** — IAM, posture management (CSPM), workload (CWPP), SaaS (SSPM)
- **Identity & access** — IAM, SSO, MFA, zero trust
- **Cryptography** — primitives, protocols, PKI, key management
- **Reverse engineering & malware** — static + dynamic, sandboxing
- **Offensive (red team) / pentest / adversary emulation**
- **Defensive / blue team / SOC / detection engineering**
- **Incident response & forensics** — DFIR, memory & disk forensics
- **Threat intelligence** — TTPs, IOCs, ATT&CK mapping
- **Privacy** — data protection, anonymization, differential privacy
- **GRC** — governance, risk, compliance (frameworks below)

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | books, courses, certifications, frameworks |
| [Lessons](#lessons) | [Interactive labs](security_labs.md) | CTF tracks, lab environments, study paths |
| [Languages](#languages) | — | typical security tooling languages |
| [Manual Pages](#manual-pages) | [Security Tools Reference](security_tools.md) | `nmap`, `metasploit`, `bettercap`, `volatility` |
| [Topics](#topics) | — | attack & defense per layer, mapped by source layer |
| [Protocols](#protocols) | [IPsec](tls_ipsec.md) | security-specific protocols & specs |

## Cross-references
- Hardware attacks → [01_Circuit_Board](../01_Circuit_Board/), [02_CPU](../02_CPU/)
- Firmware / boot security → [03_Firmware_BIOS](../03_Firmware_BIOS/)
- Driver / kernel exploit surface → [04_Device_Drivers](../04_Device_Drivers/), [05_OS_Kernel](../05_OS_Kernel/)
- Memory safety / lib hijack → [06_System_Libraries](../06_System_Libraries/)
- Container escapes, wasm sandbox → [07_Runtime_Environment](../07_Runtime_Environment/)
- App vulns (web, mobile, desktop) → [08_User_Applications](../08_User_Applications/)
- L2–L7 network attacks → [09–13](../10_Network_DataLink/)
- AI/ML threat surface → [15_AI_ML](../15_AI_ML/)
- RF / wireless attacks → [16_RF_Wireless](../16_RF_Wireless/)

---

## References

### What is in this section

```text
  Frameworks, books, and online platforms for security study and work.

  ┌─── frameworks & standards ────────────────────────────────────────────┐
  │  MITRE ATT&CK · D3FEND · NIST CSF/800-53/ZT · CIS Controls          │
  │  ISO 27001/27002 · OWASP Top 10/ASVS · PCI DSS · SLSA               │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── books ─────────────────────────────────────────────────────────────┐
  │  Web App Hacker's Handbook · Practical Malware Analysis               │
  │  Art of Memory Forensics · Shellcoder's Handbook                      │
  │  Cryptography Engineering · Real-World Cryptography                   │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── online platforms ──────────────────────────────────────────────────┐
  │  HackTheBox · TryHackMe · Portswigger Academy · PentesterLab         │
  │  Pwn.college · SANS courses · bug bounty programs                    │
  └───────────────────────────────────────────────────────────────────────┘
```

### Frameworks & standards
- **MITRE ATT&CK** — adversary TTP knowledge base; ATT&CK Navigator
- **MITRE D3FEND** — defensive countermeasures
- **NIST CSF 2.0** — Cybersecurity Framework
- **NIST SP 800-53 / 800-171 / 800-207 (Zero Trust)**
- **CIS Controls v8**, **CIS Benchmarks**
- **ISO/IEC 27001 / 27002 / 27005**
- **OWASP Top 10 (Web, API, Mobile, LLM)**, **OWASP ASVS, MASVS, SAMM**
- **PCI DSS v4**, **HIPAA Security Rule**, **GDPR**, **SOC 2**
- **SLSA**, **SSDF (NIST 800-218)** — supply chain security
- **STRIDE / DREAD / PASTA / LINDDUN** — threat modeling methodologies

### Books — broad
- *The Web Application Hacker's Handbook* — Stuttard, Pinto
- *Practical Malware Analysis* — Sikorski, Honig
- *The Art of Memory Forensics* — Ligh et al.
- *Red Team Field Manual / Blue Team Field Manual*
- *Hacking: The Art of Exploitation* — Erickson
- *The Shellcoder's Handbook*
- *Cryptography Engineering* — Ferguson, Schneier, Kohno
- *Real-World Cryptography* — David Wong
- *Serious Cryptography* — JP Aumasson
- *Threat Modeling: Designing for Security* — Adam Shostack

### Books — specialized
- *Network Security Assessment* — Chris McNab
- *Practical Reverse Engineering* — Dang, Gazet, Bachaalany
- *Practical Binary Analysis* — Andriesse
- *The Tangled Web* — Michal Zalewski (web security classics)
- *Browser Hacker's Handbook*
- *iOS Hacker's Handbook*, *Android Hacker's Handbook*
- *macOS and iOS Internals Vol. 3: Security*

### Certifications (study paths)
- **Offensive**: OSCP/OSEP/OSED/OSEE (OffSec), CRTO/CRTL (Zero-Point), GPEN/GXPN
- **Defensive**: GCIH, GCFA, GREM, GSEC, BTL1/BTL2
- **Cloud**: CCSP, AWS Sec Specialty, Azure SC-100, GCP PCSE
- **Governance**: CISSP, CISM, CISA

### Online
- HackTricks (`book.hacktricks.xyz`), PayloadsAllTheThings, exploit-db, GTFOBins, LOLBAS
- HackerOne / Bugcrowd disclosed reports
- Project Zero blog, Google TAG, Microsoft MSRC, Cisco Talos
- Krebs on Security, Risky.Biz, Securosis blog
- The DFIR Report (intrusion case studies)

---

## Lessons

### What is in this section

```text
  Lesson ladder: foundations, then offensive and defensive tracks.

  ┌─── dedicated module ──────────────────────────────────────────────────┐
  │  security_labs.md (Nmap scanning · hashcat · seccomp sandbox)         │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── foundations (1–5) ─────────────────────────────────────────────────┐
  │  threat model · Linux hardening · Windows hardening · crypto · PKI   │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── offensive (6–13) ──────────────────────────────────────────────────┐
  │  recon · web labs · Active Directory · Linux/Windows privesc          │
  │  Wi-Fi attacks · cloud attack paths · container escapes               │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── defensive (14–20) ─────────────────────────────────────────────────┐
  │  detection engineering · SIEM · EDR · network IDS · malware analysis │
  │  supply-chain security · red/blue team capstone                       │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated Lesson Modules

| File | Covers |
|------|--------|
| [Security — Interactive Labs](security_labs.md) | Nmap scanning, hashcat, seccomp sandbox |

### Foundations
1. **Threat modeling** — STRIDE on a real app you know; produce data-flow diagram.
2. **Linux hardening** — CIS benchmark on a fresh VM; document each control.
3. **Windows hardening** — STIG baseline + LAPS + AppLocker/WDAC.
4. **Crypto primitives** — implement AES-GCM, ECDH, Ed25519 from libsodium; *never* roll your own.
5. **PKI lab** — private CA with step-ca; issue server + client certs; mTLS.

### Offensive tracks
6. **Network recon** — `nmap`, `masscan`, `rustscan`; banner grabbing.
7. **Web** — Portswigger Academy free labs end-to-end (top 100).
8. **Active Directory** — BloodHound, Rubeus, certipy in a lab forest.
9. **Linux privesc** — LinPEAS, sudo abuse, capabilities, SUID, GTFOBins.
10. **Windows privesc** — WinPEAS, token theft, UAC bypass categories.
11. **Wi-Fi attacks** — see [RF / Wireless › Lessons](../16_RF_Wireless/README.md#lessons).
12. **Cloud attack paths** — AWS PMapper / Pacu, Azure AzureHound, GCP attack maps.
13. **Container escapes** — known patterns: runc CVE replays, capability misuse.

### Defensive tracks
14. **Detection engineering** — write Sigma rules; convert to splunk/elastic; mapped to ATT&CK.
15. **SIEM tour** — Elastic SIEM or Wazuh; ingest Sysmon + auditd; correlate logins.
16. **EDR investigation** — Velociraptor or Wazuh; run hunt for credential dumping artifacts.
17. **Network IDS** — Suricata + ET Open; alert on a deliberate test.
18. **Memory forensics** — Volatility 3 on a vmem snapshot of a compromised VM.
19. **Disk forensics** — Autopsy / Sleuth Kit on a sample DD image.
20. **Incident response runbook** — write your own ransomware IR plan.

### Continuous practice
- **CTFs** — picoCTF (beginner), HTB / THM (intermediate), pwn.college / Nightmare (binary), TryHackMe SOC paths
- **Bug bounty** — start on a single program scope; read past reports first
- **Capture cool malware safely** — MalwareBazaar in an isolated analysis VM

### Suggested external
- SANS reading room
- Red Team Village & Adversary Village (DEF CON)
- Antisyphon training (free + paid)

---

## Languages

### What is in this section

```text
  Languages split by role in security work.

  ┌─── offensive / tooling ───────────────────────────────────────────────┐
  │  Python · Bash · PowerShell · C/C++ · Rust · Go · Assembly           │
  │  JavaScript/TypeScript · Ruby · Lua (NSE scripts)                     │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── detection / data analysis ─────────────────────────────────────────┐
  │  YARA · Sigma · KQL (Sentinel) · SPL (Splunk) · EQL/EsQL (Elastic)  │
  │  Suricata/Snort rules · Falco rules · osquery SQL · OSSEC rules       │
  └───────────────────────────────────────────────────────────────────────┘
```

Security work is polyglot — choose by tool / domain.

### Tooling languages (most common)
| Language | Use |
|----------|-----|
| Python | Recon, automation, exploit PoCs, frameworks (impacket, scapy, mitmproxy, sqlmap) |
| Bash | Glue, recon pipelines, `*sh*` enumeration scripts |
| PowerShell | Windows offense (PowerSploit, Empire), defense (logging, hardening) |
| C / C++ | Native exploit dev, shellcode, drivers, low-level tools |
| Rust | Modern offensive tools (Rustcrack-likes), safer fuzzers, agents |
| Go | Implants, recon (subfinder, naabu, nuclei), portable binaries |
| Assembly (x86/ARM) | Shellcode, exploit primitives, reverse engineering |
| JavaScript / TypeScript | Web exploit dev, BeEF, Electron analysis |
| Ruby | Metasploit modules, legacy tools |
| Lua | Nmap NSE scripts |

### Detection / data
| Language | Use |
|----------|-----|
| YARA | Pattern signatures for files & memory |
| Sigma | Vendor-agnostic SIEM detection rules |
| KQL (Kusto) | Microsoft Sentinel / Defender hunting |
| SPL (Splunk) | Splunk searches |
| EQL / EsQL (Elastic) | Elastic detection |
| Suricata / Snort rules | Network IDS |
| Falco rules | Runtime container detection |
| osquery SQL | Endpoint querying |
| OSSEC / Wazuh rules | HIDS |
| Open Policy Agent (Rego) | Policy as code |

### Crypto / formal
| Language | Use |
|----------|-----|
| Sage / Python with sympy | CTF crypto math |
| Z3 (Python/SMT-LIB) | Constraint solving for exploitation/RE |
| Coq / Lean / F* | Verified crypto / OS code |

### Reverse engineering platforms
| Platform | Scripting |
|----------|-----------|
| Ghidra | Java / Python (Jython), PyGhidra |
| IDA Pro | IDC, IDAPython |
| Binary Ninja | Python (BNIL plugins) |
| radare2 / rizin | r2pipe (any language) |
| angr | Python symbolic execution |
| Frida | JS instrumentation glue |

---

## Manual Pages

### What is in this section

```text
  Security tooling, grouped by task category.

  ┌─── dedicated subfile ─────────────────────────────────────────────────┐
  │  security_tools.md (nmap · nikto · gobuster · hashcat · aircrack-ng) │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── recon & enumeration ───────────────────────────────────────────────┐
  │  nmap · masscan · rustscan · subfinder · amass · nuclei · shodan     │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── exploitation & web ────────────────────────────────────────────────┐
  │  sqlmap · burp suite · nikto · gobuster · ffuf · msfconsole          │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── passwords, crypto & forensics ─────────────────────────────────────┐
  │  hashcat · john · hydra · volatility · binwalk · strings · gdb       │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated man page references

| Topic | File |
|-------|------|
| Security tools | [Security Tools Reference](security_tools.md) — nmap, nikto, gobuster, hashcat, john, aircrack-ng |

---

### Recon & enumeration
| Tool | Purpose |
|------|---------|
| `nmap` | Port + service + OS + script scans (NSE) |
| `masscan` | High-rate port scanner |
| `rustscan` | Fast wrapper around nmap |
| `naabu` | Go port scanner (ProjectDiscovery) |
| `subfinder`, `amass`, `assetfinder` | Subdomain enumeration |
| `dnsx`, `dnsrecon`, `puredns` | DNS recon |
| `httpx`, `httprobe`, `katana` | HTTP probing/crawling |
| `nuclei` | Templated vulnerability scanner |
| `theHarvester` | OSINT email/host gathering |
| `recon-ng` | OSINT framework |
| `shodan`, `censys` | Internet-wide search engines |
| `whois`, `dig`, `traceroute` | Classics |

### Web testing
| Tool | Purpose |
|------|---------|
| `burpsuite` (Community/Pro) | Intercepting proxy + scanner |
| `mitmproxy` / `mitmweb` | Scriptable proxy |
| `ffuf`, `wfuzz`, `feroxbuster`, `gobuster` | Content discovery / fuzzing |
| `sqlmap` | Automated SQLi |
| `wpscan`, `joomscan` | CMS-specific scanners |
| `nikto` | Legacy but useful |

### Exploitation / post-ex
| Tool | Purpose |
|------|---------|
| `msfconsole` (Metasploit) | Exploit + payload framework |
| `responder` | LLMNR/NBT-NS/MDNS poisoning |
| `impacket-*` | Windows network protocol toolkit |
| `crackmapexec` / `nxc` (NetExec) | SMB/AD swiss army knife |
| `bloodhound-python`, `SharpHound` | AD graph collection |
| `mimikatz` | Windows credential extraction (legacy but ubiquitous) |
| `chisel`, `ligolo-ng` | Pivoting / tunneling |
| `evil-winrm` | Windows remote shell |

### Network L2/L3 (cross-link to [10–11])
- `bettercap`, `ettercap`, `arpspoof`, `tcpdump`, `wireshark`, `tshark`

### Wi-Fi (cross-link to [16](../16_RF_Wireless/))
- `aircrack-ng` suite, `kismet`, `hcxdumptool`, `wifite`

### Password cracking
| Tool | Purpose |
|------|---------|
| `hashcat` | GPU-accelerated cracking |
| `john` (JtR) | CPU/GPU cracker |
| `hydra`, `medusa`, `patator` | Online brute force |

### Forensics / IR
| Tool | Purpose |
|------|---------|
| `vol3` (Volatility 3) | Memory forensics |
| `autopsy`, `tsk` (Sleuth Kit) | Disk forensics |
| `plaso` / `log2timeline` | Timelining |
| `velociraptor` | Endpoint hunt + collection |
| `chainsaw`, `hayabusa` | Windows event log triage |
| `kape` | Triage collection (Windows) |
| `volatility` plugins, `rekall` (archival) | Memory forensics |

### Malware analysis / RE
| Tool | Purpose |
|------|---------|
| `ghidra`, `cutter` (rizin), `radare2`, `r2`, `binaryninja`, `ida` | Disassembly & decompilation |
| `pestudio`, `die` (Detect It Easy) | PE triage |
| `floss` | Obfuscated string extraction |
| `cape-sandbox`, `cuckoo`, `triage` | Dynamic sandboxes |
| `frida`, `objection` | Dynamic instrumentation |
| `yara`, `yarac` | Pattern matching |

### Cloud
| Tool | Purpose |
|------|---------|
| `prowler`, `scoutsuite`, `cloudsploit` | CSPM auditing |
| `pacu` | AWS exploitation framework |
| `azurehound`, `roadtools` | Azure AD recon |
| `gcphound`, `g-scout` | GCP recon |
| `kubectl`, `kube-bench`, `kube-hunter`, `peirates` | K8s |

### Container / runtime
| Tool | Purpose |
|------|---------|
| `trivy`, `grype`, `snyk` | Image vuln scanning |
| `dive` | Layer inspection |
| `falco` | Runtime detection |
| `tetragon` | eBPF-based runtime security |

### Crypto / TLS
| Tool | Purpose |
|------|---------|
| `openssl` | Swiss army knife |
| `testssl.sh` | Server TLS audit |
| `sslyze` | Same, Python |
| `nmap --script ssl-*` | NSE TLS probes |
| `hashid` / `hash-identifier` | Hash type guessing |

---

## Topics

### What is in this section

```text
  Attack surface organised by the stack layer a technique targets.

  ┌─── hardware & CPU (layers 00–02) ────────────────────────────────────┐
  │  glitching · side channels · JTAG abuse · Rowhammer                 │
  │  Spectre/Meltdown/MDS · SGX/SEV attacks · pointer auth/CET           │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── firmware, drivers & OS (layers 03–05) ────────────────────────────┐
  │  bootkits (LoJax · BlackLotus) · UEFI implants · BYOVD              │
  │  kernel exploits · container escapes · privilege escalation           │
  └──────────────────────────────────────────────────────────────────────┘

  ┌─── network & application (layers 09–13) ─────────────────────────────┐
  │  MITM · TLS attacks · DNS hijacking · OWASP Top 10 web vulns         │
  │  OAuth/JWT abuse · supply chain · cloud misconfigs · AI/LLM risks   │
  └──────────────────────────────────────────────────────────────────────┘
```

Organised by the layer each topic attacks, so an entry sits beside the layer
that owns it in the rest of the codex.

### Layer 01 — Circuit Board / hardware
- **Glitching / fault injection** — voltage, clock, EM, laser
- **Side channels** — power (SPA/DPA), EM, timing, acoustic
- **JTAG/SWD debug abuse**, chip-off, NAND mirroring
- **Implants / supply-chain hardware**, **counterfeit components**
- **Rowhammer** (DRAM-level bit flips)

### Layer 02 — CPU
- **Speculative execution** — Spectre v1/v2/v4, Meltdown, MDS (RIDL/Fallout/ZombieLoad), L1TF, Retbleed, Downfall, Inception
- **TLB / cache side channels** — Flush+Reload, Prime+Probe
- **SGX/SEV/TDX attacks** — Foreshadow, SQUIP, etc.
- **Pointer auth / CET / shadow stacks** — defenses

### Layer 03 — Firmware / BIOS
- **Bootkits** — LoJax, MosaicRegressor, BlackLotus
- **Evil maid attacks** — pre-boot tampering
- **BMC vulnerabilities** — IPMI cleartext creds, Redfish bugs
- **UEFI implant frameworks** — LoJax-class
- **SMM attacks**, **Boot Guard / Verified Boot bypass**

### Layer 04 — Device Drivers
- **BYOVD** (Bring Your Own Vulnerable Driver)
- **Driver signing bypass** — leaked certs
- **MSI/MMIO escalation primitives**

### Layer 05 — OS Kernel
- **LPE classes** — UAF, type confusion, integer overflows in syscalls
- **Container escapes** — runc CVEs, capability misuse, /proc/self/exe tricks
- **eBPF abuse** — verifier bugs, rootkits, evasion
- **Rootkits** — LKM, kprobes, ftrace, eBPF-based
- **LSM bypass** — SELinux/AppArmor escapes
- **Kernel info leaks** — KASLR break primitives

### Layer 06 — System Libraries
- **Memory corruption** — heap (UAF, double-free, heap spray), stack overflow, integer overflow
- **Format string bugs**, **printf** primitives
- **Exploit mitigations** — ASLR, NX/DEP, SafeSEH, CFG, CET, Stack Canaries, FORTIFY_SOURCE
- **LD_PRELOAD / DLL hijacking / dyld injection**
- **Crypto library misuse** — IV reuse, weak randomness, padding oracles

### Layer 07 — Runtime Environment
- **JVM / .NET deserialization** — gadget chains
- **Python pickle / yaml.load / eval injection**
- **Node prototype pollution**, **vm escape**
- **Container escapes (already listed)**, **Wasm sandbox bypass**
- **CI/CD compromise** — GitHub Actions injection, runner poisoning
- **Supply chain** — typosquatting, dependency confusion, malicious packages

### Layer 08 — User Applications
- **App sandbox escapes** — App Sandbox, AppContainer, Android scoped storage
- **URL scheme abuse, deep-link hijacking**
- **Browser exploitation** — type confusion in JS engines, sandbox + GPU compromise
- **Code-signing bypass** — Authenticode, notarization, Mach-O LC_CODE_SIGNATURE
- **Mobile** — IPC abuse, intent redirection, deep links, accessibility abuse

### Layer 09 — Network Physical
- **Cable taps**, **fiber tap optical bend couplers**
- **Wireless eavesdropping & jamming** (cross-link [16](../16_RF_Wireless/))

### Layer 10 — Data Link
- **ARP spoofing / poisoning** → MitM
- **MAC flooding** (CAM table exhaustion)
- **VLAN hopping** — double tagging, switch spoofing
- **DHCP starvation + rogue DHCP**, **DHCPv6 RA flood**
- **STP attacks** — root bridge takeover
- **802.1X bypass** — MAB tricks, hub-style
- **Wi-Fi** — deauth, KRACK, PMKID, evil twin (see [16](../16_RF_Wireless/))

### Layer 11 — Internet
- **BGP hijacks / route leaks** — RPKI/ROA as mitigation
- **DDoS** — SYN flood, UDP amplification (DNS/NTP/Memcached), reflection
- **IPsec / VPN flaws** — IKE downgrade, weak DH groups
- **Tunneling abuse** — DNS tunneling, ICMP exfil, IPv6 over IPv4 to bypass policy

### Layer 12 — Transport
- **TCP RST injection, sequence prediction** (mostly historical)
- **SYN flood**, **slowloris/slowread** (app-layer DoS)
- **Off-path attacks** — side-channel TCP injection (RFC 5961 mitigation)
- **QUIC** — early TLS bugs in implementations

### Layer 13 — Application
- **Web** — OWASP Top 10: injection, broken authn, XSS, CSRF, SSRF, IDOR, deserialization, RCE
- **HTTP smuggling / desync**, **request splitting**
- **JWT pitfalls** — alg=none, key confusion, weak HS256 secret
- **OAuth flaws** — open redirect, mix-up, CSRF on flows, PKCE skip
- **TLS attacks** — POODLE, BEAST, FREAK, LOGJAM, ROBOT, downgrade
- **DNS attacks** — cache poisoning (Kaminsky), spoofing, NXNS, sub-domain takeover
- **Email** — phishing, BEC, spoof via missing SPF/DKIM/DMARC; spoofable display names
- **SSH** — weak keys, port forwarding abuse, leaked authorized_keys
- **SMB / RDP** — relay (NTLM relay), BlueKeep-class
- **AD** — Kerberoasting, AS-REP roasting, DCSync, Golden/Silver/Diamond/Sapphire tickets, ADCS ESCs

### Cross-cutting topics
- **Threat modeling** — STRIDE, PASTA, LINDDUN (privacy)
- **Zero Trust** — NIST 800-207, BeyondCorp
- **Detection engineering** — Pyramid of Pain, ATT&CK mapping, Sigma → SIEM
- **Incident response** — PICERL, MITRE D3FEND, tabletop exercises
- **Threat intelligence** — IOCs vs TTPs, STIX/TAXII

### Identity / IAM
- **MFA fatigue**, **adversary-in-the-middle (AiTM)** phishing kits
- **Passkey / FIDO2 phishing-resistance**
- **OAuth/OIDC misconfig**, **token theft via XSS, cookie scoping**

### Cloud-specific
- **IAM privilege escalation paths** (AWS PMapper, AzureHound)
- **Public S3 buckets / open storage**, **SSRF → IMDS** (v1 vs IMDSv2)
- **Lambda / Functions abuse**, **CI/CD trust boundary**
- **K8s RBAC misuse**, **service-account token theft**, **CRD injection**

### Cryptography (deeper)
- **Primitives** — AES, ChaCha20, SHA-2/3, HMAC, HKDF; AEAD modes
- **Asymmetric** — RSA (OAEP/PSS), ECC (P-256/Curve25519), Ed25519, X25519
- **Key exchange** — ECDH(E), TLS 1.3 handshake
- **Post-quantum** — ML-KEM (Kyber), ML-DSA (Dilithium), SLH-DSA (SPHINCS+)
- **Pitfalls** — IV reuse, padding oracles (CBC/MAC-then-encrypt), key reuse across modes

### Privacy
- **Anonymization & re-identification**
- **Differential privacy** (cross-link [15_AI_ML](../15_AI_ML/))
- **Tor**, **mixnets**, **VPNs vs proxies vs onion routing**
- **Tracking** — cookies, fingerprinting, supercookies, ETag tracking

### GRC
- **NIST 800-53** control families
- **ISO 27001** clauses & Annex A
- **PCI DSS v4**, **SOC 2** Trust Services Criteria
- **GDPR / CCPA / HIPAA** — privacy regs basics
- **DPIA**, **PIA**, **DPA**

---

## Protocols

### What is in this section

```text
  Security-specific protocols and data formats, by category.

  ┌─── dedicated subfile ─────────────────────────────────────────────────┐
  │  tls_ipsec.md (IPsec ESP/AH/IKEv2 · modes · vs WireGuard)            │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── auth / identity ───────────────────────────────────────────────────┐
  │  OAuth 2.0 · OIDC · SAML 2.0 · Kerberos · WebAuthn/FIDO2            │
  │  TOTP/HOTP · SCIM 2.0 · SPIFFE/SPIRE workload identity               │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── crypto transport ──────────────────────────────────────────────────┐
  │  TLS 1.3 · DTLS · IPsec ESP/AH · WireGuard · SSH · QUIC (TLS 1.3)  │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── PKI, network & app-layer security ─────────────────────────────────┐
  │  ACME · Certificate Transparency · DNSSEC · DoH/DoT                  │
  │  HSTS · CSP · JWT/JOSE · PKCS#11 · FIDO CTAP2                        │
  └───────────────────────────────────────────────────────────────────────┘
```

Security-specific protocols & data formats. Protocols are listed here only when
their primary purpose is security; otherwise they live in their owning layer's
folder.

### Dedicated protocol references

| Protocol | File |
|----------|------|
| IPsec (ESP / AH / IKEv2) | [IPsec](tls_ipsec.md) — modes, ESP format, IKEv2 exchange, vs. WireGuard |

---

### Authentication / authorization
| Protocol | RFC / Spec | Purpose |
|----------|------------|---------|
| OAuth 2.0 / 2.1 | RFC 6749 + 9700 BCP | Delegated authorization |
| OIDC | OpenID Foundation | Identity on OAuth 2 |
| SAML 2.0 | OASIS | Enterprise SSO |
| Kerberos v5 | RFC 4120 | Ticket-based auth |
| WebAuthn / FIDO2 / CTAP2 | W3C / FIDO | Passkeys, hardware tokens |
| TOTP / HOTP | RFC 6238 / 4226 | One-time passwords |
| SCIM 2.0 | RFC 7644 | Identity provisioning |
| SPIFFE / SPIRE | CNCF | Workload identity (SVIDs) |

### Cryptographic transport
| Protocol | RFC / Spec |
|----------|------------|
| TLS 1.3 | 8446 |
| DTLS 1.3 | 9147 |
| IPsec (AH/ESP/IKEv2) | 4302/4303/7296 |
| WireGuard | (live spec) |
| SSH-2 | 4251–4254 |
| MACsec | IEEE 802.1AE |
| Noise Protocol Framework | noiseprotocol.org |

### PKI / certificates
| Spec | Purpose |
|------|---------|
| X.509 v3 | RFC 5280 |
| ACME | RFC 8555 |
| Certificate Transparency | RFC 9162 |
| OCSP | RFC 6960 |
| CAA | RFC 8659 |
| CRL | RFC 5280 |

### Sharing detections & intel
| Spec | Purpose |
|------|---------|
| STIX 2.1 | Structured Threat Information |
| TAXII 2.1 | TI exchange transport |
| MISP format | MISP-native sharing |
| CycloneDX, SPDX | SBOM formats |
| in-toto, SLSA provenance | Supply-chain attestations |
| Sigstore (cosign / Rekor / Fulcio) | Signing artifacts |
| OpenC2 | Command & control for response |

### Vulnerability & weakness
| Spec | Purpose |
|------|---------|
| CVE (MITRE / CVE.org) | Vulnerability IDs |
| CWE | Weakness taxonomy |
| CVSS v3.1 / v4.0 | Severity scoring |
| EPSS | Exploit Prediction Scoring System |
| CSAF / VEX | Coordinated advisory format |
| OVAL, OSV | Machine-readable vuln data |

### Logging & event formats
| Spec | Purpose |
|------|---------|
| syslog | RFC 5424 |
| CEF | ArcSight Common Event Format |
| LEEF | IBM QRadar |
| OCSF | Open Cybersecurity Schema Framework |
| ECS | Elastic Common Schema |
| Sysmon schema | Microsoft Sysmon events |

### Crypto primitives (informational refs)
- **NIST FIPS 197** — AES
- **NIST FIPS 180-4** — SHA-2; **FIPS 202** — SHA-3
- **NIST SP 800-38D** — GCM
- **NIST SP 800-56A/B/C** — key establishment
- **NIST SP 800-208** — stateful hash sigs (XMSS/LMS)
- **NIST FIPS 203/204/205** — ML-KEM, ML-DSA, SLH-DSA (PQC)
