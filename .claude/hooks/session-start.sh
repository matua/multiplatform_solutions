#!/bin/bash
# SessionStart hook: install the GitLab CLI (glab) and authenticate it to the
# company self-managed GitLab, so `glab` is ready in every fresh remote session.
#
# The token is NEVER stored in this repo. It is read from the GITLAB_TOKEN
# environment variable, which must be set in the Claude Code environment
# secrets (Environments -> Secrets on claude.ai/code). If GITLAB_TOKEN is not
# set, the hook exits quietly without failing the session.
set -euo pipefail

GLAB_HOST="git.pwypp.com"
GLAB_VERSION="1.108.0"

# Only run inside the remote (Claude Code on the web) environment.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Install glab if it is missing (the container is ephemeral).
if ! command -v glab >/dev/null 2>&1; then
  tmp="$(mktemp -d)"
  url="https://gitlab.com/gitlab-org/cli/-/releases/v${GLAB_VERSION}/downloads/glab_${GLAB_VERSION}_linux_amd64.tar.gz"
  if curl -fsSL --retry 3 -o "$tmp/glab.tar.gz" "$url" \
     && tar -xzf "$tmp/glab.tar.gz" -C "$tmp"; then
    install -m 755 "$tmp/bin/glab" /usr/local/bin/glab
  else
    echo "session-start: failed to download glab; skipping glab setup" >&2
    rm -rf "$tmp"
    exit 0
  fi
  rm -rf "$tmp"
fi

# Authenticate only if a token is available.
if [ -n "${GITLAB_TOKEN:-}" ]; then
  glab auth login --hostname "$GLAB_HOST" --token "$GITLAB_TOKEN" >/dev/null 2>&1 || true
  glab config set host "$GLAB_HOST" --global >/dev/null 2>&1 || true
  glab config set git_protocol https --host "$GLAB_HOST" --global >/dev/null 2>&1 || true
  echo "session-start: glab authenticated to $GLAB_HOST" >&2
else
  echo "session-start: GITLAB_TOKEN not set; installed glab but skipped login." >&2
  echo "session-start: add GITLAB_TOKEN in your environment secrets to auto-login." >&2
fi
