# Subagent templates

These are real, working subagent definitions. Drop them into `.claude/agents/` in any project.

Each file has frontmatter (`name`, `model`, `tools`) that Claude Code uses to discover and invoke the agent. Full explanation: [../../docs/02-customization/subagents.md](../../docs/02-customization/subagents.md).

## Agents in this folder

| File | What it does |
|---|---|
| `code-reviewer.md` | Unbiased code review — returns issues by severity (high/medium/low) with a PASS/FAIL verdict |
| `research.md` | Deep research via web search and file reads — returns concise sourced findings without polluting parent context |
| `qa.md` | Generates and runs tests for a code snippet, reports pass/fail |
| `email-classifier.md` | Classifies Gmail emails into Action Required / Waiting On / Reference — used by the `gmail-label` skill with 10 parallel instances |

## How subagents work

The parent agent spawns a subagent with a task. The subagent runs in its **own context window** (no parent history), does its job, writes output to a file, and returns. The parent reads the result. This keeps the main session clean.

From the skills architecture CLAUDE.md:

> Subagents are lightweight agents (Sonnet 4.5) with self-contained contexts. They're cheaper, unbiased (no parent context leakage), and keep the parent context clean.
>
> **Important:** Subagents are read-only reporters. All code changes happen in the parent agent.

## Install

Copy any `.md` file here into `.claude/agents/` in your project (or `~/.claude/agents/` for personal use). Adjust the `model` and `tools` frontmatter fields if needed.
