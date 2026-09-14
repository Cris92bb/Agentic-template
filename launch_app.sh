#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ARCH_DIR="$(uname -m | sed -e 's/x86_64/x64/' -e 's/aarch64/arm64/')"
RELEASE_BIN="$DIR/build/linux/$ARCH_DIR/release/bundle/agentic_template"
DEBUG_BIN="$DIR/build/linux/$ARCH_DIR/debug/bundle/agentic_template"

TARGET_BIN=""
if [ -f "$RELEASE_BIN" ] && [ -f "$DEBUG_BIN" ]; then
    if [ "$DEBUG_BIN" -nt "$RELEASE_BIN" ]; then
        TARGET_BIN="$DEBUG_BIN"
    else
        TARGET_BIN="$RELEASE_BIN"
    fi
elif [ -f "$RELEASE_BIN" ]; then
    TARGET_BIN="$RELEASE_BIN"
elif [ -f "$DEBUG_BIN" ]; then
    TARGET_BIN="$DEBUG_BIN"
else
    cd "$DIR"
    flutter build linux --debug
    TARGET_BIN="$DEBUG_BIN"
fi

cd "$(dirname "$TARGET_BIN")"
exec "$TARGET_BIN" "$@"
