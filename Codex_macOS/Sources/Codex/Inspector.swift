import SwiftUI

// MARK: - Right inspector (Outline · Info · Recents)

struct InspectorView: View {
    @EnvironmentObject var state: AppState
    @State private var tab: InspectorTab = .outline

    enum InspectorTab: String, CaseIterable {
        case outline = "Outline"
        case info    = "Info"
        case recents = "Recents"

        var systemImage: String {
            switch self {
            case .outline: return "list.bullet.indent"
            case .info:    return "info.circle"
            case .recents: return "clock"
            }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(InspectorTab.allCases, id: \.self) { t in
                    Button(action: { tab = t }) {
                        VStack(spacing: 2) {
                            Image(systemName: t.systemImage)
                                .font(.system(size: 13, weight: .medium))
                            Text(t.rawValue)
                                .font(.system(size: 9, weight: .medium))
                        }
                        .foregroundColor(tab == t ? Theme.accent : Theme.overlay1)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 9)
                        .background(tab == t ? Theme.accent.opacity(0.12) : Color.clear)
                    }
                    .buttonStyle(.plain)
                }
            }
            .background(Theme.mantle.opacity(0.5))
            .overlay(Rectangle().fill(Theme.hairline).frame(height: 1), alignment: .bottom)

            Group {
                switch tab {
                case .outline: OutlinePane()
                case .info:    InfoPane()
                case .recents: RecentsPane()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(VisualEffectBlur(material: .sidebar, blendingMode: .behindWindow).ignoresSafeArea())
        .overlay(Rectangle().fill(Theme.hairline).frame(width: 1), alignment: .leading)
    }
}

// MARK: - Outline (TOC)

private struct OutlinePane: View {
    @EnvironmentObject var state: AppState

    private var headings: [(level: Int, text: String, anchor: String)] {
        guard let url = state.selectedTab,
              let src = try? String(contentsOf: url, encoding: .utf8) else { return [] }
        return MarkdownParser.parse(src).compactMap {
            if case .heading(let l, let t, let a) = $0 { return (l, t, a) }
            return nil
        }
    }

    var body: some View {
        if state.selectedTab == nil {
            EmptyPaneView(systemImage: "list.bullet.indent",
                          title: "No file selected",
                          subtitle: "Open a markdown file to see its outline.")
        } else if headings.isEmpty {
            EmptyPaneView(systemImage: "doc.text",
                          title: "No headings",
                          subtitle: "This file has no Markdown headings to outline.")
        } else {
            ScrollView {
                VStack(alignment: .leading, spacing: 1) {
                    SectionHeader(label: "On This Page")
                    ForEach(0..<headings.count, id: \.self) { i in
                        OutlineRow(level: headings[i].level,
                                   text: headings[i].text,
                                   anchor: headings[i].anchor,
                                   onSelect: { state.pendingAnchor = headings[i].anchor })
                    }
                }
                .padding(.horizontal, 12).padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
    }
}

private struct OutlineRow: View {
    let level: Int; let text: String; let anchor: String
    let onSelect: () -> Void
    @State private var hovered = false

    var body: some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 1.5)
                .fill(level == 1 ? Theme.blue : Theme.overlay0.opacity(0.5))
                .frame(width: 2, height: level == 1 ? 14 : 10)
            Text(text)
                .font(level == 1 ? .system(size: 12, weight: .semibold)
                                 : .system(size: 11, weight: level == 2 ? .medium : .regular))
                .foregroundColor(level == 1 ? Theme.text : Theme.subtext)
                .lineLimit(1)
                .truncationMode(.tail)
            Spacer(minLength: 0)
        }
        .padding(.leading, CGFloat(max(0, level - 1)) * 12)
        .padding(.vertical, 3)
        .padding(.horizontal, 6)
        .background(hovered
                    ? RoundedRectangle(cornerRadius: 5).fill(Theme.surface0.opacity(0.6))
                    : nil)
        .contentShape(Rectangle())
        .onTapGesture(perform: onSelect)
        .onHover { hovered = $0 }
        // The row already looked clickable — hover highlight, contentShape,
        // pointer cursor — while doing nothing at all. The affordance was the
        // promise; this is the part that keeps it.
        .help(anchor.isEmpty ? text : "Jump to \(text)")
    }
}

// MARK: - Info pane

