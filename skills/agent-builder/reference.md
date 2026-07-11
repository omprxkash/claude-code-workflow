# Agent Builder Reference

Technical reference for Claude Code sub-agent configuration. This file is for Claude's internal use when making configuration decisions. Do not expose raw field names or technical jargon to the user.

Source: https://code.claude.com/docs/en/sub-agents

---

## Frontmatter Field Reference

All fields except `name` and `description` are optional.

| Field | Required | Type | Default | Valid Values |
|-------|----------|------|---------|--------------|
| `name` | Yes | string | -- | Lowercase letters and hyphens. Must match filename (minus .md). |
| `description` | Yes | string | -- | What the agent does and when Claude should delegate to it. Primary triggering mechanism. |
| `tools` | No | comma-separated string | inherits all | Any Claude Code internal tool: Read, Write, Edit, Bash, Grep, Glob, WebFetch, WebSearch, Agent, Agent(type), plus MCP tool names |
| `disallowedTools` | No | comma-separated string | none | Tools to remove from the inherited or specified list |
| `model` | No | string | `inherit` | `sonnet`, `opus`, `haiku`, `inherit` |
| `permissionMode` | No | string | `default` | `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, `plan` |
| `maxTurns` | No | integer | unlimited | Any positive integer. Caps how many agentic turns before the agent stops. |
| `skills` | No | list | none | Skill names to preload into the agent's context at startup. Full skill content is injected. Agents do NOT inherit skills from the parent conversation. |
| `mcpServers` | No | list or object | none | Either a server name referencing an already-configured server (e.g., `"slack"`) or an inline definition with server name as key and full MCP config as value |
| `hooks` | No | object | none | Lifecycle hooks scoped to this agent. See Hooks section below. |
| `memory` | No | string | none | `user`, `project`, or `local`. Enables persistent memory directory across sessions. |
| `background` | No | boolean | `false` | `true` to always run as a background task |
| `isolation` | No | string | none | `worktree` to run in a temporary git worktree (isolated repo copy, auto-cleaned if no changes) |
| `color` | No | string | none | Background color for visual identification in the UI |

---

## Field Details

### description

The description is the primary mechanism Claude uses to decide when to delegate to an agent. Write it as if you're telling Claude "use this agent when...".

Tips for effective descriptions:
- Be specific about trigger contexts, not just what the agent does
- Include "use proactively" if the agent should be used automatically
- Claude tends to "undertrigger" -- descriptions should be slightly pushy
- Include example user prompts and Claude responses for complex trigger patterns

### tools

Controls what the agent can do. Two approaches:

**Allowlist (tools):** Only these tools are available.
```yaml
tools: Read, Grep, Glob, Bash
```

**Denylist (disallowedTools):** Start with all tools, remove specific ones.
```yaml
disallowedTools: Write, Edit
```

If `tools` is omitted entirely, the agent inherits all tools from the main conversation including MCP tools.

**Agent spawning restrictions (main-thread agents only):**
```yaml
# Allow spawning only specific agent types
tools: Agent(worker, researcher), Read, Bash

# Allow spawning any agent type
tools: Agent, Read, Bash

# Omitting Agent entirely = cannot spawn any agents
tools: Read, Bash
```
Note: `Agent(type)` restrictions only apply to agents running as the main thread via `claude --agent`. Regular subagents cannot spawn other subagents regardless of this setting.

### model

| Value | When to Use |
|-------|-------------|
| `haiku` | Read-only analysis, code search, simple lookups. Fast and cheap. |
| `sonnet` | Most tasks. Good balance of capability, speed, and cost. |
| `opus` | Complex reasoning, nuanced analysis, creative work. Slowest and most expensive. |
| `inherit` | Use whatever model the main conversation is running. Default if omitted. |

### permissionMode

| Mode | Behavior | When to Use |
|------|----------|-------------|
| `default` | Standard permission checking with prompts | Most agents. User gets asked before risky operations. |
| `acceptEdits` | Auto-accept file edits (Write/Edit) | Agents whose primary job is generating or modifying files. |
| `dontAsk` | Auto-deny all permission prompts | Strictly sandboxed agents. Explicitly allowed tools still work. |
| `bypassPermissions` | Skip ALL permission checks | Dangerous. Almost never appropriate. |
| `plan` | Read-only exploration mode | Research agents that should never modify anything. |

Important: If the parent conversation uses `bypassPermissions`, that takes precedence and cannot be overridden by the subagent.

### maxTurns

Guidelines based on task complexity:
- **5-10 turns**: Simple, focused tasks (content planning, single-step lookups)
- **10-15 turns**: Moderate tasks (data fetching, script execution, structured analysis)
- **15-20 turns**: Complex research (multi-source web research, API scraping with fallbacks)
- **20-25 turns**: Deep multi-step work (intelligence gathering, comprehensive audits)

If not set, the agent runs until it finishes or hits context limits. Setting maxTurns prevents runaway agents.

### memory

Gives the agent a persistent directory that survives across conversations.

| Scope | Directory | When to Use |
|-------|-----------|-------------|
| `user` | `~/.claude/agent-memory/<name>/` | Cross-project knowledge. Recommended default per docs. |
| `project` | `.claude/agent-memory/<name>/` | Project-specific, shareable via version control. |
| `local` | `.claude/agent-memory-local/<name>/` | Project-specific, NOT version controlled. Personal preferences. |

When memory is enabled:
- System prompt includes instructions for reading/writing to the memory directory
- First 200 lines of `MEMORY.md` in the memory directory are auto-loaded into context
- Read, Write, and Edit tools are automatically enabled (even if not in `tools` list)
- Agent should include memory instructions in its body

Memory instruction template to include in agent body:
```markdown
**Update your agent memory** as you discover [relevant patterns]. This builds up
institutional knowledge across conversations. Write concise notes about what you
found and where.

