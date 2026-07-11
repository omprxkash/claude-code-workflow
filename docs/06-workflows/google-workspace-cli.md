# Google Workspace from Claude Code (GWS CLI)

Give Claude direct control of Gmail, Docs, Drive, Sheets, and Slides through a lightweight CLI instead of a heavy MCP server. GWS exposes 100+ multi-step Google Workspace recipes as pure bash commands — no MCP JSON payloads eating your context window.

<!-- source: see MUST_LISTEN.md -->

## Why CLI over MCP here

MCP servers inject their full tool descriptions into every conversation — for a suite as big as Google Workspace that's a serious token tax whether you use the tools or not. A CLI costs nothing until Claude actually runs a command, and Claude is already good at bash.

## Setup

1. **Install** — give Claude the GWS CLI GitHub repo URL and tell it to install the tool.
2. **Google Cloud Console** — create a project, configure the OAuth consent screen, and create a **Desktop App** OAuth Client ID.
3. **Credentials** — download the credentials JSON and place it in `~/.config/gws/`.
4. **Authenticate** — have Claude run:
   ```
   gws auth login
   ```
   and complete the flow in your browser.
5. **Enable APIs** — in Google Cloud Console, enable the APIs you'll use: Drive, Docs, Gmail, Sheets, Slides.

Keep the credentials JSON out of git — add it to `.gitignore` alongside `.env`.

## What it unlocks

Once authenticated, Claude can chain Workspace operations in plain bash. Two working examples:

**Generate a live Google Doc from a video.** Ask Claude to build a resource guide from a YouTube video: it fetches the transcript, structures the content, then programmatically creates and formats a real Google Doc in your Drive — headings, lists, formatting, done.

**Inbox zero pass.** Ask Claude to triage your inbox: it reads the unread emails, scores each one's priority against your business context (from your CLAUDE.md or context files), and marks the low-priority ones as read — leaving only what actually needs you.

## Pattern to reuse

This is the general "CLI beats MCP" pattern, worth applying beyond Google:

1. Find (or ask Claude to write) a CLI wrapper for the service.
2. Authenticate once, store credentials outside the repo.
3. Describe *when* to use which command in your CLAUDE.md or a skill file.
4. Claude composes the commands itself — multi-step workflows fall out for free.

Related: [context-management.md](../01-core-concepts/context-management.md) covers the MCP token-overhead problem in depth.
