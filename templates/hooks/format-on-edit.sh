#!/usr/bin/env bash
# Example post-edit hook: format a file after Claude Code edits it.
#
# Claude Code passes hook context as JSON on stdin. This script reads the edited
# file path from it and runs an appropriate formatter. Adjust the formatters to your
# stack. Keep it fast and non-interactive — hooks block the tool flow while running.

set -euo pipefail

# Read the edited file path from the hook's JSON payload on stdin.
# (Requires `jq`. If you don't have it, hardcode or parse differently.)
payload="$(cat)"
file="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty')"

# Nothing to do if we couldn't determine the file.
[ -z "${file:-}" ] && exit 0
[ -f "$file" ] || exit 0

case "$file" in
  *.py)        command -v black >/dev/null 2>&1 && black --quiet "$file" ;;
  *.js|*.ts|*.tsx|*.jsx|*.json|*.css|*.md)
               command -v prettier >/dev/null 2>&1 && prettier --write "$file" >/dev/null 2>&1 ;;
  *.go)        command -v gofmt >/dev/null 2>&1 && gofmt -w "$file" ;;
  *)           : ;;  # no formatter for this type
esac

exit 0
