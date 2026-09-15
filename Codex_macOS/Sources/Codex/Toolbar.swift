import SwiftUI

// MARK: - Top toolbar (sidebar toggle, history, breadcrumb, search, inspector)

struct CodexToolbar: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        HStack(spacing: 14) {
            ToolbarIconButton(systemName: "sidebar.left", help: "Toggle sidebar (⌘1)") {
                withAnimation(.easeInOut(duration: 0.18)) { state.sidebarVisible.toggle() }
            }

            // Welcome is where the app opens, and before this there was no way
            // back to it short of closing every tab.
            ToolbarIconButton(systemName: "house",
                              tint: state.selectedTab == nil ? Theme.blue : nil,
                              help: "Welcome (⌘⇧H)") {
                state.showWelcome()
            }

            HStack(spacing: 2) {
                ToolbarIconButton(systemName: "chevron.backward",
                                  help: "Back (⌘[)",
                                  enabled: state.history.canGoBack) {
                    if let url = state.history.goBack() { state.openFile(url, pushHistory: false) }
                }
                ToolbarIconButton(systemName: "chevron.forward",
                                  help: "Forward (⌘])",
                                  enabled: state.history.canGoForward) {
                    if let url = state.history.goForward() { state.openFile(url, pushHistory: false) }
                }
            }

            BreadcrumbBar()

            Spacer(minLength: 16)

            ToolbarSearchField()

            HStack(spacing: 2) {
                // `enabled:` is what dims the glyph; `.disabled()` alone left
                // it at full opacity, so the button looked live while dead.
                ToolbarIconButton(systemName: state.selectedTabIsPinned ? "star.fill" : "star",
                                  tint: state.selectedTabIsPinned ? Theme.yellow : nil,
                                  help: state.selectedTabIsPinned
                                        ? "Unpin current file (⌘D)" : "Pin current file (⌘D)",
                                  enabled: state.selectedTab != nil) {
                    if let url = state.selectedTab {
                        state.bookmarks.togglePin(url.path)
                        state.objectWillChange.send()
                    }
                }

                ToolbarIconButton(systemName: "sidebar.right",
                                  help: "Toggle inspector (⌘0)") {
                    withAnimation(.easeInOut(duration: 0.18)) { state.inspectorVisible.toggle() }
                }
            }
        }
        // `.windowStyle(.hiddenTitleBar)` hides the bar but keeps the close /
        // minimise / zoom buttons, which float over the top-left of the content
        // at roughly x=20..72. With a flat 14pt inset the sidebar toggle sat
        // underneath them. 78 clears the cluster with a little air.
        .padding(.leading, 78).padding(.trailing, 14).padding(.vertical, 9)
        .frame(height: 50)
        .background(VisualEffectBlur(material: .titlebar, blendingMode: .withinWindow).ignoresSafeArea())
        .overlay(Rectangle().fill(Theme.hairline).frame(height: 1), alignment: .bottom)
    }
}

// MARK: - Toolbar icon button

struct ToolbarIconButton: View {
    let systemName: String
    var tint: Color? = nil
    var help: String? = nil
    var enabled: Bool = true
    let action: () -> Void
    @State private var hovered = false

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(enabled ? (tint ?? Theme.subtext) : Theme.overlay0.opacity(0.5))
                .frame(width: 26, height: 26)
                .background(hovered && enabled
                            ? RoundedRectangle(cornerRadius: 5).fill(Theme.surface1.opacity(0.5))
                            : nil)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(!enabled)
        .onHover { hovered = $0 }
        .help(help ?? "")
    }
}

// MARK: - Breadcrumb (clickable path crumbs)

