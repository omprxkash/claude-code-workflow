# Context7 MCP server

Serves current documentation for libraries and frameworks so the agent isn't relying
on stale training data. Add it like any other MCP server, then ask Claude to pull
docs for a library when you're integrating it.

```bash
# Check the Context7 docs for the current endpoint/command, then add it, e.g.:
claude mcp add context7 --url https://<CONTEXT7_ENDPOINT> --scope user
```

- The exact endpoint/command evolves — confirm it against the Context7 docs
  (linked in [resources](../../reference/resources.md)).
- Some setups require an API key; if so, keep it out of committed files.

Usage: when integrating a library, ask Claude to "pull the latest docs for
<library>" and it will query Context7 instead of guessing.
