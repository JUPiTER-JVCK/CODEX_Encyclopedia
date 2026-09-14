// RenderIcon — draws Codex.app's AppIcon at 1024pt, for package_app.sh.
//
// A separate executable target rather than a heredoc inside the packaging
// script, so `swift build` type-checks it on every pull request. It lived as
// a shell string until the icon path proved it needed the compiler: the
// previous generator depended on Pillow, silently produced a blank square
// when PIL was missing, and nothing ever compiled or ran it in CI, so a
// featureless dark tile shipped for as long as nobody looked at the Dock.
//
// Top-level script code, so this target must NOT be built with
// -parse-as-library (see Package.swift) — unlike the Codex target, which is.
//
// Usage:  RenderIcon <output.png>

import AppKit
import Foundation


func die(_ message: String) -> Never {
    FileHandle.standardError.write(Data("icon: \(message)\n".utf8))
    exit(1)
}

guard CommandLine.arguments.count > 1 else { die("usage: RenderIcon <out.png>") }
let outputPath = CommandLine.arguments[1]

// Theme.swift: blue #89b4fa, lavender #b4befe, mauve #cba6f7, crust #11111b.
func c(_ r: Int, _ g: Int, _ b: Int) -> NSColor {
    NSColor(srgbRed: CGFloat(r)/255, green: CGFloat(g)/255,
            blue: CGFloat(b)/255, alpha: 1)
}
let size: CGFloat = 1024
let image = NSImage(size: NSSize(width: size, height: size))
image.lockFocus()
guard let ctx = NSGraphicsContext.current?.cgContext else { die("no graphics context") }

// macOS app icons sit inset inside their canvas rather than bleeding to the
// edge, so the rounded square is drawn at ~82% with a squircle-ish radius.
let inset  = size * 0.09
let rect   = CGRect(x: inset, y: inset, width: size - inset*2, height: size - inset*2)
let radius = rect.width * 0.235
let path   = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
ctx.saveGState()
path.addClip()
guard let gradient = NSGradient(colors: [c(0x89,0xb4,0xfa),
                                         c(0xb4,0xbe,0xfe),
                                         c(0xcb,0xa6,0xf7)]) else { die("gradient") }
gradient.draw(in: rect, angle: -45)
ctx.restoreGState()

// The same symbol the Welcome hero uses, so the Dock matches the app.
let cfg = NSImage.SymbolConfiguration(pointSize: size * 0.42, weight: .medium)
guard let symbol = NSImage(systemSymbolName: "books.vertical.fill",
                           accessibilityDescription: "Codex")?
        .withSymbolConfiguration(cfg) else { die("books.vertical.fill unavailable") }
let tinted = NSImage(size: symbol.size)
tinted.lockFocus()
c(0x11,0x11,0x1b).set()
NSRect(origin: .zero, size: symbol.size).fill()
symbol.draw(at: .zero, from: NSRect(origin: .zero, size: symbol.size),
            operation: .destinationIn, fraction: 1)
tinted.unlockFocus()
tinted.draw(in: CGRect(x: (size - symbol.size.width)/2,
                       y: (size - symbol.size.height)/2,
                       width: symbol.size.width, height: symbol.size.height))
image.unlockFocus()

guard let tiff = image.tiffRepresentation,
      let rep  = NSBitmapImageRep(data: tiff),
      let png  = rep.representation(using: .png, properties: [:]) else { die("PNG encode") }
do {
    try png.write(to: URL(fileURLWithPath: outputPath))
} catch {
    die("write failed: \(error)")
}
