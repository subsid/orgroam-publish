#!/bin/bash

# Blog server script - serves either public or private blog
# Usage: ./serve.sh [private] [port]
# Default port is 8000

# Show help message
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    cat << EOF
Usage: serve.sh [BLOG_TYPE] [PORT]

Start a local HTTP server to preview your blog.

ARGUMENTS:
  BLOG_TYPE     Which blog to serve: 'private' or omit for public (default: public)
  PORT          Port number to serve on (default: 8000)

OPTIONS:
  -h, --help    Show this help message

EXAMPLES:
  ./scripts/serve.sh              # Serve public blog on port 8000
  ./scripts/serve.sh private      # Serve private blog on port 8000
  ./scripts/serve.sh public 3000  # Serve public blog on port 3000
  ./scripts/serve.sh private 3000 # Serve private blog on port 3000

NOTE:
  Make sure to run build.sh before serving.
  Press Ctrl+C to stop the server.
EOF
    exit 0
fi

PORT=${2:-8000}

if [ "$1" = "private" ]; then
    BLOG_DIR="./private"
    BLOG_TYPE="private"
else
    BLOG_DIR="./public"
    BLOG_TYPE="public"
fi

# Check if directory exists
if [ ! -d "$BLOG_DIR" ]; then
    echo "Error: $BLOG_TYPE blog directory '$BLOG_DIR' does not exist."
    echo "Please build the blog first."
    exit 1
fi

echo "Starting $BLOG_TYPE blog server..."
echo "Directory: $BLOG_DIR"
echo "URL: http://localhost:$PORT"
echo "Press Ctrl+C to stop the server"
echo

cd "$BLOG_DIR" && python -m http.server "$PORT"
