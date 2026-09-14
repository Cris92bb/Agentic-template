#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

echo "======================================================"
echo " Building Optimized Web Bundle"
echo " Target: WebAssembly (WASM-GC) + JS Fallback"
echo " Optimization Level: -O4"
echo " Icon Tree-Shaking: Enabled"
echo "======================================================"

flutter build web \
  --release \
  --wasm \
  --optimization-level=4 \
  --strip-wasm \
  --no-source-maps \
  --tree-shake-icons

echo ""
echo "Compressing static assets with gzip (-9) for CDN deployment..."
find build/web -type f \( -name "*.wasm" -o -name "*.js" -o -name "*.json" -o -name "*.html" -o -name "*.css" \) -exec gzip -k -9 -f {} + 2>/dev/null || true

echo ""
echo "Optimized Web Build Summary:"
ls -lh build/web/main.dart.wasm build/web/main.dart.js build/web/flutter_bootstrap.js 2>/dev/null || true
echo "======================================================"
echo "Done! The web bundle is ready in build/web."
