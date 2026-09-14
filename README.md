# Agentic Template for Flutter

A clean, modular Flutter template designed from first principles for **AI agentic pair-programming** and modern multi-device applications, based on architectural patterns from [Pin](https://github.com/cris92bb/Pin).

Built with strict **Feature-Sliced Design (FSD v2.1)** and automated verification tools, it includes turnkey support and responsive placeholders for:
- ⌚ **Wearable**: Smartwatch / Wear OS circular displays, rotary physics, glanceable UI
- 📱 **Smartphone**: Compact single-column mobile layouts with touch-optimized targets
- 📖 **Foldable**: Dual-pane / master-detail layouts adapting when unfolded
- 🌐 **Web**: WASM-GC ready compilation, PWA manifest, desktop keyboard navigation
- 🐧 **Linux Desktop**: Native GTK runner, theme sync, window drag/resize channels, `.desktop` launcher

---

## 🚀 Quick Start

### 1. Run the App
```bash
flutter run -d linux
# Or run for web:
flutter run -d chrome
```

### 2. Verify Architecture (FSD v2.1)
```bash
# Run strict AST architecture validator
dart run tool/verify_fsd.dart --strict

# Run automated CI test suite
flutter test
```

### 3. Build Production Releases
```bash
# Build Linux desktop bundle
./build_release.sh linux

# Build optimized Web bundle (WASM-GC + Gzip)
./build_release.sh web
```

---

## 🏛️ Architecture: Feature-Sliced Design (FSD v2.1)

The codebase is organized into strict hierarchical layers:

```
lib/
├── app/          # Application root, theme definitions, scroll behaviors
├── pages/        # Full-screen views / route targets
│   └── home/     # Adaptive Home orchestrator & tier views
├── widgets/      # Composite UI blocks orchestrating features & entities
├── features/     # Discrete user action slices (theme toggle, device simulator, actions)
├── entities/     # Domain business models and state (app settings, data items)
└── shared/       # Primitives, tokens, breakpoints, wearable geometry, storage
```

### Unidirectional Import Hierarchy
$$\text{app} \succ \text{pages} \succ \text{widgets} \succ \text{features} \succ \text{entities} \succ \text{shared}$$

- Code in any layer can **only** import from layers strictly below it.
- Slices in the same layer (e.g., two `features` or two `entities`) **never** import each other directly.
- Every slice exposes its public API through a single barrel file (`<slice>.dart`).

---

## 🖥️ In-App Device Simulator

When running the application, use the device switcher in the header or menu to preview and test the UI across all 4 form factors:
1. **Auto Detect**: Responds dynamically to the current window/screen size.
2. **Wearable (Round Watch 200×200)**: Simulates a Wear OS circular watch with safe inset boundaries.
3. **Smartphone (Portrait 390×844)**: Simulates a modern smartphone viewport.
4. **Foldable (Unfolded 700×800)**: Simulates an unfolded foldable dual-pane surface.
5. **Desktop / Web**: Full wide layout with navigation rail and workspace.

---

## 🤖 AI Agent Workflow

AI coding agents (e.g., Claude, Gemini, GPT) working in this repository must follow:
- [AGENTS.md](AGENTS.md): Global agent guidelines and commit policies.
- [.agents/rules/architecture.md](.agents/rules/architecture.md): FSD v2.1 specifications.
- [.agents/rules/design-system.md](.agents/rules/design-system.md): Semantic design tokens.
- [.agents/rules/form-factors.md](.agents/rules/form-factors.md): Multi-device layout guidelines.
- [.agents/rules/git-commits.md](.agents/rules/git-commits.md): Conventional Commits standard.

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run architecture boundary audit specifically
flutter test test/architecture/fsd_architecture_test.dart
```

---

## 📄 License
MIT License. Free to use, adapt, and build upon.
