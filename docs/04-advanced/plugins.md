# Plugins & marketplaces

Plugins package up Claude Code extensions — bundles of commands, skills, agents, hooks,
and MCP config — that you install from a marketplace once and get everywhere. Think of a
plugin as a pre-built version of the [skills](../02-customization/skills.md),
[slash commands](../02-customization/slash-commands.md), and
[subagents](../02-customization/subagents.md) you'd otherwise write yourself.

## When to reach for a plugin vs. rolling your own

- **Plugin** — a well-known capability someone has already solved (frontend design
  system, browser automation, a review workflow). Don't rebuild it.
- **Your own skill/command** — anything specific to *your* work, your APIs, your brand.
  That's where a [skill](../02-customization/skills.md) or
  [command](../02-customization/slash-commands.md) beats a generic plugin.

Prefer verified/official marketplaces. A plugin can add hooks and MCP servers that run
code, so treat an unknown source the way you'd treat any dependency.

## Installing

Two equivalent forms — the in-Claude slash command and the shell command. Add a
third-party marketplace first, then install from it.

```text
# Official Anthropic plugins (marketplace preloaded)
/plugin install frontend-design@claude-plugins-official
/plugin install code-review@claude-plugins-official
/plugin install code-simplifier@claude-plugins-official
/plugin install github@claude-plugins-official
/plugin install security-guidance@claude-plugins-official

# Third-party — add the marketplace, then install
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace

/plugin marketplace add upstash/context7
/plugin install context7-plugin@context7-marketplace

/plugin marketplace add lackeyjb/playwright-skill
/plugin install playwright-skill@playwright-skill
```

Same commands from a normal shell — drop the leading `/` and prefix with `claude`:

```bash
claude plugin install frontend-design@claude-plugins-official
claude plugin marketplace add obra/superpowers-marketplace
claude plugin install superpowers@superpowers-marketplace
claude plugin list   # verify
```

Installing at **user scope** makes a plugin available across all projects.

## A known-good starter set

Eleven plugins that work well together, by role:

| Plugin | Marketplace | Does |
|---|---|---|
| `frontend-design` | claude-plugins-official | Forces better visual/aesthetic output on UI work |
| `code-review` | claude-plugins-official | Structured review pass |
| `code-simplifier` | claude-plugins-official | Refactors for clarity (restart Claude Code after install — it doesn't live-load) |
| `github` | claude-plugins-official | GitHub PR/issue tooling |
| `security-guidance` | claude-plugins-official | Security review layer (adds to the built-in `/security-review`) |
| `superpowers` | obra/superpowers-marketplace | Opinionated workflow framework |
| `context7-plugin` | upstash/context7 | Live library-docs lookups |
| `playwright-skill` | lackeyjb/playwright-skill | Browser automation |
| `claude-mem` | thedotmack/claude-mem | Persistent memory |
| `ui-ux-pro-max` | nextlevelbuilder/ui-ux-pro-max-skill | Design-system reasoning for UI |
| `gstack` | local wrapper (see below) | Garry Tan's opinionated setup |

## Post-install one-time setup

- **playwright-skill** — in the skill folder run `npm run setup`, then
  `uv run --with playwright playwright install chromium` (~200MB) before first use.
- **code-simplifier** — restart Claude Code; the agent doesn't live-load.
- **gstack** — first session runs `hooks/scripts/ensure-setup.sh` to build the `browse`
  binary (Go required); ignore if you don't use `/browse`.

## Conflicts to expect

- `/security-review` is built into Claude Code already; `security-guidance` layers on
  top of it.
- `gstack` and `superpowers` are both opinionated workflow frameworks — running both can
  produce conflicting rules. Pick one as primary or selectively disable commands.
- `frontend-design` and `ui-ux-pro-max` both activate on UI prompts — complementary
  (aesthetic forcing vs. design-system reasoning) but expect overlap.

## Managing plugins

```bash
claude plugin list                      # show all installed
claude plugin disable <plugin>          # disable without uninstalling
claude plugin enable <plugin>
claude plugin uninstall <plugin>
claude plugin update <plugin>           # restart required after update
claude plugin marketplace list
claude plugin marketplace update <name>
```

## Edge case: a marketplace with no `marketplace.json`

Some repos ship a plugin but no `marketplace.json`, so `/plugin marketplace add owner/repo`
fails (gstack is the common example). Wrap it in a local marketplace:

1. Clone with submodules to a stable path:
   ```bash
   git clone --recurse-submodules https://github.com/Ahacad/gstack.git \
     ~/.claude/local-marketplaces/gstack-wrap
   ```
2. Add a `marketplace.json` next to the existing `plugin.json` at
   `.claude-plugin/marketplace.json`:
   ```json
   {
     "name": "gstack-local",
     "owner": { "name": "local-wrapper", "email": "local@local" },
     "metadata": { "description": "Local wrapper", "version": "1.0.0" },
     "plugins": [{
       "name": "gstack",
       "source": "./",
       "version": "0.1.0",
       "description": "Garry Tan's opinionated Claude Code setup",
       "homepage": "https://github.com/Ahacad/gstack",
       "repository": "https://github.com/Ahacad/gstack",
       "license": "MIT"
     }]
   }
   ```
3. Patch two upstream quirks in the clone if you hit them:
   - Remove `"hooks": "./hooks/hooks.json"` from `.claude-plugin/plugin.json` (Claude Code
     auto-loads `hooks/hooks.json`; the explicit reference triggers a "duplicate hooks
     file" error).
   - Wrap `hooks/hooks.json` contents in `{ "hooks": { ... } }` — the bare-array form
     fails schema validation.
4. Register and install:
   ```bash
   claude plugin marketplace add ~/.claude/local-marketplaces/gstack-wrap
   claude plugin install gstack@gstack-local
   ```

## Marketplaces & curated lists

See [resources](../../reference/resources.md) and
[MUST_LISTEN.md](../../MUST_LISTEN.md) for curated skill/plugin directories (Awesome
Claude Code, skills.sh, and more).
