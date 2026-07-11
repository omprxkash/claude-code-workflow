# GitHub Actions integration

Tag `@claude` in an issue or PR comment and it reads the request, writes the fix,
and opens a pull request — all inside your CI, no one at a keyboard. This is
[headless mode](headless-and-sdk.md) wired directly into GitHub's event system.

## Quick setup

From inside a Claude Code session in your repo:

```
/install-github-app
```

This installs the Claude GitHub App on the repository, adds the GitHub Actions
workflow file, and walks you through adding your API key as a repo secret. This is
the path to use unless you have a reason to do it by hand.

## Manual setup

1. Install the Claude GitHub App: https://github.com/apps/claude — it requests
   Read & Write access to Contents, Issues, and Pull Requests.
2. Add `ANTHROPIC_API_KEY` to the repo's secrets: **Settings → Secrets and
   variables → Actions**.
3. Copy the example workflow into `.github/workflows/` from
   [anthropics/claude-code-action](https://github.com/anthropics/claude-code-action).
4. Test it: tag `@claude` in an issue or PR comment.

## What triggers it

The action activates on:
- **`@claude` mentions** in issue or PR comments
- **Issue assignment** to the Claude GitHub App
- **Explicit automation prompts** you define in the workflow YAML (e.g., run on
  every PR open, regardless of mentions)

## What it can do once triggered

- Read the issue/PR, understand the request, implement it, and open a PR
- Review a diff and post inline comments (pairs with
  [`/code-review`](../../reference/commands-cheatsheet.md) patterns you'd use
  locally)
- Run with restricted tool access via the same `allowedTools` mechanism as
  [headless mode](headless-and-sdk.md) — scope what CI-triggered runs are allowed
  to touch

## Authentication options

Beyond a direct Anthropic API key, the action supports Amazon Bedrock, Google
Vertex AI, and Microsoft Foundry — useful if your org's compliance requirements
mean API traffic has to go through an existing cloud vendor relationship rather
than directly to Anthropic.

## Governing behavior with CLAUDE.md

The action reads the repo's `CLAUDE.md` the same way an interactive session does —
your commands, conventions, and "never do X" rules apply automatically to
CI-triggered runs too. There's no separate config language to learn; if it's true
for your local sessions, it's true here.

## Reference

- Official docs: https://code.claude.com/docs/en/github-actions
- Action source: https://github.com/anthropics/claude-code-action

## Next

- [Headless mode & the Agent SDK](headless-and-sdk.md) — the underlying mechanism
- [Deployment](../05-deployment/deploy.md) — hosting the code this action produces
