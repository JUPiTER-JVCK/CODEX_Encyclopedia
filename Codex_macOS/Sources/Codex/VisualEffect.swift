import SwiftUI
import AppKit

/// SwiftUI wrapper around `NSVisualEffectView` so the sidebar and overlays can
/// participate in macOS vibrancy (the translucent + blur look Apple uses in
/// Mail, Notes, Music, Finder).
struct VisualEffectBlur: NSViewRepresentable {
    var material: NSVisualEffectView.Material = .sidebar
    var blendingMode: NSVisualEffectView.BlendingMode = .behindWindow
    var state: NSVisualEffectView.State = .followsWindowActiveState
    var emphasized: Bool = false

    func makeNSView(context: Context) -> NSVisualEffectView {
        let v = NSVisualEffectView()
        v.material = material
        v.blendingMode = blendingMode
        v.state = state
        v.isEmphasized = emphasized
        return v
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
        nsView.state = state
        nsView.isEmphasized = emphasized
    }
}

/// Makes the hosting window non-opaque with a clear background.
///
/// `NSVisualEffectView` with `.behindWindow` blending samples what is behind
/// the *window*. On an opaque window there is nothing to sample and it renders
/// flat — which is what the sidebar and inspector have been doing, because
/// `RootView` painted an opaque `Theme.base` across the whole window and the
/// window itself is opaque by default. Both vibrancy surfaces were inert.
///
/// Every region is still painted by something (the toolbar has its own
/// material, the document pane its own background, the two side panes their
/// vibrancy), so clearing the window background exposes no gaps.
struct WindowVibrancyConfigurator: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let probe = NSView()
        // The view has no window until it is in the hierarchy.
        DispatchQueue.main.async {
            guard let window = probe.window else { return }
            window.isOpaque = false
            window.backgroundColor = .clear
        }
        return probe
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

/// Convenience modifier — applies an NSVisualEffectView as background.
extension View {
    func vibrancy(_ material: NSVisualEffectView.Material = .sidebar,
                  blending: NSVisualEffectView.BlendingMode = .behindWindow) -> some View {
        background(VisualEffectBlur(material: material, blendingMode: blending).ignoresSafeArea())
    }
}
