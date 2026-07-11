# Install & setup

Getting Claude Code running takes about five minutes. The only thing you actually
pay for is a Claude subscription — everything else is free.

## You need a paid plan

Claude Code isn't on the free tier. You need at least:

- **Pro** — the sensible starting point if you're new.
- **Max** — if you keep hitting limits (you probably will once it clicks). Most
  heavy users end up here, and the return on it is large relative to the cost.
- **Team / Enterprise** — for organizations.

Pick Pro to start. You can upgrade the moment the limits annoy you.

## Install

The official install is one command. Open a terminal (on Windows that's
PowerShell or Command Prompt; on macOS/Linux it's Terminal) and run the command
from the docs for your platform — the canonical source is **code.claude.com/docs**,
which always has the current command for macOS, Linux, WSL, Windows PowerShell, and
Windows CMD.

The docs are the source of truth here on purpose: the install command and flags
change often enough that pinning an exact string in a handbook would just rot.
Grab it fresh from the quickstart.

After it finishes, confirm it's there:

```bash
claude --version
```

## Log in

First launch will prompt you to authenticate. If it doesn't, run:

```bash
claude
/login
```

You'll be asked whether to use your Claude subscription or API billing through a
console account. For everyday use, choose the **subscription** option — it's the
cheapest and most straightforward path, and it's what the rest of this handbook
assumes.

Once you're authenticated you're done. Type `claude` in any project folder and you
have an agent that can read and edit the files in that folder.

## Data and training

Whether Anthropic can train on your conversations is a **toggle you control**, not
a fixed policy — check Settings → Privacy → "Help improve Claude." This has been a
forced choice (you must pick on or off) since a policy change in late 2026, and
consumer plans (Free/Pro/Max) and Team/Enterprise plans can default differently, so
don't assume — check it yourself, especially before using Claude Code on anything
you wouldn't want to leave your machine. Turning training off doesn't mean Anthropic
doesn't retain the data at all (see their current privacy policy for retention
specifics) — it only controls the training use. If you or your org handle sensitive
client data, contracts, or PII, verify what your organization's policy actually
permits before feeding documents into any cloud-hosted model, Claude included.

## A mental model before you go further

Claude Code is running **locally on your machine**, inside whatever folder you
launched it in. That's the whole point: it's not a chatbot in a distant server, it
can actually touch your files, run scripts, and do real work on your computer. That
power is also why [permission modes](../01-core-concepts/permission-modes.md)
matter — we'll get to those.

## Next

You're installed. Now decide *where* you want to run it day to day — terminal, a
desktop app, an IDE, or the web. That's the next page:
[Where to run it](where-to-run.md).
