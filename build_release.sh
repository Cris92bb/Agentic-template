#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

TARGET="${1:-all}"

if [ "$TARGET" = "linux" ] || [ "$TARGET" = "all" ]; then
  echo "Building release bundle for Linux..."
  flutter build linux --release
  echo "Linux release binary located at:"
  echo "$DIR/build/linux/x64/release/bundle/agentic_template"
fi

if [ "$TARGET" = "web" ] || [ "$TARGET" = "all" ]; then
  echo "Building optimized release bundle for Web..."
  ./build_web.sh
fi

echo "All requested builds complete!"
