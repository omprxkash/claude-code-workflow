# MCP token cost

> **Stub.** Outline below; full write-up to come.

Connected MCP servers cost [context](../01-core-concepts/context-management.md)
before you call a single tool, because each one advertises its tools to the model.
This page is about keeping that cost in check.

## To cover

- *Why* idle servers cost tokens: tool definitions live in the context window.
- How to estimate the footprint of a server (number of tools × metadata size).
- The discipline: connect only what you're using; `claude mcp remove` the rest;
  prefer per-project scope when a server isn't needed everywhere.
- When a one-off [WAT tool](../06-workflows/wat-framework.md) or script beats a
  standing MCP connection.
- Auditing connected servers with `claude mcp list`.
