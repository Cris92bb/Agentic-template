#!/usr/bin/env bash
# Installs the Linux launcher (app.desktop) and icon for the current user,
# pointing the launcher at this checkout's launch_app.sh.
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
APPS_DIR="$DATA_DIR/applications"
ICON_DIR="$DATA_DIR/icons/hicolor/512x512/apps"

mkdir -p "$APPS_DIR" "$ICON_DIR"
cp "$DIR/web/icons/Icon-512.png" "$ICON_DIR/agentic_template.png"

# Escape characters that are special in the sed replacement.
ESCAPED_DIR="$(printf '%s' "$DIR" | sed 's/[&|\\]/\\&/g')"
sed "s|@APP_DIR@|$ESCAPED_DIR|g" "$DIR/app.desktop" > "$APPS_DIR/agentic_template.desktop"
chmod +x "$DIR/launch_app.sh" "$APPS_DIR/agentic_template.desktop"

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$APPS_DIR" || true
fi

echo "Installed launcher: $APPS_DIR/agentic_template.desktop"
