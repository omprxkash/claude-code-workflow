# Command templates

Drop any of these `.md` files into `.claude/commands/` in a project (shared) or
`~/.claude/commands/` (available everywhere), then invoke with `/<filename>`. Full
explanation: [../../docs/02-customization/slash-commands.md](../../docs/02-customization/slash-commands.md).

Each file is just a saved prompt with optional frontmatter. Edit them to taste.

## In this folder

- [`human.md`](human.md) — `/human`: rewrite text so it reads naturally, not like AI.
- [`steel-man.md`](steel-man.md) — `/steel-man`: argue against your own idea to
  stress-test it.
- [`godmode.md`](godmode.md) — `/godmode`: deep, structured research + analysis pass.
- [`content.md`](content.md) — `/content`: turn one source into multiple content
  pieces.

These mirror the kinds of "prompt commands" people share (`/human`, `/ghost`,
`/godmode`, `/EL10`, "Steel Man This", etc.). See the
[command cheatsheet](../../reference/commands-cheatsheet.md) for the full list.
