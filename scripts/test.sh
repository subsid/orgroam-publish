#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GENERATOR_DIR="$(dirname "$SCRIPT_DIR")"

cd "$GENERATOR_DIR"

echo "Running orgroam-publish test suite..."
echo

# Create temporary site-config.el for testing
cat > site-config.el <<EOF
;; Temporary test configuration
(setq my-org-pages-dir 
  (expand-file-name "test/fixtures/pages" 
    (file-name-directory load-file-name)))
EOF

# Clean any previous test output
rm -rf ./public ./private
mkdir -p ./public ./private

echo "1. Testing full build with test fixtures..."
./scripts/build.sh > /dev/null 2>&1

# Check that output was generated
echo
echo "2. Verifying output..."

if [ ! -f "./public/notes.html" ]; then
    echo "❌ FAIL: public/notes.html not generated"
    exit 1
fi

if [ ! -f "./private/private.html" ]; then
    echo "❌ FAIL: private/private.html not generated"
    exit 1
fi

# Check that published article is in public
if [ ! -f "./public/article/published-article.html" ]; then
    echo "❌ FAIL: Published article not in public blog"
    exit 1
fi

# Check that unpublished article is NOT in public
if [ -f "./public/article/unpublished-article.html" ]; then
    echo "❌ FAIL: Unpublished article should not be in public blog"
    exit 1
fi

# Check that unpublished article IS in private
if [ ! -f "./private/article/unpublished-article.html" ]; then
    echo "❌ FAIL: Unpublished article should be in private blog"
    exit 1
fi

echo "✅ All tests passed!"
echo
echo "Test output in: $GENERATOR_DIR/public/ and $GENERATOR_DIR/private/"

# Clean up test output and config
echo "Cleaning up test output..."
rm -rf ./public ./private ./site-config.el
