# Permission modes

Because Claude Code runs locally and can change real files, it has modes that
control how much it asks before acting.

## The modes

- **Plan mode** — read-only; researches and proposes a plan you approve before any
  edits happen. The safest place to start a non-trivial task. (See
  [first project](../00-getting-started/first-project.md).)
- **Manual permissions** — prompts you before each individual action (file edit,
  bash command, etc.). Most conservative; slowest.
- **Accept edits (auto-accept)** — applies file edits without prompting, but still
  stops for riskier actions outside plain edits.
- **Auto mode** — the current default for most sessions. Handles the everyday flow
  without constant prompting while still holding back on genuinely risky actions.
  For the large majority of work, this is the mode to just leave on.
- **Bypass permissions ("dangerously skip permissions")** — no prompts at all,
  for anything. Maximum flow, maximum trust required. If it's not visible in your
  mode list, enable it in Settings → Claude Code → "Allow bypass permissions mode."

Cycle between modes with **Shift-Tab**; the current mode shows as a visual indicator
near the prompt. You can interrupt a run mid-execution to pause and redirect it
rather than letting it finish down a path you don't like.

## The real risk isn't the mode — it's what the agent can reach

Permission modes control *how often you're asked*. They don't control *what the
agent is capable of doing* once it's allowed to act — that's a function of which
tools and credentials it has access to, independent of mode. An agent on bypass
mode with only read access to a CRM can't do damage; an agent on manual-approval
mode that's connected to a mailer with full send/delete access is one misclick from
a real incident. Horror stories about agents deleting databases or blasting emails
to entire lists are almost always a scope problem, not a permission-mode problem —
the agent had a tool it never needed for the task at hand.

**The mental model:** treat every tool and credential you hand an agent the way
you'd treat handing a new hire a credit card. You wouldn't give a new hire full
spending authority just because you trust them generally — you'd scope the card to
what their job actually requires. Same logic here.

### Scoping third-party API keys

Most third-party tools let you scope an API key beyond just "full access": limiting
which endpoints/capabilities it can hit, and capping how much it can spend or do.
When you connect Claude Code to something with real write/delete/send power, create
a key scoped to only what the task needs — e.g. a key that can only trigger one
specific capability, with a spend cap, rather than a key with blanket account
access. Name keys specifically (`demo-sound-effects`, not `main-key`) so you can
tell at a glance which agent or workflow is using which key, and audit usage per
key later.

### Locking down bypass mode with settings.json

You can run on bypass permissions comfortably if the project's `settings.json`
already denies the genuinely destructive actions at the tool level — deletions,
force-pushes, writes outside the project directory, whatever you'd never want to
happen unattended. Describe the constraints in plain language ("never let this
delete anything, never let it touch directories outside this project") and have
Claude help you write the corresponding `permissions.deny` rules — see the
[settings.json reference](../02-customization/settings-reference.md#permissions)
for the exact syntax. Once those hard denies are in place, bypass mode stops being
reckless and just becomes fast.

## Decision guide

| Task risk | Mode |
|---|---|
| Non-trivial task, unfamiliar codebase, anything you want to review before it happens | Plan mode |
| Everyday work, default | Auto mode |
| You want to review every single change | Manual permissions |
| Fast iteration, but only after `settings.json` denies the dangerous stuff | Bypass permissions |
