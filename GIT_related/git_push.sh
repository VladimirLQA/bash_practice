#!/bin/sh

set -e

gpsh () {
  local BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return 1
  [[ -z "$BRANCH" ]] && { echo "Not on any branch"; return 1; }
  [[ "$BRANCH" = "master" ]] && { echo "Push to master is FORBIDDEN. Create a branch, BIRDBRAIN!"; return 1; }

  local -a OPTS=(origin "$BRANCH")

  if ! git ls-remote --exit-code origin "$BRANCH" >/dev/null 2>&1; then
    OPTS=(--set-upstream origin "$BRANCH")
  fi

  if [[ "$1" = "f" ]]; then
    OPTS+=(--force-with-lease)
  fi

  git push "${OPTS[@]}"
}
