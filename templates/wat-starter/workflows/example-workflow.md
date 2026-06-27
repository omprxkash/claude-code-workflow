# Workflow: research briefing

A natural-language process the agent follows to produce a short, sourced briefing on
a topic. Copy this as a model for your own workflows.

## Trigger

The user asks for a briefing/research on a topic, e.g. "research <topic>."

## Inputs

- `topic` — what to research (from the user's message).
- Optional: depth ("quick" vs "deep"), audience.

## Steps

1. **Clarify if needed.** If the topic is ambiguous or the scope is unclear, ask one
   or two sharp questions before spending effort. Otherwise proceed.
2. **Research.** Call the `research` tool (see `../tools/example-tool.md`) with the
   topic. Gather 4–8 credible sources.
3. **Synthesize.** Write a tight briefing: a one-paragraph summary, 3–5 key points,
   and any important caveats. No filler.
4. **Cite.** Include the sources as a list of links at the end, each tied to the
   point it supports.
5. **Format.** Output as clean Markdown (or the format the user asked for).
6. **Review.** Re-read for accuracy and that every claim traces to a source. Fix
   anything unsupported.

## Output

A Markdown briefing with summary, key points, caveats, and sources.

## Error handling

- If the research tool fails (bad endpoint, rate limit), diagnose, fix the tool in
  `../tools/`, and retry. Record the fix so it doesn't recur.
- If sources are thin, say so explicitly rather than padding with low-quality ones.

## Notes

- Keep it deterministic where possible: same topic + depth should yield a
  consistent shape of output.
