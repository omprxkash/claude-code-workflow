# Tool: research

A single capability: given a topic, return credible sources with short summaries.
Copy this as a model for your own tools — one job per tool, described plainly enough
that the agent can build and maintain it.

## Purpose

Search the web for a topic and return a ranked list of credible sources, each with a
one-line summary.

## Inputs

- `topic` (string) — the subject to research.
- `max_sources` (int, default 6) — how many to return.

## Output

A list of `{ title, url, summary }`, ordered most-relevant first.

## How it works

1. Query the configured research/search provider for `topic`.
2. Filter to credible, on-topic results; drop duplicates and low-quality sources.
3. Summarize each in one line.
4. Return up to `max_sources` results.

## Credentials

- Reads `RESEARCH_API_KEY` from the environment (`.env`). Never hardcode it.

## Errors

- **Auth error:** check `RESEARCH_API_KEY` is set and valid.
- **Endpoint/4xx-5xx error:** the provider's API may have changed — check current
  docs, update the endpoint here, and note the change at the bottom of this file.
- **Empty results:** report that the topic returned nothing rather than inventing
  sources.

## Changelog

- _(record fixes/endpoint changes here as the agent learns them)_
