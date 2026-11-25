# 08 — User Applications

> What humans actually use. Browsers, editors, IDEs, office suites, media
> players, games, DAWs, CAD, mobile apps. Where every layer below converges
> into something a person can click, tap, or type into.

## In the stack

```text
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  08  User Applications            ◀── here   ┃
┃      GUI · TUI · CLI — what a person touches ┃
┗━━━━━━━━━━━━━━━━━━━━━━━┯━━━━━━━━━━━━━━━━━━━━━━┛
                        │  runtime APIs (JNI, FFI, ABI)
┌───────────────────────┴──────────────────────┐
│  07  Runtime Environment                     │
└──────────────────────────────────────────────┘

also talks to 13 Network Application — every networked app crosses there
```

## At a glance

| Field | Value |
|-------|-------|
| Description | End-user software for specific tasks |
| Languages | C++, Java, Python, JS/TS, Swift, Kotlin, C#, Go, Rust, Dart |
| Medium / Interface | UI (GUI/TUI/CLI/voice), library & system calls |
| Example | Media player uses OS + drivers to output video/audio |
| Adjacent layers | ↓ [07_Runtime_Environment](../07_Runtime_Environment/), ↗ [13_Network_Application](../13_Network_Application/) |

## What lives here

- **Browsers** — Chromium, Firefox, Safari, Edge
- **IDEs / Editors** — VS Code, JetBrains, Vim/Neovim, Emacs, Xcode, Sublime
- **Productivity** — Office 365, Google Workspace, LibreOffice, Notion, Obsidian
- **Media** — VLC, mpv, OBS, Spotify, audio DAWs (Ableton, Logic, Reaper)
- **Creative** — Photoshop, Affinity, Blender, DaVinci Resolve, Figma
- **Dev tooling** — Docker Desktop, Postman, DBeaver, Wireshark, Burp Suite
- **Communication** — Slack, Discord, Teams, Zoom, mail clients
- **Mobile apps** — iOS/iPadOS apps (Swift/Obj-C), Android apps (Kotlin/Java)
- **Games & engines** — Unity, Unreal, Godot
- **Shell environments** — bash, zsh, fish, PowerShell, nushell, tmux

## In this layer

Everything for this layer is on this page or one click away.