private struct InfoPane: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        if let url = state.selectedTab {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(label: "File")
                    InfoRow(icon: "doc.text", label: "Name", value: url.lastPathComponent)
                    InfoRow(icon: "folder", label: "Location",
                            value: url.deletingLastPathComponent().path.replacingOccurrences(
                                of: state.projectRoot.path + "/", with: ""))
                    if let attrs = try? FileManager.default.attributesOfItem(atPath: url.path) {
                        if let size = attrs[.size] as? Int {
                            InfoRow(icon: "internaldrive", label: "Size", value: formatBytes(size))
                        }
                        if let modified = attrs[.modificationDate] as? Date {
                            InfoRow(icon: "clock", label: "Modified", value: HumanDate.describe(modified))
                        }
                    }
                    InfoRow(icon: "number", label: "Lines",
                            value: lineCount(url).map { "\($0)" } ?? "—")

                    if let tags = frontmatterTags(url), !tags.isEmpty {
                        SectionHeader(label: "Tags").padding(.top, 8)
                        FlowLayout(spacing: 6) {
                            ForEach(tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(Theme.accent)
                                    .padding(.horizontal, 8).padding(.vertical, 3)
                                    .background(Capsule().fill(Theme.accent.opacity(0.15)))
                            }
                        }
                    }

                    SectionHeader(label: "Actions").padding(.top, 8)
                    ActionRow(icon: "folder", label: "Reveal in Finder") {
                        LinkResolver.revealInFinder(url)
                    }
                    ActionRow(icon: "doc.on.doc", label: "Copy Path") {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(url.path, forType: .string)
                    }
                    ActionRow(icon: state.bookmarks.isPinned(url.path) ? "star.slash" : "star",
                              label: state.bookmarks.isPinned(url.path) ? "Unpin" : "Pin to Top") {
                        state.bookmarks.togglePin(url.path)
                        state.objectWillChange.send()
                    }
                }
                .padding(.horizontal, 14).padding(.vertical, 12)
            }
        } else {
            EmptyPaneView(systemImage: "info.circle",
                          title: "Nothing selected",
                          subtitle: "Open a file to view its info.")
        }
    }

    private func formatBytes(_ b: Int) -> String {
        ByteCountFormatter.string(fromByteCount: Int64(b), countStyle: .file)
    }

    private func lineCount(_ url: URL) -> Int? {
        guard let s = try? String(contentsOf: url, encoding: .utf8) else { return nil }
        return s.components(separatedBy: "\n").count
    }

    private func frontmatterTags(_ url: URL) -> [String]? {
        guard let s = try? String(contentsOf: url, encoding: .utf8) else { return nil }
        let lines = s.components(separatedBy: "\n")
        guard lines.first == "---" else { return nil }
        for line in lines.dropFirst() {
            if line == "---" { break }
            if line.hasPrefix("tags:") {
                let raw = line.dropFirst("tags:".count).trimmingCharacters(in: .whitespaces)
                let inner = raw.trimmingCharacters(in: CharacterSet(charactersIn: "[]"))
                return inner.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                    .filter { !$0.isEmpty }
            }
        }
        return nil
    }
}

// MARK: - Recents

private struct RecentsPane: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        if state.bookmarks.recents.isEmpty {
            EmptyPaneView(systemImage: "clock",
                          title: "No recents yet",
                          subtitle: "Files you open will appear here.")
        } else {
            ScrollView {
                VStack(alignment: .leading, spacing: 1) {
                    SectionHeader(label: "Recently Opened")
                    ForEach(state.bookmarks.recents, id: \.self) { path in
                        let url = URL(fileURLWithPath: path)
                        RecentRow(url: url)
                    }
                }
                .padding(.horizontal, 12).padding(.vertical, 10)
            }
        }
    }
}

private struct RecentRow: View {
    let url: URL
    @EnvironmentObject var state: AppState
    @State private var hovered = false

    var body: some View {
        Button(action: { state.openFile(url) }) {
            HStack(spacing: 8) {
                Image(systemName: "doc.text")
                    .font(.system(size: 11))
                    .foregroundColor(Theme.overlay1)
                VStack(alignment: .leading, spacing: 1) {
                    Text(CodexTree.fullTitle(for: url))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Theme.text)
                        .lineLimit(1)
                    Text(url.deletingLastPathComponent().lastPathComponent)
                        .font(.system(size: 10))
                        .foregroundColor(Theme.overlay1)
                        .lineLimit(1)
                }
                Spacer()
            }
            .padding(.vertical, 5).padding(.horizontal, 6)
            .background(hovered
                        ? RoundedRectangle(cornerRadius: 6).fill(Theme.surface0.opacity(0.6))
                        : nil)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .onHover { hovered = $0 }
    }
}

