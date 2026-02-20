#!/bin/bash

# Determine the script directory and generator directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GENERATOR_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ "$1" = "watch" ]; then
    # Get the org pages directory from environment or use default
    ORG_DIR="${ORG_PAGES_DIR:-./test/fixtures/pages}"
    echo "Watching for changes in $ORG_DIR/{article,main,reference}/..."
    find "$ORG_DIR"/{article,main,reference} -name "*.org" \
        -not -name "notes.org" -not -name "references.org" -not -name "private.org" -not -name "sitemap.org" 2>/dev/null | \
        entr -n -s './scripts/build.sh incremental "$0"'
elif [ "$1" = "incremental" ]; then
    CHANGED_FILE="${*:2}"
    if [ -n "$CHANGED_FILE" ]; then
        echo "Incrementally building changed file: $CHANGED_FILE"
        emacs -Q --batch --eval "(setq changed-file \"$CHANGED_FILE\")" -l "$GENERATOR_DIR/src/incremental-build.el"
        echo "Incremental build complete!"
    else
        echo "No file specified for incremental build"
    fi
else
    echo "Cleaning public/ and private/ directories..."
    rm -rf ./public/* ./private/*
    echo "Building site (full rebuild)..."
    emacs -Q --script "$GENERATOR_DIR/src/build-site.el"
    echo "Build complete!"
fi
