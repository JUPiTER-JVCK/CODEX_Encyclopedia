import SwiftUI

// MARK: - Sidebar (translucent, grouped, modern)

struct SidebarView: View {
    /// Redraw on a palette or text-scale change — see `Preferences.revision`.
    @ObservedObject private var appearance = Preferences.shared
    @EnvironmentObject var state: AppState
    @State private var hoveredId: UUID? = nil

    var body: some View {
        VStack(spacing: 0) {
            sidebarHeader
            Divider().background(Theme.hairline).opacity(0.6)
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    if !state.bookmarks.pinned.isEmpty {
                        PinnedSection().padding(.top, 14)
                    }
                    ForEach(state.root.children) { band in
                        BandSection(band: band, hoveredId: $hoveredId)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
        .background(VisualEffectBlur(material: .sidebar, blendingMode: .behindWindow).ignoresSafeArea())
        .overlay(Rectangle().fill(Theme.hairline).frame(width: 1), alignment: .trailing)
    }

    /// The app mark, which doubles as the way back to Welcome.
    ///
    /// A real Button rather than an `onTapGesture` on the stack, so it is
    /// reachable by Tab and operable by Return like any other control.
    private var sidebarHeader: some View {
        Button(action: { state.showWelcome() }) {
            HStack(spacing: 10) {
                ZStack {
                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                        .fill(LinearGradient(colors: [Theme.blue, Theme.lavender],
                                             startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 26, height: 26)
                    Image(systemName: "c.square.fill")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Theme.crust)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Codex").font(Theme.FontStyle.headline).foregroundColor(Theme.text)
                    Text("Computing Stack v\(CodexInfo.version)")
                        .font(Theme.FontStyle.caption).foregroundColor(Theme.overlay1)
                }
                Spacer()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .help("Welcome (⌘⇧H)")
        .padding(.horizontal, 14).padding(.top, 12).padding(.bottom, 12)
    }
}

// MARK: - Band section (collapsible group)

private struct BandSection: View {
    /// Redraw on a palette or text-scale change — see `Preferences.revision`.
    @ObservedObject private var appearance = Preferences.shared
    let band: CodexNode
    @Binding var hoveredId: UUID?
    @State private var expanded: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button(action: { withAnimation(.easeInOut(duration: 0.16)) { expanded.toggle() } }) {
                HStack(spacing: 6) {
                    Image(systemName: expanded ? "chevron.down" : "chevron.right")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(Theme.overlay0)
                        .frame(width: 10)
                    Text(band.label.uppercased())
                        .font(.system(size: Theme.size(10), weight: .semibold))
                        .tracking(0.8)
                        .foregroundColor(Theme.overlay1)
                    Spacer()
                    Circle()
                        .fill(Theme.bandTint(band.label).opacity(0.85))
                        .frame(width: 6, height: 6)
                }
                .padding(.horizontal, 8).padding(.vertical, 3)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            if expanded {
                VStack(alignment: .leading, spacing: 1) {
                    ForEach(band.children) { layer in
                        LayerRow(node: layer, depth: 0, accent: Theme.bandTint(band.label), hoveredId: $hoveredId)
                    }
                }
            }
        }
    }
}

// MARK: - Recursive row

private struct LayerRow: View {
    /// Redraw on a palette or text-scale change — see `Preferences.revision`.
    @ObservedObject private var appearance = Preferences.shared
    let node: CodexNode
    let depth: Int
    let accent: Color
    @Binding var hoveredId: UUID?
    @State private var expanded: Bool = false
    @EnvironmentObject var state: AppState

    private var isSelected: Bool { node.isFile && node.url == state.selectedTab }
    private var isHovered: Bool { hoveredId == node.id }

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Button(action: tap) {
                HStack(spacing: 8) {
                    // Chevron / spacer
                    if !node.children.isEmpty {
                        Image(systemName: expanded ? "chevron.down" : "chevron.right")
                            .font(.system(size: 8, weight: .bold))
                            .foregroundColor(Theme.overlay0)
                            .frame(width: 10)
                    } else {
                        Spacer().frame(width: 10)
                    }
                    // Icon
                    Image(systemName: node.iconName)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(rowIconTint)
                        .frame(width: 14)
                    // Label
                    Text(node.label)
                        .font(rowFont)
                        .foregroundColor(rowColor)
                        .lineLimit(1).truncationMode(.middle)
                    Spacer(minLength: 0)
                    // Pin indicator
                    if let u = node.url, state.bookmarks.isPinned(u.path) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 8))
                            .foregroundColor(Theme.yellow)
                    }
                }
                .padding(.vertical, 4)
                .padding(.leading, CGFloat(depth) * 12 + 8)
                .padding(.trailing, 8)
                .background(rowBackground)
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .onHover { hovering in hoveredId = hovering ? node.id : (hoveredId == node.id ? nil : hoveredId) }
            .contextMenu { contextMenuItems }

            if expanded {
                ForEach(node.children) { child in
                    LayerRow(node: child, depth: depth + 1, accent: accent, hoveredId: $hoveredId)
                }
            }
        }
    }

    @ViewBuilder
    private var rowBackground: some View {
        if isSelected {
            RoundedRectangle(cornerRadius: 6, style: .continuous).fill(accent.opacity(0.22))
                .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(accent.opacity(0.45), lineWidth: 1))
        } else if isHovered {
            RoundedRectangle(cornerRadius: 6, style: .continuous).fill(Theme.surface0.opacity(0.55))
        } else {
            Color.clear
        }
    }

    private var rowFont: Font {
        if node.kind == .layer  { return .system(size: Theme.size(12.5), weight: .semibold) }
        if node.kind == .section { return .system(size: Theme.size(12), weight: .medium) }
        return .system(size: Theme.size(12))
    }
    private var rowColor: Color {
        if isSelected { return Theme.text }
        switch node.kind {
        case .layer:   return Theme.text
        case .section: return Theme.subtle
        case .file:    return Theme.subtext
        case .readme:  return Theme.text
        default:       return Theme.subtext
        }
    }
    private var rowIconTint: Color {
        if isSelected { return accent }
        return node.iconTint
    }

    private func tap() {
        if node.isFile, let u = node.url { state.openFile(u) }
        else { withAnimation(.easeInOut(duration: 0.16)) { expanded.toggle() } }
    }

    @ViewBuilder
    private var contextMenuItems: some View {
        if node.isFile, let url = node.url {
            Button("Open") { state.openFile(url) }
            Button("Open in New Tab") { state.openFile(url, forceNew: true) }
            Divider()
            Button(state.bookmarks.isPinned(url.path) ? "Unpin" : "Pin to Top") {
                state.togglePin(url)
            }
            Divider()
            Button("Reveal in Finder") { LinkResolver.revealInFinder(url) }
            Button("Copy Path") {
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(url.path, forType: .string)
            }
        } else if let url = node.url {
            Button("Reveal in Finder") { LinkResolver.revealInFinder(url) }
        }
    }
}

