# Agent Guidelines for Agentic Template Repository

These instructions apply to all AI coding agents working on this project.

## 1. Feature-Sliced Design (FSD v2.1) Architecture Rules

This project strictly adheres to Feature-Sliced Design (FSD v2.1).

### Hierarchy & Direction
Imports are strictly unidirectional:
$$\text{app} \succ \text{pages} \succ \text{widgets} \succ \text{features} \succ \text{entities} \succ \text{shared}$$

- A file in a layer may **ONLY** import from layers strictly below it.
- **Rule of Cross-Slice Isolation**: Slices residing in the same layer (`features`, `entities`, `widgets`) must **NEVER** import directly from sibling slices. Cross-slice orchestration occurs at higher layers (`widgets` or `pages`).
- **Public API Barrels**: Slices must expose their public interface via `<slice>.dart`. Never perform deep internal segment imports from outside the slice.
- **Automated Verification**: Before concluding work, run `dart run tool/verify_fsd.dart --strict` and `flutter test test/architecture/fsd_architecture_test.dart`. Zero violations are tolerated.

## 2. Multi-Platform & Form-Factor Compatibility

When building or updating UI:
- **Wearable (Smartwatch / Wear OS)**: Both sides $\le 320.0$, circular screen safe padding (`WearableUtils.getSafeCircularPadding`), glanceable cards, high contrast.
- **Smartphone**: Portrait single-pane layout, touch targets $\ge 44 \times 44$, safe area insets.
- **Foldable**: Dual-pane master-detail or wide deck view reacting smoothly when unfolded ($600 \le \text{width} < 1024$), split along reported hinges.
- **Desktop & Web**: Responsive navigation rail, keyboard shortcuts (Ctrl/⌘ + 1–3), mouse hover states, window controls (`WindowControlService` on Linux).
- **Colors**: Read colors from `AppPalette.of(context)`; never branch on `isDark` in widgets (see `.agents/rules/design-system.md`).

## 3. Mandatory Git Commits for Impactful Changes

You MUST create a Git commit for every impactful change made to this repository.

### Requirements:
1. **Verification First**: Verify changes via `flutter test` or `dart analyze` before committing.
2. **Conventional Commits**: Use `feat(...)`, `fix(...)`, `docs(...)`, `style(...)`, `refactor(...)`, `test(...)`, `chore(...)`.
3. **Clean Staging**: Never stage temporary files or build outputs.
