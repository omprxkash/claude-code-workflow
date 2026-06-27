# Setting up MCP servers

Concrete setup for the servers I reach for most. Every credential below is a
placeholder — replace `<YOUR_TOKEN>` / `<YOUR_API_KEY>` with your own, and **never
commit the real value**. Keep keys in `.env` (already in `.gitignore`) or paste them
straight into the command locally.

Copy-paste versions of these also live in
[`templates/mcp/`](../../templates/mcp/).

## GitHub (remote HTTP server)

Connects Claude to GitHub — issues, PRs, code search, and more. GitHub provides a
hosted MCP endpoint; you authenticate with a personal access token passed as a
Bearer header.

```bash
claude mcp add-json github '{
  "type": "http",
  "url": "https://api.githubcopilot.com/mcp",
  "headers": { "Authorization": "Bearer <YOUR_TOKEN>" }
}' --scope user
```

- Generate a GitHub personal access token (`ghp_…`) with the scopes you need.
- `--scope user` makes it available across all your projects.
- The official install guide is linked in [resources](../../reference/resources.md).

> Security: a token in a Bearer header is a live credential. Don't paste it into
> files you might commit, screenshots, or shared terminals. Rotate it if it leaks.

## Firecrawl (web scraping / crawling)

Lets the agent scrape and crawl sites — handy for pulling data from sources without
a clean API. Firecrawl offers a hosted MCP server; the API key goes in the URL.

```bash
claude mcp add firecrawl --url https://mcp.firecrawl.dev/<YOUR_API_KEY>/v2/mcp
```

## Context7 (live library docs)

Context7 serves current documentation for libraries and frameworks, so the agent
isn't guessing from stale training data. Add it like any other MCP server (consult
the Context7 docs for the exact endpoint/command, since it evolves), then ask Claude
to pull docs for a library when you're integrating it.

## trigger.dev (scheduled tasks)

trigger.dev lets you run scheduled or event-driven tasks from Claude. The MCP server
runs locally via `npx`. Add it to `.mcp.json` in your project root:

```json
{
  "mcpServers": {
    "trigger": {
      "command": "npx",
      "args": ["trigger.dev@4.4.0", "mcp"]
    }
  }
}
```

Or add it via CLI:

```bash
claude mcp add-json trigger '{"command": "npx", "args": ["trigger.dev@4.4.0", "mcp"]}' --scope project
```

This creates a `.mcp.json` at the project level (which you can commit — it has no credentials).

## Managing servers

- **List** what's connected: `claude mcp list`
- **Remove** one you're not using: `claude mcp remove <name>`
- Keep the set lean — every connected server costs context. See
  [MCP token cost](token-usage-mcp.md).

## Next

- [MCP token cost](token-usage-mcp.md)
- [MCP overview](mcp-overview.md) if you skipped the concept.