// MARK: - Pinned section

private struct PinnedSection: View {
    /// Redraw on a palette or text-scale change — see `Preferences.revision`.
    @ObservedObject private var appearance = Preferences.shared
    @EnvironmentObject var state: AppState

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 6) {
                Image(systemName: "star.fill")
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(Theme.yellow)
                    .frame(width: 10)
                Text("PINNED")
                    .font(.system(size: Theme.size(10), weight: .semibold))
                    .tracking(0.8)
                    .foregroundColor(Theme.overlay1)
                Spacer()
            }
            .padding(.horizontal, 8).padding(.vertical, 3)

            VStack(spacing: 1) {
                ForEach(state.bookmarks.pinned, id: \.self) { path in
                    let url = URL(fileURLWithPath: path)
                    PinnedRow(url: url)
                }
            }
        }
    }
}

private struct PinnedRow: View {
    /// Redraw on a palette or text-scale change — see `Preferences.revision`.
    @ObservedObject private var appearance = Preferences.shared
    let url: URL
    @EnvironmentObject var state: AppState
    @State private var hovered = false

    private var isSelected: Bool { url == state.selectedTab }

    /// Whether the pinned file is still on disk.
    ///
    /// Pins are persisted as absolute paths and never revalidated, so renaming
    /// or deleting a file leaves a row that beeps when clicked. Showing it as
    /// missing beats silently failing, and keeps the unpin button reachable so
    /// the stale pin can be cleared.
    private var exists: Bool { FileManager.default.fileExists(atPath: url.path) }

    var body: some View {
        // Two sibling Buttons, never nested.
        //
        // This was a Button (unpin) inside another Button's label (open),
        // which is unreliable on macOS — the inner may swallow the click, or
        // both may fire. The first fix replaced the outer Button with an
        // onTapGesture, which removed the nesting and the keyboard access at
        // the same time: a gesture on a plain view cannot be focused or
        // activated with Return. Siblings solve both at once.
        HStack(spacing: 8) {
            Button {
                if exists { state.openFile(url) }
            } label: {
                HStack(spacing: 8) {
                    Spacer().frame(width: 10)
                    Image(systemName: exists ? "doc.text.fill" : "questionmark.square.dashed")
                        .font(.system(size: 11))
                        .foregroundColor(exists ? Theme.yellow : Theme.overlay0)
                        .frame(width: 14)
                    // Every other surface — tabs, palette, recents, inspector
                    // — titles a file with CodexTree.fullTitle. This row rolled
                    // its own, so a pinned INDEX.md read "Index" and matched
                    // nothing else on screen.
                    Text(CodexTree.fullTitle(for: url))
                        .font(.system(size: Theme.size(12)))
                        .foregroundColor(exists ? (isSelected ? Theme.text : Theme.subtext)
                                                : Theme.overlay0)
                        .strikethrough(!exists, color: Theme.overlay0)
                        .lineLimit(1)
                        .truncationMode(.middle)
                    Spacer(minLength: 4)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .disabled(!exists)
            .help(exists ? url.path : "Missing: \(url.path)")

            Button {
                state.togglePin(url)
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 9))
                    .foregroundColor(Theme.overlay0)
                    .frame(width: 14, height: 14)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .help("Unpin")
            .opacity(hovered || !exists ? 1 : 0)
        }
        .padding(.vertical, 4).padding(.horizontal, 8)
        .background(isSelected
                    ? Theme.yellow.opacity(0.16)
                    : (hovered ? Theme.surface0.opacity(0.5) : Color.clear))
        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
        .onHover { hovered = $0 }
    }
}
