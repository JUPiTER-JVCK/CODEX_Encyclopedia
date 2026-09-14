#!/bin/bash
# Install Codex.command — the double-clickable way to install the Codex reader.
#
# Why this file exists: the repository ships source, not an application.
# Codex.app is gitignored and produced by package_app.sh, so someone who
# downloads the project and looks for an icon to double-click will not find
# one. Every instruction we had started with "open a terminal". Finder runs
# a .command file by opening Terminal on it, so this is that same script with
# a door onto it that Finder understands.
#
# It adds no build logic. It checks the two things that are worth checking,
# prints the two things that are worth warning about, and then hands off to
# package_app.sh --icon --install, which compiles, bundles, draws the icon,
# ad-hoc signs, and copies to /Applications.

set -euo pipefail
cd "$(dirname "$0")"

BOLD=$(printf '\033[1m'); OFF=$(printf '\033[0m')

pause() {
    # Terminal's default is to close the window when the shell exits cleanly,
    # which would flash the result past too fast to read — and on a failure
    # would hide the reason entirely.
    echo
    read -r -p "Press Return to close this window. " _ || true
}

fail() {
    echo
    echo "${BOLD}✘ Install did not finish.${OFF}"
    echo "  The error is above. Nothing was installed, and nothing was changed"
    echo "  in /Applications."
    pause
    exit 1
}
trap fail ERR

echo "${BOLD}Installing Codex${OFF}"
echo

# ── Is this even a Mac ─────────────────────────────────────────────────────
if [ "$(uname -s)" != "Darwin" ]; then
    echo "This installer builds a macOS application and only runs on macOS."
    echo "On Linux or Windows, read the codex as markdown, or run the CORE"
    echo "web app in Codex_LMS/ instead."
    pause
    exit 1
fi

# ── Xcode command line tools ───────────────────────────────────────────────
#
# Without them `swift build` fails with a bare `xcrun: error: invalid active
# developer path`, which says nothing about what to do next.
if ! xcode-select -p >/dev/null 2>&1; then
    echo "${BOLD}The Xcode command line tools are not installed.${OFF}"
    echo
    echo "They carry the Swift compiler this app is built with. Install them"
    echo "with:"
    echo
    echo "    ${BOLD}xcode-select --install${OFF}"
    echo
    echo "A system dialog will appear and the download takes a few minutes."
    echo "When it finishes, double-click this file again."
    pause
    exit 1
fi

# ── What is about to happen, before it happens ─────────────────────────────
cat <<'NOTICE'
This will:

  1. Compile the reader from the Swift source in this folder.
  2. Draw the app icon.
  3. Copy Codex.app into /Applications.

Step 3 needs administrator rights, so Terminal will ask for your password
in a moment. That prompt is this script and nothing else — a downloaded
file asking for a password is worth being suspicious of, which is why it
is being said up front rather than left to surprise you.

The first build takes a few minutes. Later ones are much faster.

NOTICE

# ── Hand off ───────────────────────────────────────────────────────────────
#
# --icon is deliberate rather than default: package_app.sh will otherwise
# reuse a cached Codex.app.icon-backup/AppIcon.icns, and on any machine that
# built a version from before the renderer was rewritten, that cache holds
# the old blank square.
./package_app.sh --icon --install

cat <<'DONE'

────────────────────────────────────────────────────────────────────────────
Codex is now in /Applications.

Open it the way you open anything else: double-click it in Applications,
the Dock, or Launchpad, or press ⌘-Space and type Codex. No terminal, and
no rebuild until the source changes.

DONE

trap - ERR
pause
