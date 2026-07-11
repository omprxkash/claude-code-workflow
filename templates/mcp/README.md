# MCP setup snippets

Copy-paste commands for connecting MCP servers. **Every credential is a placeholder
(`<YOUR_TOKEN>` / `<YOUR_API_KEY>`) — replace it locally and never commit the real
value.** Full explanation:
[../../docs/03-mcp/setup-servers.md](../../docs/03-mcp/setup-servers.md).

## Files

- [`github.md`](github.md) — GitHub MCP server (issues, PRs, code search).
- [`firecrawl.md`](firecrawl.md) — Firecrawl web scraping/crawling.
- [`context7.md`](context7.md) — Context7 live library docs.

## Manage

- List connected servers: `claude mcp list`
- Remove one: `claude mcp remove <name>`

Keep the set lean — each connected server costs context every session. See
[MCP token cost](../../docs/03-mcp/token-usage-mcp.md).
