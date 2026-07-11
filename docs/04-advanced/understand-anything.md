# Understand Anything

[Understand Anything](https://github.com/Egonex-AI/Understand-Anything) turns any
codebase into an interactive knowledge graph — every file, function, class, and
dependency parsed and linked. You explore it visually, search it semantically, and query
it in natural language.

Most useful before writing a CLAUDE.md for an unfamiliar large repo, or when onboarding
a Claude Code agent into a project it's never seen.

---

## Install

```bash
/plugin marketplace add Egonex-AI/Understand-Anything
/plugin install understand-anything
```

---

## Commands

| Command | What it does |
|---|---|
| `/understand` | Parses the project, builds the knowledge graph |
| `/understand-dashboard` | Opens an interactive web visualization |
| `/understand-chat` | Natural language queries against the codebase |
| `/understand-diff` | Shows which components the current changes affect |
| `/understand-explain` | Deep-dive into a specific file or function |
| `/understand-onboard` | Generates an onboarding guide for the project |
| `/understand-domain` | Extracts business domains and workflows |
| `/understand-knowledge` | Processes wiki-style documentation (Karpathy-pattern) |

Supports `--language` flag for localized output: English, Chinese, Japanese, Korean, Russian.

---

## What the knowledge graph gives you

- **Guided tours** — auto-generated architecture walkthroughs ordered by dependency
- **Fuzzy + semantic search** — find by exact name or by meaning across the whole codebase
- **Diff impact analysis** — before touching something, see what else it affects
- **Layer visualization** — automatic grouping by architectural tier (API, Service, Data, UI, Utility)
- **Pattern explanations** — 12 code patterns explained in context (generics, closures, decorators, etc.)

---

## How it works internally

Six specialized agents run in sequence:

1. **project-scanner** — discovers all files and structure
2. **file-analyzer** — parses each file with tree-sitter (deterministic, language-aware)
3. **architecture-analyzer** — infers layers and dependencies
4. **tour-builder** — generates the guided walkthrough
5. **graph-reviewer** — validates and cleans the graph
6. **domain-analyzer** — extracts business domains and workflows

The result is `.understand-anything/knowledge-graph.json` — commit this so teammates
skip the full pipeline on their first run. Exclude `intermediate/` and `diff-overlay.json`.

For very large graphs, track `knowledge-graph.json` with git-lfs.

---

## Practical workflow

**Before writing a CLAUDE.md for an unfamiliar codebase:**
```
/understand              # build the graph
/understand-dashboard    # explore the architecture visually
/understand-domain       # understand what the system actually does
/understand-onboard      # generate a structured onboarding doc
```

Then use the onboarding doc and domain map as input when writing the CLAUDE.md — it'll
be significantly more accurate than reading files manually.

**Before making a large change:**
```
/understand-diff         # see what the proposed change actually touches
```

Catches unintended blast radius before Claude Code starts editing.

---

## Pairs with

- [Context management](../01-core-concepts/context-management.md) — understanding the codebase structure helps you write a leaner CLAUDE.md
- [Worktrees](worktrees.md) — run `/understand` per worktree branch to track architectural drift
- [Multi-agent patterns](multi-agent-patterns.md) — use domain extraction to scope individual agents to specific layers
