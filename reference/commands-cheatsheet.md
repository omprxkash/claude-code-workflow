# Command cheatsheet

A quick lookup of the commands and command-style prompts referenced across this
handbook. Built-ins change over time — `/help` (or `?`) is always the live list.
Full how-to: [../docs/02-customization/slash-commands.md](../docs/02-customization/slash-commands.md).

## Built-in (verify against `/help`)

| Command | What it does |
|---|---|
| `/help` or `?` | List commands and keyboard shortcuts |
| `/login` | Authenticate your Claude account |
| `/clear` | Wipe the conversation; start fresh (fights context rot) |
| `/compact` | Compress the conversation to reclaim context |
| `/init` | Generate a starter `CLAUDE.md` from the codebase |
| `/statusline` | Configure the status line |
| `/model` | Switch the model |

Keyboard: **Shift-Tab** cycles permission/plan modes; **Ctrl-C** twice exits.

## Custom / prompt-style commands

These are saved prompts (`.md` files in `.claude/commands/`), not built-ins. The ones
shipped in this repo are in [../templates/commands/](../templates/commands/); the
rest are common community patterns you can recreate the same way.

| Command | Purpose | In this repo? |
|---|---|---|
| `/human` | Rewrite text to read naturally, not like AI | ✅ [template](../templates/commands/human.md) |
| `/steel-man` ("Steel Man This") | Argue against your own idea to stress-test it | ✅ [template](../templates/commands/steel-man.md) |
| `/godmode` | Deep, structured research + analysis report | ✅ [template](../templates/commands/godmode.md) |
| `/content` | Turn one source into multiple content pieces | ✅ [template](../templates/commands/content.md) |
| `/ghost` | Humanize writing to pass as natural | pattern — make your own |
| `/artifact` | Build a live app/dashboard in-chat | pattern |
| `/insights` | Pull insights/analysis from material | pattern |
| `/EL10` | Explain like I'm 10 — simple, natural language | pattern |
| `/X10 THINK` | Push for much deeper reasoning | pattern |
| "Skill critique" | Honest critique instead of agreement | pattern |

> "Pattern" means it's just a saved prompt — write a `.md` file with the instruction
> and drop it in `.claude/commands/`. See
> [slash commands](../docs/02-customization/slash-commands.md).

## Related power features (not slash commands)

| Thing | What it is |
|---|---|
| `ultrathink` | Request deeper reasoning (terminal) |
| `@filename` | Tag a specific file as context in your prompt |
| plan mode | Read-only planning before edits (Shift-Tab to reach it) |
