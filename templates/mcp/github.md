# GitHub MCP server

Connects Claude to GitHub — issues, PRs, code search, and more. Uses GitHub's hosted
MCP endpoint with a personal access token in a Bearer header.

```bash
claude mcp add-json github '{
  "type": "http",
  "url": "https://api.githubcopilot.com/mcp",
  "headers": { "Authorization": "Bearer <YOUR_TOKEN>" }
}' --scope user
```

- Replace `<YOUR_TOKEN>` with a GitHub personal access token (`ghp_…`) that has the
  scopes you need.
- `--scope user` makes it available across all your projects (drop it for project-only).
- Official install guide is linked in
  [resources](../../reference/resources.md).

> The token is a live credential. Don't paste it into committed files, screenshots,
> or shared terminals. Rotate it if it ever leaks.
