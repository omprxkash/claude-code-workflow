# Parallelization

> **Stub.** Outline below; full write-up to come.

Getting many hours of work done in a fraction of the time by running work in
parallel — across multiple Claude Code instances and across
[subagents](../02-customization/subagents.md).

## To cover

- Two flavors of parallelism: multiple full sessions (often via
  [worktrees](worktrees.md)) vs. subagent fan-out inside one session.
- When to parallelize and when it just adds chaos.
- Coordinating outputs and merging results.
- Context and cost implications of running many agents at once.
- Relationship to [agent teams](../02-customization/agent-teams.md).