Examples of what to record:
- [domain-specific patterns]
- [recurring issues and solutions]
- [preferences and conventions]
```

### hooks

Lifecycle hooks that run while the agent is active. Cleaned up when agent finishes.

**In agent frontmatter:**

| Event | Matcher Input | When It Fires |
|-------|---------------|---------------|
| `PreToolUse` | Tool name | Before the agent uses a tool |
| `PostToolUse` | Tool name | After the agent uses a tool |
| `Stop` | (none) | When the agent finishes (converted to SubagentStop at runtime) |

Example (validate Bash commands):
```yaml
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate-command.sh"
  PostToolUse:
    - matcher: "Edit|Write"
      hooks:
        - type: command
          command: "./scripts/run-linter.sh"
```

Hook commands receive JSON input via stdin. Exit code 0 = allow, exit code 2 = block.

**In settings.json (project-level):**

| Event | Matcher Input | When It Fires |
|-------|---------------|---------------|
| `SubagentStart` | Agent type name | When a subagent begins execution |
| `SubagentStop` | Agent type name | When a subagent completes |

### skills (preloading)

Injects full skill content into the agent's context at startup.

```yaml
skills:
  - api-conventions
  - error-handling-patterns
```

Important distinctions:
- Agents do NOT inherit skills from the parent conversation -- you must list them explicitly
- The full skill content is injected, not just made available for invocation
- This is the inverse of `context: fork` in skills. With `skills` in an agent, the agent controls the system prompt. With `context: fork` in a skill, the skill content becomes the task prompt.

### mcpServers

Two configuration patterns:

**Named reference** (server already configured in settings):
```yaml
mcpServers:
  - slack
  - github
```

**Inline definition:**
```yaml
mcpServers:
  my-server:
    command: node
    args: ["./mcp-server.js"]
```

### background

When `true`, the agent always runs as a background task:
- Main conversation continues while agent works
- Before launching, Claude prompts for any tool permissions the agent will need
- Once running, the agent auto-denies anything not pre-approved
- If the agent needs to ask clarifying questions, that fails but the agent continues
- If it fails due to missing permissions, you can resume it in the foreground

### isolation

When set to `worktree`:
- Agent runs in a temporary git worktree (isolated copy of the repo)
- Worktree is automatically cleaned up if the agent makes no changes
- Useful for agents that need to experiment with code without affecting the main working tree

---

## Agent Scope & Priority

| Location | Scope | Priority |
|----------|-------|----------|
| `--agents` CLI flag | Current session only | 1 (highest) |
| `.claude/agents/` | Current project | 2 |
| `~/.claude/agents/` | All projects | 3 |
| Plugin `agents/` directory | Where plugin is enabled | 4 (lowest) |

When multiple agents share the same name, higher-priority location wins.

---

## Common Gotchas

1. **Agents don't inherit skills from parent** -- Must list explicitly in `skills` field
2. **Subagents can't spawn other subagents** -- `Agent(type)` in tools has no effect in subagent definitions
3. **Session restart needed** -- Manually added agent files require restart or `/agents` to load
4. **bypassPermissions cascades** -- If parent uses it, subagent can't override to a more restrictive mode
5. **Memory auto-enables tools** -- Setting `memory` automatically enables Read, Write, Edit even if not in `tools` list
6. **Subagents get minimal context** -- They receive only their system prompt + basic environment details, NOT the full Claude Code system prompt or conversation history
7. **Tools field formats** -- In YAML frontmatter, tools are comma-separated strings. In `--agents` JSON, tools are arrays.

---

## Agent vs Skill Decision Framework

| Factor | Build an Agent | Build a Skill |
|--------|---------------|---------------|
| Model | Can run on cheaper/faster model | Inherits main conversation model |
| Context | Isolated (no conversation history) | Runs in main conversation context |
| Reuse | Called by multiple skills or workflows | Triggered by user or Claude directly |
| Output | Verbose intermediate output (stays isolated) | Output visible in main conversation |
| Memory | Can have persistent memory across sessions | No built-in memory |
| User interaction | Cannot ask clarifying questions (in background) | Full back-and-forth with user |
| Nesting | Cannot spawn other subagents | Can delegate to agents via `context: fork` |

---

## Disabling Agents

**In settings.json:**
```json
{
  "permissions": {
    "deny": ["Agent(Explore)", "Agent(my-custom-agent)"]
  }
}
```

**Via CLI:**
```bash
claude --disallowedTools "Agent(Explore)"
```

---

## Related Documentation

- **Sub-agents docs:** https://code.claude.com/docs/en/sub-agents
- **Skills docs:** https://code.claude.com/docs/en/skills
- **Hooks docs:** https://code.claude.com/docs/en/hooks
- **MCP docs:** https://code.claude.com/docs/en/mcp
- **Permissions docs:** https://code.claude.com/docs/en/permissions