| Section | Notes | What's there |
|---------|-------|--------------|
| [References](#references) | — | UI/UX, accessibility, platform HIGs |
| [Lessons](#lessons) | [Interactive labs](app_labs.md) | build a CLI, GUI, mobile, web app |
| [Languages](#languages) | [Bash / Shell](bash.md) · [C](c.md) · [C++](cpp.md) · [C#](csharp.md) · [Go](go.md) · [Java](java.md) · [JavaScript](javascript.md) · [Kotlin](kotlin.md) · [Lua](lua.md) · [Python](python.md) · [Ruby](ruby.md) · [Rust](rust.md) · [SQL](sql.md) · [Swift](swift.md) · [TypeScript](typescript.md) | app-tier languages + UI frameworks |
| [Manual Pages](#manual-pages) | [Network Tools](network_tools.md) · [Package Manager Commands](package_managers.md) · [Shell & Terminal Multiplexer Commands](shell_commands.md) · [Text Processing & File Search Commands](text_processing.md) | shells, package managers, common CLIs |
| [Topics](#topics) | — | GUI toolkits, IPC, packaging, accessibility |
| [Protocols](#protocols) | — | clipboard, drag-and-drop, MIME, URL schemes |

## Cross-references
- Where the network logic ends up → [13_Network_Application](../13_Network_Application/)
- Sandboxing & app permissions → [Security › Topics](../14_Security/README.md#topics)
- AI-assisted apps → [AI / ML › Topics](../15_AI_ML/README.md#topics)

---

## References

### What is in this section

```text
  Five reference groups: platform HIGs, UX books, accessibility, app dev books, online.

  ┌─── platform HIGs ─────────────────────────────────────────────────────┐
  │  Apple HIG  │  Material Design 3 (Google)  │  Microsoft Fluent UI     │
  │  GNOME HIG  │  KDE HIG                                                 │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── UX & design books ─────────────────────────────────────────────────┐
  │  Design of Everyday Things · Don't Make Me Think · About Face          │
  │  Refactoring UI · Designing Interfaces                                 │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── accessibility ─────────────────────────────────────────────────────┐
  │  WCAG 2.2  │  ARIA Authoring Practices  │  Inclusive Design Patterns  │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── app development books ─────────────────────────────────────────────┐
  │  Programming Windows · Cocoa Programming  │  iOS & Android Big Nerd    │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── online ────────────────────────────────────────────────────────────┐
  │  web.dev  │  MDN (developer.mozilla.org)  │  Stack Overflow Survey    │
  └───────────────────────────────────────────────────────────────────────┘
```

### Platform HIGs (Human Interface Guidelines)
- **Apple HIG** — `https://developer.apple.com/design/human-interface-guidelines/`
- **Material Design 3** (Google) — `https://m3.material.io/`
- **Microsoft Fluent UI** — `https://fluent2.microsoft.design/`
- **GNOME HIG**, **KDE HIG** — Linux desktop conventions

### UX & design
- *The Design of Everyday Things* — Don Norman
- *Don't Make Me Think* — Steve Krug
- *About Face* — Cooper, Reimann, Cronin
- *Refactoring UI* — Adam Wathan & Steve Schoger
- *Designing Interfaces* — Jenifer Tidwell

### Accessibility
- **WCAG 2.2** — Web Content Accessibility Guidelines (W3C)
- **ARIA Authoring Practices** — W3C
- **Apple Accessibility** & **Android Accessibility** docs
- *Inclusive Design Patterns* — Heydon Pickering

### App development books
- *Programming Windows* — Charles Petzold (classic)
- *Cocoa Programming for Mac OS X* — Aaron Hillegass
- *Android Programming: The Big Nerd Ranch Guide*
- *iOS Programming: The Big Nerd Ranch Guide*

### Online
- web.dev — modern web app patterns
- developer.mozilla.org (MDN) — web standards reference
- Stack Overflow Developer Survey — language/tool landscape

---

## Lessons

### What is in this section

```text
  One dedicated lab module plus eleven numbered lessons across all app types.

  ┌─── dedicated module ──────────────────────────────────────────────────┐
  │  app_labs.md: CLI build · TUI file picker · package & distribute       │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── numbered lessons ──────────────────────────────────────────────────┐
  │  1 CLI · 2 TUI · 3 Desktop GUI native · 4 Cross-platform GUI          │
  │  5 Web SPA · 6 PWA · 7 iOS · 8 Android · 9 Game prototype             │
  │  10 Packaging & signing · 11 Accessibility audit                       │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated lesson modules

| Topic | File |
|-------|------|
| Application interactive labs | [User Applications interactive labs](app_labs.md) — CLI tool build, TUI file picker, package & distribute |

---

1. **CLI app** — pick a language; build a `wc` clone with proper flags & exit codes.
2. **TUI app** — bubbletea (Go), Textual (Python), ratatui (Rust): a file picker.
3. **Desktop GUI native** — pick one: Win32, AppKit (Swift), GTK (C), Qt (C++).
4. **Cross-platform GUI** — Tauri (Rust+web), Electron (TS), Flutter (Dart), Avalonia (.NET).
5. **Web app SPA** — React/Vite or SvelteKit; routing, state, fetch, deploy.
6. **PWA** — service worker, manifest, install-to-home-screen.
7. **iOS app** — SwiftUI hello → CRUD list with Combine/async-await.
8. **Android app** — Kotlin + Jetpack Compose; same CRUD list.
9. **Game prototype** — Godot or Unity: pong/breakout in a weekend.
10. **Packaging** — `.app` (codesign + notarize), `.exe` (signtool), `.deb` / `.rpm`, AppImage / Flatpak / Snap, MSI / MSIX, App Store / Play Store flows.
11. **Accessibility audit** — run axe / Accessibility Inspector / TalkBack on the result.

### Suggested external
- Frontend Masters
- Hacking with Swift (Paul Hudson)
- Android Developer codelabs
- The Odin Project (free full-stack web)

---

## Languages

### What is in this section

```text
  Fifteen language profiles, grouped by paradigm.

  ┌─── systems & native ──────────────────────────────────────────────────┐
  │  C · C++ · Rust · Go  │  Swift (Apple)  │  Kotlin (Android / JVM)    │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── managed / cross-platform ──────────────────────────────────────────┐
  │  Java · C# (.NET)  │  Kotlin (JVM server)                              │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── web ───────────────────────────────────────────────────────────────┐
  │  JavaScript · TypeScript  │  Node.js · Deno · Bun runtimes            │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── dynamic / scripting ───────────────────────────────────────────────┐
  │  Python · Ruby · Lua · Bash  │  SQL (relational query language)        │
  └───────────────────────────────────────────────────────────────────────┘
```

The widest layer; everything compiles or transpiles down to lower layers eventually.

### Per-language profiles (man-page-style)

Deep references for the most-used languages — toolchain, stdlib map, idioms, gotchas.

| Language | Profile |
|----------|---------|
| Python | [Python](python.md) |
| Rust | [Rust](rust.md) |
| C | [C](c.md) |
| C++ | [C++](cpp.md) |
| Go | [Go](go.md) |
| JavaScript | [JavaScript](javascript.md) |
| TypeScript | [TypeScript](typescript.md) |
| Java | [Java](java.md) |
| Kotlin | [Kotlin](kotlin.md) |
| C# | [C#](csharp.md) |
| Swift | [Swift](swift.md) |
| Ruby | [Ruby](ruby.md) |
| Bash / shell | [Bash / Shell](bash.md) |
| SQL | [SQL](sql.md) |
| Lua | [Lua](lua.md) |

Embedded-specific dialects: see [Embedded Systems › Languages](../18_Embedded_Systems/README.md#languages) for `embedded_c.md`, `embedded_rust.md`, `embedded_python.md`.

Assembly per architecture: see [CPU › Languages](../02_CPU/README.md#languages) for `x86_64_asm.md`, `arm64_asm.md`, `riscv_asm.md`.

### By platform

#### Desktop native
| Platform | Primary | Notable alternatives |
|----------|---------|----------------------|
| Windows | C# / .NET (WPF, WinUI 3) | C++ (Win32, MFC, Qt), Rust (winit + egui) |
| macOS | Swift (AppKit / SwiftUI) | Objective-C (legacy), Qt, Rust |
| Linux | C/C++ (GTK, Qt) | Rust (gtk-rs, slint), Python (PyQt, GTK) |

#### Cross-platform desktop
| Toolkit | Language | Notes |
|---------|----------|-------|
| Electron | JS/TS | Chromium + Node; heavy |
| Tauri | Rust + web frontend | Lighter alt to Electron |
| Flutter Desktop | Dart | Single codebase mobile + desktop |
| Qt | C++ / Python (PyQt, PySide) | Mature, commercial license available |
| GTK | C / Rust / Python / Vala | GNOME stack |
| Avalonia | C# | XAML-style cross-platform |
| .NET MAUI | C# | Microsoft cross-platform |
| Slint | Rust / C++ / JS | Newer embedded-friendly UI |

#### Mobile
| Platform | Primary | Cross-platform |
|----------|---------|----------------|
| iOS / iPadOS | Swift + SwiftUI | Flutter (Dart), React Native (TS), MAUI (C#), Kotlin Multiplatform |
| Android | Kotlin + Jetpack Compose | same as above |
| visionOS | Swift + RealityKit | — |

#### Web (browser as runtime)
| Layer | Languages / frameworks |
|-------|------------------------|
| Markup / styling | HTML, CSS, Sass, Tailwind |
| Logic | JavaScript, TypeScript |
| Frameworks | React, Vue, Svelte, SolidJS, Angular, Astro, Qwik |
| Build / runtime | Vite, Webpack, esbuild, Turbopack, Rspack |

#### Server-side app code
- Python (Django, FastAPI, Flask)
- Node.js (Express, Fastify, NestJS)
- Ruby (Rails, Sinatra)
- Go (net/http, gin, echo)
- Rust (axum, actix-web)
- Java/Kotlin (Spring, Ktor)
- C# (ASP.NET Core)
- PHP (Laravel, Symfony)
- Elixir (Phoenix)

#### Shell / scripting
- bash, zsh, fish, PowerShell, nushell
- AppleScript, JXA (macOS automation)
- AutoHotkey (Windows automation)
- Python, Perl, Ruby (general scripting)

---

## Manual Pages

### What is in this section

```text
  Four dedicated subfiles plus inline command tables by category.

  ┌─── dedicated subfiles ────────────────────────────────────────────────┐
  │  shell_commands.md  │  text_processing.md  │  network_tools.md        │
  │  package_managers.md                                                   │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── inline command groups ─────────────────────────────────────────────┐
  │  Shells & terminals  │  Power-user tools  │  Package managers          │
  │  App build / package  │  App-level inspection  │  macOS · Windows      │
  └───────────────────────────────────────────────────────────────────────┘
```

### Dedicated man page references

| Topic | File |
|-------|------|
| Shells & multiplexers | [Shell & Terminal Multiplexer Commands](shell_commands.md) — bash, zsh, fish, tmux, screen |
| Text processing & search | [Text Processing & File Search Commands](text_processing.md) — find, fd, grep, rg, awk, sed, jq, xargs |
| Network tools | [Network Tools](network_tools.md) — curl, wget, httpie, rsync, scp, sftp, ssh |
| Package managers | [Package Manager Commands](package_managers.md) — apt, dnf, pacman, brew, nix |

---

### Shells & terminals
| Command | Purpose |
|---------|---------|
| `bash` / `zsh` / `fish` / `nu` | Interactive shells |
| `pwsh` / `powershell` | PowerShell |
| `tmux` / `screen` | Terminal multiplexers |
| `tput`, `infocmp`, `terminfo` | Terminal capabilities |
| `stty` | Terminal settings |

### Common power-user tools
| Command | Purpose |
|---------|---------|
| `find` / `fd` | File search |
| `grep` / `rg` (ripgrep) | Text search |
| `awk` / `sed` / `cut` / `tr` | Text manipulation |
| `jq` / `yq` | JSON / YAML query |
| `xargs`, `parallel` | Batch execution |
| `curl`, `wget`, `httpie` | HTTP clients |
| `rsync`, `scp`, `sftp` | File transfer |
| `ssh`, `mosh` | Remote shell |
| `tar`, `zip`, `7z`, `zstd` | Archives |
| `git` | Version control |

### Package managers
| Command | Platform |
|---------|----------|
| `apt` / `dnf` / `pacman` / `apk` / `zypper` | Linux distros |
| `brew` | macOS/Linux Homebrew |
| `winget` / `choco` / `scoop` | Windows |
| `nix` / `nix-env` / `nix-shell` | Nix |
| `flatpak` / `snap` / `appimage` | Linux app distribution |

### App build / package
| Command | Purpose |
|---------|---------|
| `xcodebuild`, `xcrun`, `codesign`, `notarytool` | Apple build & signing |
| `gradle`, `./gradlew`, `apksigner`, `bundletool` | Android |
| `msbuild`, `dotnet publish` | .NET |
| `electron-builder`, `tauri build` | Cross-platform desktop bundling |
| `appimagetool`, `flatpak-builder`, `snapcraft` | Linux bundles |

### App-level inspection
| Command | Purpose |
|---------|---------|
| `man` / `info` / `tldr` | Documentation |
| `which` / `command -v` / `type` | Command resolution |
| `printenv` / `env` | Environment variables |
| `lsof` | Open files & sockets |
| `pgrep` / `pkill` | Process lookup |

### macOS
- `open`, `open -a`, `defaults`, `pmset`, `softwareupdate`, `sudo softwareupdate --install-rosetta`

### Windows
- `wt` (Windows Terminal), `winget`, `pwsh`, `taskmgr`, `regedit`, `gpedit.msc`

---

## Topics

### What is in this section

```text
  Seven topic groups across UI, IPC, packaging, settings, accessibility, and lifecycle.

  ┌─── UI paradigms & toolkits ───────────────────────────────────────────┐
  │  CLI · TUI · GUI (retained / immediate-mode)  │  Voice / conversational │
  │  Native: Win32/WinUI · AppKit/SwiftUI · GTK · Qt                      │
  │  Web: DOM+CSS · React/Vue/Svelte  │  Game-engine UI  │  Dear ImGui    │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── IPC between apps ──────────────────────────────────────────────────┐
  │  D-Bus (Linux) · XPC (macOS) · COM/RPC (Windows)                      │
  │  Clipboard · Drag-and-drop · URL schemes · Universal/App Links         │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── packaging & distribution ──────────────────────────────────────────┐
  │  macOS: .app · codesign · notarize · App Store                        │
  │  Windows: MSI · MSIX · Authenticode  │  Linux: deb/rpm · Flatpak      │
  │  Mobile: .ipa / AAB · TestFlight · Play internal track                 │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── settings · state · accessibility ─────────────────────────────────┐
  │  defaults (macOS) · Registry (Win) · XDG ~/.config                    │
  │  VoiceOver · NVDA · JAWS · TalkBack  │  AX · ARIA · UI Automation     │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── cross-cutting platform features ───────────────────────────────────┐
  │  Notifications · background tasks · widgets / live activities         │
  │  Lifecycle: fg/bg · cold/warm start · state restoration               │
  └───────────────────────────────────────────────────────────────────────┘
```

### UI paradigms
- **CLI** — argv, exit codes, pipes, idempotent commands, structured output.
- **TUI** — terminal UI with input handling, escape sequences, mouse.
- **GUI** — event loops, retained vs immediate-mode UI, layout engines.
- **Voice / conversational** — assistants, chatbots, LLM-driven UIs.

### GUI toolkits
- **Native** — Win32/WinUI, AppKit/SwiftUI, GTK, Qt.
- **Web** — DOM + CSS layout, React/Vue/Svelte/Solid component models.
- **Game-engine UI** — Unity UI, Unreal UMG, Godot Control nodes.
- **Immediate-mode** — Dear ImGui, egui.

### IPC between apps
- **D-Bus** (Linux desktop), **XPC** (macOS), **COM / RPC** (Windows).
- **Pasteboard / clipboard** (per-OS APIs).
- **Drag-and-drop**, **share extensions**, **app intents** (iOS), **App Actions** (Android).
- **URL schemes / Universal Links / App Links / deep links**.

### Packaging & distribution
- **macOS** — `.app` bundles, code signing, notarization, App Store; PKG installers.
- **Windows** — MSI, MSIX, EXE installers; Authenticode signing; SmartScreen.
- **Linux** — `.deb` / `.rpm` / `.tar.xz`; Flatpak, Snap, AppImage; AUR.
- **Mobile** — App Store (`.ipa`), Play Store (AAB), TestFlight, internal distribution.

### Settings & state
- **Preferences APIs** — `defaults` (macOS), Registry (Windows), `~/.config` (XDG).
- **Sandbox containers** — App Sandbox (macOS), AppContainer (Windows), Android scoped storage.

### Accessibility
- **Screen readers** — VoiceOver, NVDA, JAWS, TalkBack.
- **Semantic accessibility trees** — UI Automation (Win), AX (macOS), ARIA (web).
- **Color contrast, focus, motion preferences, scaling.**

### Cross-cutting platform features
- **Notifications**, **background tasks**, **widgets / live activities**.
- **App lifecycle** — foreground/background, suspension, cold/warm start.
- **State restoration**.

### Security cross-link
- App sandboxing & entitlements → [Security › Topics](../14_Security/README.md#topics)
- Code-signing & supply-chain → [Security › Topics](../14_Security/README.md#topics)

---

## Protocols

### What is in this section

```text
  Four groups: inter-app conventions, data interchange formats, signing, identity.

  ┌─── inter-app & integration ───────────────────────────────────────────┐
  │  Clipboard formats  │  Drag-and-drop (UTI/MIME/CF_*)                  │
  │  MIME types (RFC 6838)  │  URL schemes · deep links  │  Web Share     │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── document & data interchange ───────────────────────────────────────┐
  │  PDF · OOXML (docx/xlsx) · ODF · EPUB · Markdown/CommonMark           │
  │  CSV (RFC 4180)  │  iCalendar (RFC 5545)  │  vCard (RFC 6350)         │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── app-bundle signing ────────────────────────────────────────────────┐
  │  Apple notarization/Gatekeeper  │  Authenticode (Windows)              │
  │  Android Signing Scheme v1–v4  │  Sigstore / cosign                   │
  └───────────────────────────────────────────────────────────────────────┘

  ┌─── app identity / auth ───────────────────────────────────────────────┐
  │  OAuth 2.0/2.1 · OIDC · PKCE  │  SAML 2.0                            │
  │  WebAuthn / FIDO2 (passkeys)  │  App Attest / Play Integrity           │
  └───────────────────────────────────────────────────────────────────────┘
```

Application-level conventions — clipboard, drag-and-drop, MIME and URL schemes
— rather than anything that travels on the wire.

### Inter-app & integration
| Protocol / spec | Purpose |
|----------------|---------|
| Clipboard formats | Per-OS: NSPasteboard types, Win32 CF_*, X11 selections |
| Drag-and-drop | UTI (Apple), MIME (web/X11), CF_* (Win) |
| MIME types | RFC 6838 + IANA registry |
| URL schemes | Custom + reserved (mailto:, tel:, sms:, app deep links) |
| OpenSearch | Browser search engine plugins |
| Web Share API | W3C cross-app share |

### Document & data interchange
| Format | Owner | Notes |
|--------|-------|-------|
| PDF (ISO 32000) | ISO | Portable Document Format |
| OOXML (ISO/IEC 29500) | Microsoft / ISO | docx, xlsx, pptx |
| ODF (ISO/IEC 26300) | OASIS | LibreOffice native |
| EPUB | W3C | Reflowable books |
| Markdown / CommonMark | community | Plain-text formatting |
| CSV (RFC 4180) | IETF | Tabular plain-text |
| iCalendar (RFC 5545) | IETF | Calendar events |
| vCard (RFC 6350) | IETF | Contacts |

### App-bundle / signing standards
- **Apple notarization & Gatekeeper**
- **Authenticode** (Windows)
- **Android Signing Scheme v1–v4**
- **Sigstore / cosign** for OCI artifacts and binaries

### App identity / auth (often used by apps)
- **OAuth 2.0 / 2.1**, **OIDC**, **PKCE** (RFC 7636), **SAML 2.0**
- **WebAuthn / FIDO2** — passkeys
- **App Attest / Play Integrity** — device attestation for app authenticity

### Cross-link
- The actual wire protocols apps speak → [Network Application › Protocols](../13_Network_Application/README.md#protocols)
- LLM/agent app integration → [AI / ML › Protocols](../15_AI_ML/README.md#protocols)
