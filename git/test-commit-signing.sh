#!/bin/bash

echo "🔐 Creating a test signed commit (empty)..."

current_branch=$(git rev-parse --abbrev-ref HEAD)

git commit --allow-empty -S -m "test: signed commit test" >/dev/null 2>&1
commit_status=$?

echo
echo "🔍 Checking the signature..."
echo

if [[ $commit_status -ne 0 ]]; then
  echo "❌ Failed to create signed commit."
  echo
  exit 1
fi

signature_info=$(git log --show-signature -1 2>&1)

if echo "$signature_info" | grep -q "Good "; then
  echo "✅ Signed commit verified successfully."
  echo
else
  echo "❌ Signature verification failed.\n"
  echo "$signature_info"
  echo
fi

# Clean up
git reset --soft HEAD~1 >/dev/null 2>&1
echo "🧹 Test commit removed from branch '$current_branch'."
echo
