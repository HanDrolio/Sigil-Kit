#!/usr/bin/env bash
set -euo pipefail
# Initialize repo, add sigil kit, set commit template, and create a signed tag.

REPO_NAME="${1:-ritual-repo}"
mkdir -p "$REPO_NAME"
cp -r "$(dirname "$0")"/* "$REPO_NAME"/ 2>/dev/null || true

cd "$REPO_NAME"
git init
git add .
git commit -m "Init: add Sigil Kit and scaffolding" || true

# Optional: set commit template (adjust path if needed)
git config commit.template "$(pwd)/COMMIT_TEMPLATE.txt" || true

# Make an origin tag (signed if GPG configured; else annotated)
if gpg --list-keys >/dev/null 2>&1; then
  git tag -s origin-v1 -m "Origin proof: sigil kit"
else
  git tag -a origin-v1 -m "Origin proof: sigil kit"
fi

echo "Repo initialized. Next:"
echo "  git branch -M main"
echo "  git remote add origin <your-remote>"
echo "  git push -u origin main || true"
echo "  git push --tags || true"
