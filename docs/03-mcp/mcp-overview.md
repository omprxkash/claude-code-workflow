# MCP overview

MCP — the **Model Context Protocol** — is how Claude Code connects to the outside
world. Skills give the agent judgment; MCP gives it *reach*: a standard way to plug
in external services and data sources so the agent can act on them.

## What it is

MCP is a protocol for connecting an AI agent to **servers** that expose tools and
data. Each MCP server wraps some capability — a GitHub account, a web scraper, a
documentation index, a database — and presents it to Claude in a standard shape.
Once a server is connected, its tools show up as things Claude can call, the same as
its built-in tools.

The value: instead of you copy-pasting data in and out, the agent reaches the source
directly. Want it to open PRs, search a codebase on GitHub, scrape a site that has no
API, or pull current library docs? That's an MCP server away.

## How connections work

You add servers with the `claude mcp add` family of commands. There are a few
shapes:

- **Remote / HTTP servers** — hosted; you point Claude at a URL (often with an auth
  header or an API key baked into the URL).
- **Local servers** — run on your machine, usually launched by a command.

Scope matters: a server can be added for a single project or for your **user**
(available everywhere) via `--scope user`. Concrete setup commands for GitHub,
Firecrawl, and Context7 are on the next page:
[setting up servers](setup-servers.md).

## The cost to keep in mind

MCP servers aren't free in [context](../01-core-concepts/context-management.md).
Every connected server advertises its tools to the model, and that tool metadata
takes up space in the window — before you've called anything. A server that exposes
dozens of tools can quietly eat a meaningful chunk of context every session.

So the rule is: **connect the servers you're actually using, and disconnect the ones
you're not.** This is covered in [MCP token cost](token-usage-mcp.md).

## When to use MCP vs. other options

- Use **MCP** when you need the agent to interact with an external system
  repeatedly (GitHub, scraping, live docs, a database).
- Use a **skill** when you need better judgment on a sub-task, not external access.
- Use a one-off **script or tool** (as in the [WAT
  framework](../06-workflows/wat-framework.md)) when the integration is specific to
  one workflow and doesn't need to be a standing connection.

## Next

- [Setting up servers](setup-servers.md) — GitHub, Firecrawl, Context7, with commands.
- [MCP token cost](token-usage-mcp.md) — keeping connections lean.