// MARK: - Shared pieces

struct SectionHeader: View {
    let label: String
    var body: some View {
        Text(label.uppercased())
            .font(.system(size: 9, weight: .semibold))
            .tracking(0.8)
            .foregroundColor(Theme.overlay1)
            .padding(.horizontal, 6).padding(.bottom, 4)
    }
}

private struct InfoRow: View {
    let icon: String; let label: String; let value: String
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: icon).font(.system(size: 11))
                .foregroundColor(Theme.overlay1).frame(width: 14)
            VStack(alignment: .leading, spacing: 1) {
                Text(label).font(.system(size: 10, weight: .medium))
                    .foregroundColor(Theme.overlay1)
                Text(value).font(.system(size: 12, design: .monospaced))
                    .foregroundColor(Theme.text)
                    .textSelection(.enabled)
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding(.horizontal, 6)
    }
}

private struct ActionRow: View {
    let icon: String; let label: String; let action: () -> Void
    @State private var hovered = false
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon).font(.system(size: 11)).foregroundColor(Theme.accent)
                    .frame(width: 14)
                Text(label).font(.system(size: 12))
                    .foregroundColor(Theme.text)
                Spacer()
            }
            .padding(.vertical, 5).padding(.horizontal, 6)
            .background(hovered
                        ? RoundedRectangle(cornerRadius: 6).fill(Theme.surface0.opacity(0.6))
                        : nil)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .onHover { hovered = $0 }
    }
}

private struct EmptyPaneView: View {
    let systemImage: String; let title: String; let subtitle: String
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(.system(size: 28, weight: .light))
                .foregroundColor(Theme.overlay0)
            Text(title).font(.system(size: 13, weight: .semibold))
                .foregroundColor(Theme.subtext)
            Text(subtitle).font(.system(size: 11))
                .foregroundColor(Theme.overlay1)
                .multilineTextAlignment(.center)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Simple flow layout for tag pills (macOS 13+)

struct FlowLayout: Layout {
    var spacing: CGFloat = 6

    private typealias Row = [(index: Int, size: CGSize)]

    /// One line-breaking pass, shared by measurement and placement.
    ///
    /// These used to be two loops with two different predicates —
    /// `lineW + width > maxW` when measuring, `x + width > maxX` when placing,
    /// where `lineW` carried a trailing `spacing` that `x` did not. They could
    /// therefore disagree about where a row ended, and the height handed to
    /// SwiftUI came up a row short of the height actually used, clipping the
    /// last row of tags. One routine cannot disagree with itself.
    private func rows(maxWidth: CGFloat, subviews: Subviews) -> [Row] {
        var rows: [Row] = []
        var line: Row = []
        var lineW: CGFloat = 0
        for (i, s) in subviews.enumerated() {
            let sz = s.sizeThatFits(.unspecified)
            let needed = line.isEmpty ? sz.width : lineW + spacing + sz.width
            // Never wrap an empty line: a single item wider than the container
            // has nowhere better to go, and wrapping it would emit a blank row.
            if !line.isEmpty && needed > maxWidth {
                rows.append(line)
                line = [(i, sz)]
                lineW = sz.width
            } else {
                line.append((i, sz))
                lineW = needed
            }
        }
        if !line.isEmpty { rows.append(line) }
        return rows
    }

    private func width(of row: Row) -> CGFloat {
        row.reduce(0) { $0 + $1.size.width } + spacing * CGFloat(max(0, row.count - 1))
    }

    private func height(of row: Row) -> CGFloat {
        row.map(\.size.height).max() ?? 0
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = rows(maxWidth: proposal.width ?? .infinity, subviews: subviews)
        guard !rows.isEmpty else { return .zero }
        return CGSize(
            width: rows.map(width(of:)).max() ?? 0,
            height: rows.reduce(0) { $0 + height(of: $1) }
                  + spacing * CGFloat(rows.count - 1)
        )
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize,
                       subviews: Subviews, cache: inout ()) {
        var y = bounds.minY
        for row in rows(maxWidth: bounds.width, subviews: subviews) {
            var x = bounds.minX
            for item in row {
                subviews[item.index].place(at: CGPoint(x: x, y: y), proposal: .init(item.size))
                x += item.size.width + spacing
            }
            y += height(of: row) + spacing
        }
    }
}
