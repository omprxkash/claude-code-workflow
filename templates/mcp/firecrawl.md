# Firecrawl MCP server

Lets the agent scrape and crawl websites — useful for pulling data from sources that
don't expose a clean API. Hosted MCP server; the API key goes in the URL.

```bash
claude mcp add firecrawl --url https://mcp.firecrawl.dev/<YOUR_API_KEY>/v2/mcp
```

- Replace `<YOUR_API_KEY>` with your Firecrawl key.
- Add `--scope user` to make it available across all projects.

> The key is embedded in the URL, so treat the whole command as a secret. Don't
> commit it.
