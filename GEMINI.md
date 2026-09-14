# Agent Instructions: Feature-Sliced Design & Impactful Changes

For all coding tasks in this repository, the agent must adhere to:

## 1. Feature-Sliced Design (FSD v2.1)
- Never import upwards: `app` $\succ$ `pages` $\succ$ `widgets` $\succ$ `features` $\succ$ `entities` $\succ$ `shared`.
- Never import horizontally across sibling slices (e.g. `features/foo` importing `features/bar`).
- Always consume slices through their public API barrel (`<slice>.dart`).
- Always run `dart run tool/verify_fsd.dart --strict` before submitting changes.

## 2. Multi-Device Form Factors
- Respect all 4 screen tiers: Wearable, Smartphone, Foldable, Desktop/Web.
- Use `Breakpoints.getTier(context)` and `WearableUtils`.
- Never hardcode screen widths or assume a single device form factor.

## 3. Mandatory Commits on Impactful Changes
- **Requirement**: For every impactful change made to the codebase (feature addition, bug/layout fix, script/build update, documentation, or test modification), create a Git commit.
- **Pre-requisite**: Ensure changes are verified (e.g., `flutter test` or `dart analyze` pass).
- **Format**: Follow Conventional Commits:
  - `feat(...)`: new feature or functionality
  - `fix(...)`: bug or layout fix
  - `docs(...)`: documentation changes
  - `style(...)`: UI polish and styling tweaks
  - `refactor(...)`: non-breaking code restructuring
  - `test(...)`: test additions or adjustments
  - `chore(...)`: build scripts, desktop integration, dependency management
