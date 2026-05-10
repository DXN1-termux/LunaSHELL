# LunaSHELL Development Standards

## 🌙 Philosophy
LunaSHELL is built for **resilience** and **precision**. Every component must handle failures gracefully and provide clear feedback in the midnight-blue aesthetic.

## 🛠 Architectural Tiers
1.  **Engine (`luna_engine.sh`)**: The foundation. Must be ultra-stable, low-resource, and focus on process orchestration.
2.  **Echo (`luna_predict.sh`)**: The cognitive layer. Uses Markov chains and frequency analysis for predictive workflows.
3.  **Tide (`luna_tui.sh`)**: The visual interface. ANSI-based, interactive, and high-density.

## 🖋 Coding Standards
- **Surgical Shell:** Prefer built-in bash features over external binaries where possible for speed.
- **Logging:** All daemon activity must be logged to `~/.luna/logs/`.
- **Aesthetics:** Use the Midnight Palette (Deep Blue: `#000510`, Silver: `#C0C0C0`, Amber: `#FFBF00`).
- **Safety:** Always use `trap` for cleanup in TUI and Engine scripts.

## 🚀 Workflow
- **Research:** Use `luna_echo --train` to refresh predictive weights.
- **Strategy:** New features should be prototyped in `src/` before being added to the TUI.
- **Execution:** Test all scripts in a clean environment before pushing to `main`.
