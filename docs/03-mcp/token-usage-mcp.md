# MCP token cost

Connected MCP servers cost [context](../01-core-concepts/context-management.md)
before you call a single tool, because each one advertises its tools to the model.
This page is about keeping that cost in check.

## Why idle servers cost tokens

Every connected server's tool definitions load into the context window on every
message, whether you use them or not — that's pure overhead sitting there before
you've typed anything. The
[18 ranked hacks](../01-core-concepts/context-management.md#token-management--18-ranked-hacks)
page has the concrete numbers: a single large MCP server (ClickUp, Gmail, Notion)
can run 15,000-20,000+ tokens of tool descriptions per message, and one connected
server can add 18,000+ tokens even before you've called anything.

## Automatic tool search (when this gets handled for you)

Claude Code has a built-in mitigation: when connected MCP tool descriptions exceed
roughly **10% of the context window**, it stops loading every tool description
up front and instead *searches* for the relevant tool on demand (using its own
built-in search over the available tool list) only when a request looks like it
needs one. This caps the worst-case overhead automatically — but it's a safety net,
not a reason to stop being deliberate about which servers you connect. Fewer,
purpose-fit servers still beat relying on search-on-demand across a pile of
oversized ones.

## The discipline

- **Connect only what you're using.** Audit with `claude mcp list`; remove what's
  idle with `claude mcp remove`.
- **Prefer per-project scope** (the default) over `--scope user` (global,
  every project) unless a server genuinely belongs everywhere.
- **When a one-off script or CLI beats a standing MCP connection:** if you only
  need 2-3 endpoints out of a server's 50, a direct API call in a
  [WAT tool](../06-workflows/wat-framework.md) or [skill](../02-customization/skills.md)
  costs a fraction of the full server — see the
  [MCP → Skill migration pattern](../01-core-concepts/context-management.md#the-mcp--skill-migration-pattern)
  for the concrete before/after.

## Next

- [Context management](../01-core-concepts/context-management.md) — the full token-hygiene playbook, MCP overhead is one piece of it
- [MCP overview](mcp-overview.md) — what MCP is and when to reach for it at all
- [Setting up servers](setup-servers.md) — concrete connection commands
