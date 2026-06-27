# Tokens & cost

> **Stub.** Outline below; full write-up to come.

What tokens are, how they relate to cost, and how to keep usage efficient without
babysitting it.

## To cover

- **What a token is** — chunks of text, roughly "words" for everyday reasoning; why
  the count is a bit higher than word count.
- **Where tokens go** — input (your messages, `CLAUDE.md`, files read, tool
  results) vs. output (Claude's responses).
- **The big cost drivers** — reading large files, verbose `CLAUDE.md`, long
  un-compacted sessions, and chatty MCP servers (see
  [MCP token cost](../03-mcp/token-usage-mcp.md)).
- **Subscription vs. API billing** — what the subscription covers and when limits
  bite; when API billing makes sense.
- **Strategies** — `/clear`, `/compact`, delegating to
  [subagents](../02-customization/subagents.md), reading only what's needed, and
  trimming `CLAUDE.md`.
- Cross-link: [context management](context-management.md) is the other half of this
  story.
