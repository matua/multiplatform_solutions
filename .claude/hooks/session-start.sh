#!/bin/bash
# SessionStart hook: install the GitLab CLI (glab) so it is ready in every
# fresh remote session (the container is ephemeral and loses it otherwise).
#
# By design the token is NOT stored anywhere (not in this repo, not in the
# cloud environment variables, which are unmasked). Authentication is done
# manually per session: paste the token in chat and have the assistant run
# `glab auth login`. If a GITLAB_TOKEN happens to be present in the
# environment, the hook will use it, but that is optional and not expected.
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
  echo "session-start: glab installed. No token stored by design;" >&2
  echo "session-start: authenticate manually with 'glab auth login --hostname $GLAB_HOST'." >&2
fi
