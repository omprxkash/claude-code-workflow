# Where to run Claude Code

This is the question I get more than any other: *should I run it in the terminal,
the desktop app, VS Code, Antigravity, or on the web?* The honest answer is that
they're all the same engine wrapped in different interfaces — every surface below
calls the exact same Claude Code core. So pick based on how you like to work, not
on which one is "real."

There are five surfaces worth knowing.

## 1. Terminal (the foundation)

You open a terminal, type `claude`, and you're chatting with an agent that can read
and edit the folder you're in. Everything is text — no buttons, no panels.

- **Pros:** the most control and hackability; new features usually land here first;
  works alongside any editor (you can keep the GUI for reading and drop into the
  terminal for power); customizable status line; access to things like
  `ultrathink` that other surfaces hide.
- **Cons:** text-only, so it's harder to *see* what's happening with your files;
  steeper if you're not comfortable in a terminal.
- **Who it's for:** people who already live in the terminal. If the word "terminal"
  makes you nervous, use one of the surfaces below — but know this one exists,
  because it's the core everything else wraps.

To move between projects you `cd` into a folder, then run `claude`. Exit with
`Ctrl-C` twice.

## 2. Desktop app

A GUI-first experience with **Chat**, **Co-work**, and **Code** modes (and a little
animated mascot). Same engine, wrapped in buttons, panels, and visual feedback.

- **Pros:** approachable; no terminal required; clean visual feedback.
- **Cons:** less raw hackability than the terminal; slightly behind on the newest
  features.
- **Who it's for:** people who want a polished app and never want to touch a
  command line.

## 3. VS Code (extension)

VS Code is an IDE — really three things in one: a **file explorer**, a **text
editor**, and an **AI chat panel**. Install the official **Claude Code** extension
from Anthropic (the one with the verified check — be wary of look-alikes), then open
the panel from the top-right of the editor.

- **Pros:** see your files and Claude's edits side by side; huge extension
  ecosystem; you can also open a terminal *inside* VS Code for full power when you
  want it.
- **Cons:** more moving parts than a bare terminal.
- **Who it's for:** anyone who wants a visual file/diff view while still keeping the
  terminal a keystroke away. This is a great default for most people.

## 4. Antigravity

Antigravity is essentially VS Code's lineage taken further — it's built on the same
foundations, looks cleaner, and leans harder into AI. Because it's a Google product
it pushes Gemini by default, but you install the **Claude Code** extension the same
way and use Claude in it just like in VS Code.

- **Pros:** modern, clean UI; same three-pane model (files / editor / agent); extra
  AI niceties.
- **Cons:** some features are newer / more beta; Claude Code is an add-on rather
  than the default agent.
- **Who it's for:** people who like the VS Code workflow but want a more modern
  shell.

## 5. Claude Code on the web

Run sessions from the browser without a local install in front of you — useful for
kicking off or checking on work from anywhere, and for cloud-run sessions. Covered
more in [deployment](../05-deployment/deploy.md).

- **Pros:** access from anywhere; good for monitoring and lightweight tasks.
- **Cons:** not where you'll do deep local file work.
- **Who it's for:** people who want mobility and remote sessions.

## How to choose

| If you… | Use |
|---|---|
| Want maximum control and newest features | **Terminal** |
| Never want to see a command line | **Desktop app** |
| Want files + diffs beside the chat (good default) | **VS Code** |
| Want that, but a more modern shell | **Antigravity** |
| Want mobility / remote sessions | **Web** |

My own setup: I do most work in an IDE (files visible) with a terminal open inside
it for the moments I need raw control. You can mix freely — it's one engine.

## Next

Pick a surface and build something: [Your first project](first-project.md).
