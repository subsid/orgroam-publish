# orgroam-publish

A static site generator for org-roam notes that creates both public and private blogs.

## Features

- **Tag-based Publishing** — Control what gets published with org-mode tags
- **Incremental Builds** — Fast rebuilds when editing files
- **Watch Mode** — Automatically rebuild on changes
- **Simple Configuration** — Single `site-config.el` file
- **Syntax Highlighting** — Built-in code highlighting with highlight.js
- **Sitemap Generation** — Automatic index pages sorted chronologically

## Quick Start

### Try the Example

```bash
# Clone the repository
git clone https://github.com/subsid/orgroam-publish.git
cd orgroam-publish

# Build and serve the example
cd example_website
../scripts/build.sh
../scripts/serve.sh
# Open http://localhost:8000
```

The `example_website/` directory is a complete, working blog you can copy and customize.

### Create Your Own Blog

**Option 1: Copy the example**

```bash
cp -r orgroam-publish/example_website ~/my-blog
cd ~/my-blog

# Edit site-config.el to point to your org files
# Then build
../scripts/build.sh
```

**Option 2: Use as submodule (recommended)**

```bash
# In your blog repository
git submodule add https://github.com/subsid/orgroam-publish.git generator

# Copy example config
cp generator/example_website/site-config.el .

# Edit site-config.el, then build
./generator/scripts/build.sh
```

See [example_website/README.md](example_website/README.md) for details.

## Configuration

Create `site-config.el` in your blog repository:

```elisp
;; Point to your org-roam pages directory
(setq my-org-pages-dir 
  (expand-file-name "~/org-roam/pages"))

;; Customize navigation
(setq my-site-preamble
  "<div class=\"site-header\">
  <nav class=\"site-nav\">
    <a href=\"/about.html\">About</a>
    <a href=\"/notes.html\">Notes</a>
  </nav>
</div>")
```

See `example_website/site-config.el` for all options.

## Publishing Content

Add `#+TAGS: publish` to any org file you want on the public blog:

```org
#+TITLE: My Post
#+TAGS: publish
#+EXPORT_FILE_NAME: my-post
#+DATE: <2024-01-15>

Content here...
```

### Available Tags

| Tag             | Effect                                      |
|-----------------|---------------------------------------------|
| `publish`       | Include in public blog                      |
| `sitemapignore` | Publish but exclude from sitemap            |
| `notitle`       | Suppress the `<h1>` title in exported HTML  |

### Directory Structure

Organize your org files:

```
pages/
├── article/    # Long-form posts
├── main/       # Short notes
└── reference/  # Links, snippets, resources
```

Files in `project/`, `work/`, `Inbox.org`, and `Mobile Inbox.org` are always excluded.

## Scripts

```bash
# Build (from your blog directory)
./generator/scripts/build.sh

# Watch for changes and rebuild
./generator/scripts/build.sh watch

# Serve locally
./generator/scripts/serve.sh         # Public blog on :8000
./generator/scripts/serve.sh private # Private blog on :8000

# Run tests
./generator/scripts/test.sh
```

## Development

```bash
# Clone and test
git clone https://github.com/subsid/orgroam-publish.git
cd orgroam-publish

# Run test suite
./scripts/test.sh

# Try the example
cd example_website
../scripts/build.sh
../scripts/serve.sh
```

## Requirements

| Dependency | Purpose                   | Required?          |
|------------|---------------------------|--------------------|
| Emacs 28+  | Build engine (ox-publish) | Yes                |
| Python 3   | Local preview server      | For `serve.sh`     |
| `entr`     | File watching             | For `build.sh watch` |

## License

MIT License - see [LICENSE](LICENSE)

## See Also

- [example_website/](example_website/) — Complete working example
- [System Crafters org-website-example](https://github.com/SystemCrafters/org-website-example) — Inspiration
