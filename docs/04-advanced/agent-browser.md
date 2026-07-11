# agent-browser

[agent-browser](https://github.com/vercel-labs/agent-browser) is a fast, native browser
automation CLI built specifically for AI agents. It uses a client-daemon architecture
and deterministic element refs so agents can interact with pages reliably without
writing Playwright or Puppeteer boilerplate.

Install as a Claude Code skill and it stays in sync with the CLI version automatically.

---

## Install

**Global CLI:**
```bash
npm install -g agent-browser
agent-browser install   # downloads Chrome for Testing
```

**As a Claude Code skill (recommended):**
```bash
npx skills add vercel-labs/agent-browser
```

This wires up the skill so Claude Code knows the full command surface and it auto-updates.

**Add to `AGENTS.md` or your CLAUDE.md:**
```
Use agent-browser for web automation. Run agent-browser --help for commands.
Workflow: open URL → snapshot -i → identify refs → interact → re-snapshot.
```

---

## Core commands

**Navigate & interact:**
```bash
agent-browser open <url>          # launch and navigate
agent-browser snapshot            # get accessibility tree with element refs
agent-browser snapshot -i --json  # interactive elements only, machine-readable
agent-browser click @e1           # click by ref
agent-browser fill @e2 "text"     # fill input by ref
agent-browser screenshot          # capture page
```

**Extract information:**
```bash
agent-browser get text @e1        # text content of an element
agent-browser get url             # current page URL
agent-browser read <url>          # fetch agent-readable markdown of a page
```

**Advanced:**
```bash
agent-browser wait <selector>          # wait for element or condition
agent-browser network route <url>      # intercept / mock requests
agent-browser eval <js>                # run JavaScript on the page
agent-browser batch                    # multiple commands in one invocation (avoids per-command startup cost)
agent-browser chat "do X"             # natural language control (needs AI_GATEWAY_API_KEY)
agent-browser --session <name>         # isolate this browser instance from others
```

---

## How agents should use it

The recommended loop:

1. `agent-browser open <url>`
2. `agent-browser snapshot -i --json` — get interactive elements with stable refs (`@e1`, `@e2`, ...)
3. Agent reads snapshot, identifies target refs, runs the action (`click`, `fill`, etc.)
4. Re-snapshot after each page change to refresh the ref map

Refs are deterministic from a given snapshot — `@e1` won't drift between runs if the
page structure hasn't changed. Always re-snapshot after navigation or significant DOM changes.

---

## Configuration

Create `agent-browser.json` at project root:
```json
{
  "$schema": "https://agent-browser.dev/schema.json",
  "headed": false,
  "profile": "./browser-data"
}
```

CLI flags override config; env vars override config too. For safe public deployments:
configure domain allowlists and action policies in the config file.

---

## Cloud execution

Instead of running Chrome locally, route to a cloud provider:
- **Browserbase** — managed sessions with recording
- **Browserless** — self-hostable headless Chrome
- **Browser Use** — AI-native browser sessions
- **Kernel** — serverless browser execution

Useful when running agent-browser inside a Claude Code headless pipeline or GitHub
Actions where there's no local display.

---

## Pairs with

- [Parallelization](parallelization.md) — run multiple browser sessions in parallel via `--session` flags
- [WAT framework](../06-workflows/wat-framework.md) — agent-browser is a natural WAT tool layer
- [Headless mode & Agent SDK](headless-and-sdk.md) — for fully automated, no-UI pipelines
