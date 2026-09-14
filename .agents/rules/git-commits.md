# Git Commit Automation Guidelines for AI Agents

Whenever working on this codebase, the agent must adhere to the following rules regarding Git version control:

## 1. Commit on Every Impactful Change
- For every impactful change made to the codebase, you MUST create a Git commit.
- Impactful changes include:
  - Adding or modifying features, UI components, or domain logic.
  - Fixing bugs, layout issues, or regressions.
  - Adding or modifying build scripts, desktop launchers, or configuration files.
  - Updating documentation (`README.md`, guides, or architecture notes).
  - Adding or updating tests.
  - Refactoring or significant dependency adjustments.

## 2. Timing and Quality Verification
- Create commits when a coherent unit of work is completed and verified.
- Run tests (`flutter test`) or static checks (`dart analyze`, `dart run tool/verify_fsd.dart --strict`) before committing to ensure the build remains clean.
- Never commit broken code, syntax errors, or unverified changes.

## 3. Scope & Staging
- Do NOT use blind `git add .` if there are untracked build caches or temporary files.
- Stage specific files or directories related to the change.
- Respect `.gitignore` and ensure transient artifacts (build outputs, `.dart_tool`) are never committed.

## 4. Conventional Commit Messages
- Use clear, professional Conventional Commits format:
  - `feat(<scope>): <short description>`
  - `fix(<scope>): <short description>`
  - `docs(<scope>): <short description>`
  - `refactor(<scope>): <short description>`
  - `style(<scope>): <short description>`
  - `perf(<scope>): <short description>`
  - `test(<scope>): <short description>`
  - `chore(<scope>): <short description>`