struct BreadcrumbBar: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        HStack(spacing: 6) {
            if let url = state.selectedTab {
                let parts = relativeParts(url)
                Image(systemName: "books.vertical.fill")
                    .font(.system(size: 11))
                    .foregroundColor(Theme.lavender)
                // The root was the one crumb left as plain text while every
                // deeper one became clickable — and the project root does have
                // a README, so it has the same destination as any other crumb.
                Crumb(label: "Codex", isLast: false, target: rootTarget)
                ForEach(0..<parts.count, id: \.self) { i in
                    Image(systemName: "chevron.right")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(Theme.overlay0.opacity(0.7))
                    Crumb(label: parts[i],
                          isLast: i == parts.count - 1,
                          target: crumbTarget(url, depth: i))
                }
            } else {
                Image(systemName: "books.vertical.fill")
                    .font(.system(size: 11))
                    .foregroundColor(Theme.lavender)
                Text("Codex").font(Theme.FontStyle.subhead).foregroundColor(Theme.subtext)
                Text("·").font(Theme.FontStyle.subhead).foregroundColor(Theme.overlay0)
                Text("Welcome").font(Theme.FontStyle.headline).foregroundColor(Theme.text)
            }
        }
    }

    /// The project's own entry point, for the leading "Codex" crumb.
    private var rootTarget: URL? {
        for candidate in ["README.md", "INDEX.md"] {
            let u = state.projectRoot.appendingPathComponent(candidate)
            if FileManager.default.fileExists(atPath: u.path) { return u }
        }
        return nil
    }

    /// The index or README a crumb should open, or nil if there isn't one.
    ///
    /// A crumb names a directory; directories are not openable documents, so
    /// the click resolves to that directory's own entry point the same way an
    /// in-document link to a folder does. Crumbs with no index stay inert
    /// rather than beeping — `Crumb` renders those without the affordance, so
    /// nothing claims to be clickable and isn't.
    private func crumbTarget(_ url: URL, depth: Int) -> URL? {
        let prefix = state.projectRoot.path + "/"
        let rel = url.path.replacingOccurrences(of: prefix, with: "")
        let raw = rel.split(separator: "/").map(String.init)
        guard depth < raw.count else { return nil }
        if depth == raw.count - 1 { return nil }          // the file itself
        var dir = state.projectRoot
        for part in raw.prefix(depth + 1) { dir.appendPathComponent(part) }
        for candidate in ["INDEX.md", "README.md"] {
            let u = dir.appendingPathComponent(candidate)
            if FileManager.default.fileExists(atPath: u.path) { return u }
        }
        return nil
    }

    private func relativeParts(_ url: URL) -> [String] {
        let prefix = state.projectRoot.path + "/"
        let rel = url.path.replacingOccurrences(of: prefix, with: "")
        let raw = rel.split(separator: "/").map(String.init)
        return raw.enumerated().map { idx, part in
            if idx == raw.count - 1 {
                return CodexTree.prettyFilename(part)
            }
            return part.split(separator: "_", maxSplits: 1).last.map(String.init)?
                .replacingOccurrences(of: "_", with: " ").capitalized ?? part
        }
    }
}

// MARK: - One breadcrumb segment

private struct Crumb: View {
    let label: String
    let isLast: Bool
    let target: URL?
    @EnvironmentObject var state: AppState
    @State private var hovered = false

    var body: some View {
        // A Button only when there is somewhere to go. An onTapGesture is not
        // focusable and does not answer Return, so the first version of this
        // was pointer-only; and a Button with no action would advertise a
        // destination that does not exist. Targetless crumbs stay plain text.
        if let target {
            Button { state.openFile(target) } label: { text }
                .buttonStyle(.plain)
                .onHover { hovered = $0 }
                .help("Open \(label)")
        } else {
            text.help(label)
        }
    }

    private var text: some View {
        Text(label)
            .font(isLast ? Theme.FontStyle.headline : Theme.FontStyle.subhead)
            .foregroundColor(isLast ? Theme.text
                                    : (hovered ? Theme.blue : Theme.subtext))
            .underline(hovered)
            .lineLimit(1)
            .contentShape(Rectangle())
    }
}

// MARK: - Toolbar search field

/// A real text field, not a button wearing one.
///
/// This was a `Button` styled to look exactly like a search box. Clicking it
/// opened the palette, which is fine — but it looked typable, and anyone who
/// did the obvious thing and started typing got nothing, with no hint as to
/// why. Now the first keystroke opens the palette carrying what you typed,
/// and focus follows it there.
struct ToolbarSearchField: View {
    @EnvironmentObject var state: AppState
    @State private var hovered = false
    @FocusState private var focused: Bool

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(Theme.overlay1)
            TextField("Search Codex", text: $state.paletteQuery)
                .textFieldStyle(.plain)
                .font(Theme.FontStyle.subhead)
                .foregroundColor(Theme.text)
                .focused($focused)
                .onSubmit { state.paletteVisible = true }
                .onChange(of: state.paletteQuery) { text in
                    // Hand off to the palette as soon as there is something to
                    // search. It owns the results list and the key handling.
                    if !text.isEmpty && focused { state.paletteVisible = true }
                }
            if state.paletteQuery.isEmpty {
                Text("⌘P")
                    .font(.system(size: Theme.size(10), weight: .medium, design: .monospaced))
                    .foregroundColor(Theme.overlay0)
                    .padding(.horizontal, 5).padding(.vertical, 1)
                    .background(RoundedRectangle(cornerRadius: 3).fill(Theme.surface1.opacity(0.6)))
            }
        }
        .padding(.horizontal, 10).padding(.vertical, 5)
        .frame(width: 220)
        .background(RoundedRectangle(cornerRadius: 7, style: .continuous)
                        .fill(hovered || focused ? Theme.surface0.opacity(0.85)
                                                 : Theme.surface0.opacity(0.55)))
        .overlay(RoundedRectangle(cornerRadius: 7)
                    .strokeBorder(focused ? Theme.accent.opacity(0.7) : Theme.hairline,
                                  lineWidth: focused ? 1 : 0.5))
        .onHover { hovered = $0 }
    }
}
