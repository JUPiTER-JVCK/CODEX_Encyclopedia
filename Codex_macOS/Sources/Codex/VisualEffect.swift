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

    /// Applies the configuration from `viewDidMoveToWindow`.
    ///
    /// The first version did this from a one-shot `DispatchQueue.main.async`
    /// in `makeNSView`, which is a guess about timing: if the view was still
    /// unattached when the closure ran, `window` was nil, nothing retried, and
    /// the whole vibrancy fix silently did nothing. AppKit already has the
    /// callback for "you are now in a window" — and it fires again on every
    /// re-attachment, so a window change cannot strand the configuration.
    final class ProbeView: NSView {
        override func viewDidMoveToWindow() {
            super.viewDidMoveToWindow()
            guard let window else { return }
            window.isOpaque = false
            window.backgroundColor = .clear
        }
    }

    func makeNSView(context: Context) -> NSView { ProbeView() }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

/// Convenience modifier — applies an NSVisualEffectView as background.
extension View {
    func vibrancy(_ material: NSVisualEffectView.Material = .sidebar,
                  blending: NSVisualEffectView.BlendingMode = .behindWindow) -> some View {
        background(VisualEffectBlur(material: material, blendingMode: blending).ignoresSafeArea())
    }
}
