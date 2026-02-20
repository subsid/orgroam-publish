#!/bin/bash

# Determine the script directory and generator directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GENERATOR_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Show help message
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    cat << EOF
Usage: build.sh [MODE]

Build your org-roam blog from org files to HTML.

MODES:
  (none)        Full rebuild - cleans output directories and rebuilds all files
  watch         Watch for changes and rebuild incrementally
  incremental   Incremental build (internal use by watch mode)

OPTIONS:
  -h, --help    Show this help message

EXAMPLES:
  ./scripts/build.sh              # Full rebuild
  ./scripts/build.sh watch        # Watch mode with auto-rebuild

NOTE:
  - Full rebuilds clean public/ and private/ directories
  - Watch mode only rebuilds changed files (faster)
  - Sitemap changes require a full rebuild
EOF
    exit 0
fi

if [ "$1" = "watch" ]; then
    # Extract org pages directory from site-config.el
    if [ -f "./site-config.el" ]; then
        ORG_DIR=$(emacs --batch --eval "(progn (load-file \"./site-config.el\") (princ (expand-file-name my-org-pages-dir)))" 2>/dev/null)
    else
        # Default to test fixtures if no config
        ORG_DIR="$GENERATOR_DIR/test/fixtures/pages"
    fi
    
    echo "Watching for changes in $ORG_DIR/{article,main,reference}..."
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
