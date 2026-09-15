import SwiftUI

// MARK: - Appearance settings (⌘,)

/// The theme picker, OLED toggle and text-size stepper.
///
/// Lives in a `Settings` scene, which is what wires ⌘, on macOS and gives the
/// window its standard placement and title without any of that being spelled
/// out here.
struct AppearanceSettings: View {
    @ObservedObject private var prefs = Preferences.shared

    private let columns = [GridItem(.adaptive(minimum: 132), spacing: 10)]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                section("Theme") {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(Palette.all) { scheme in
                            SwatchButton(scheme: scheme,
                                         isSelected: scheme.id == prefs.themeID,
                                         oled: prefs.oled) {
                                prefs.themeID = scheme.id
                            }
                        }
                    }
                }

                section("Background") {
                    Toggle(isOn: $prefs.oled) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("True black (OLED)")
                            Text(prefs.palette.isDark
                                 ? "Page backgrounds go to #000000."
                                 : "No effect on a light theme.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .toggleStyle(.switch)
                    .disabled(!(Palette.named(prefs.themeID)?.isDark ?? true))
                }

                section("Text size") {
                    HStack(spacing: 14) {
                        Button {
                            prefs.nudgeFontScale(by: -Preferences.fontScaleStep)
                        } label: { Image(systemName: "textformat.size.smaller") }
                        .disabled(prefs.fontScale <= Preferences.fontScaleRange.lowerBound)

                        Text("\(Int((prefs.fontScale * 100).rounded()))%")
                            .font(.system(.body, design: .monospaced))
                            .frame(width: 58)

                        Button {
                            prefs.nudgeFontScale(by: Preferences.fontScaleStep)
                        } label: { Image(systemName: "textformat.size.larger") }
                        .disabled(prefs.fontScale >= Preferences.fontScaleRange.upperBound)

                        Button("Reset") { prefs.fontScale = 1.0 }
                            .disabled(prefs.fontScale == 1.0)
                    }
                    Text("Applies to text. Toolbar and sidebar icons keep their size, so they cannot outgrow the frames they sit in.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                section("Reading width") {
                    Picker("", selection: $prefs.columnWidth) {
                        ForEach(Preferences.ColumnWidth.allCases) { w in
                            Text(w.label).tag(w)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }
            }
            .padding(24)
        }
        .frame(width: 460, height: 560)
    }

    @ViewBuilder
    private func section<Content: View>(_ title: String,
                                        @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(.secondary)
                .tracking(0.6)
            content()
        }
    }
}

// MARK: - One theme swatch

/// A miniature of the scheme, rather than its name in a list.
///
/// The whole point of a theme picker is the colours, so the row shows them:
/// the page background it would paint, with the accent, text and a couple of
/// palette steps laid on top.
private struct SwatchButton: View {
    let scheme: Palette
    let isSelected: Bool
    let oled: Bool
    let action: () -> Void

    /// Preview what would actually be applied, OLED included.
    private var shown: Palette { oled ? scheme.oled : scheme }

    private var accents: [Color] {
        [shown.blue, shown.green, shown.yellow, shown.peach, shown.mauve]
    }

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .bottomLeading) {
                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                        .fill(shown.base)
                    HStack(spacing: 4) {
                        ForEach(Array(accents.indices), id: \.self) { i in
                            Circle().fill(accents[i]).frame(width: 8, height: 8)
                        }
                    }
                    .padding(8)
                    RoundedRectangle(cornerRadius: 7, style: .continuous)
                        .strokeBorder(shown.surface1, lineWidth: 1)
                }
                .frame(height: 56)

                Text(scheme.name)
                    .font(.system(size: 11, weight: isSelected ? .semibold : .regular))
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .padding(6)
            .background(
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(isSelected ? Color.accentColor.opacity(0.18) : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .strokeBorder(isSelected ? Color.accentColor : Color.clear, lineWidth: 1.5)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .help(scheme.name)
    }
}
