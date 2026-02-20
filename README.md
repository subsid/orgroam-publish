# orgroam-publish

A flexible static site generator for org-roam notes that creates both public and private blogs. Works with org-roam or regular org-mode files.

## Features

- **Dual Blog System**: Generate both public and private versions of your site
- **Tag-based Publishing**: Control what gets published with simple org-mode tags
- **Incremental Builds**: Fast rebuilds when editing individual files
- **Watch Mode**: Automatically rebuild on file changes
- **Customizable**: Override CSS, preambles, and configuration
- **Syntax Highlighting**: Built-in support for code highlighting with highlight.js
- **Sitemap Generation**: Automatic index pages with chronological listings

## Quick Start

### 1. Set Up Your Blog Repository

```bash
# Clone this generator (or add as submodule to your blog repo)
git clone https://github.com/subsid/orgroam-publish.git

# Or as a submodule in your blog repository
cd your-blog-repo
git submodule add https://github.com/subsid/orgroam-publish.git generator
```

### 2. Configure Your Site

Create a `site-config.el` in your blog repository root:

```elisp
;; site-config.el - Your site-specific configuration

;; Point to your org files
(setq my-org-pages-dir (expand-file-name "~/Dropbox/notes/org_roam_v2/pages"))

;; Customize your navigation
(setq my-site-preamble
  "<div class=\"site-header\">
  <nav class=\"site-nav\">
    <a href=\"/about.html\">About</a>
    <a href=\"/notes.html\">Notes</a>
  </nav>
</div>")

;; Override any other variables as needed
```

### 3. Create Wrapper Scripts

In your blog repository, create build/serve scripts that call the generator:

```bash
#!/bin/bash
# build.sh
./generator/scripts/build.sh "$@"
```

```bash
#!/bin/bash
# serve.sh
./generator/scripts/serve.sh "$@"
```

Make them executable: `chmod +x build.sh serve.sh`

### 4. Build Your Site

```bash
./build.sh              # Full build
./build.sh watch        # Watch for changes
./serve.sh              # Serve public blog on http://localhost:8000
./serve.sh private      # Serve private blog
```

## Directory Structure

```
your-blog-repo/
├── generator/              # This repository (as submodule)
│   ├── src/
│   │   ├── build-site-config.el
│   │   ├── build-site.el
│   │   └── incremental-build.el
│   ├── scripts/
│   │   ├── build.sh
│   │   └── serve.sh
│   └── content/published/
│       └── static/css/
│           └── custom.css
├── site-config.el         # Your custom configuration
├── content/
│   ├── published/         # Your custom CSS/JS/static files
│   │   └── static/css/
│   │       └── custom.css # Overrides generator's default
│   └── unpublished/       # Private-only static assets
├── public/                # Generated public blog (git ignored)
├── private/               # Generated private blog (git ignored)
└── build.sh, serve.sh     # Wrapper scripts
```

## Org File Tags

Control publishing with org-mode tags in your file headers:

- `#+TAGS: publish` - Include in public blog
- `#+TAGS: sitemapignore` - Exclude from sitemap/index pages
- `#+TAGS: notitle` - Don't export the title heading

Example:
```org
#+TITLE: My Public Post
#+DATE: <2024-01-15>
#+TAGS: publish

Content here...
```

## Configuration Variables

Override these in your `site-config.el`:

### Required
- `my-org-pages-dir` - Path to your org files directory

### Optional
- `my-site-preamble` - HTML for public blog header/navigation
- `my-private-site-preamble` - HTML for private blog header/navigation
- `my-html-head` - Custom CSS/JS includes
- `my-exclude-always` - Regex pattern for files to always exclude
- `common-html-properties` - Shared org-publish properties

See `src/build-site-config.el` for all configurable variables.

## Build Commands

### Full Build
Builds both public and private blogs from scratch:
```bash
./build.sh
```

### Watch Mode
Automatically rebuilds when files change:
```bash
./build.sh watch
```

### Incremental Build
Build only a single changed file:
```bash
./build.sh incremental /path/to/file.org
```

### Serve Locally
```bash
./serve.sh              # Public blog on port 8000
./serve.sh private      # Private blog on port 8000
./serve.sh public 3000  # Custom port
```

## Customization

### Custom CSS

1. Create `content/published/static/css/custom.css` in your blog repo
2. Add your custom styles
3. The generator will copy it to both public and private builds

### Custom JavaScript

Add JavaScript files to `content/published/js/` and reference them in `my-html-head`.

### Custom Preamble/Postamble

Override `my-site-preamble` in `site-config.el`:
```elisp
(setq my-site-preamble
  "<div class=\"site-header\">
    <h1>My Blog</h1>
    <nav>
      <a href=\"/\">Home</a>
      <a href=\"/about.html\">About</a>
    </nav>
  </div>")
```

## Deployment

The generator doesn't include deployment scripts - add your own based on your hosting:

### GitHub Pages Example
```bash
#!/bin/bash
# deploy.sh
set -euo pipefail

./build.sh

cd public
git init
git add -A
git commit -m "Deploy $(date)"
git push -f git@github.com:username/username.github.io.git HEAD:main
rm -rf .git
```

## Requirements

- Emacs (with package.el)
- Bash
- Python 3 (for local server)
- `entr` (for watch mode, optional)

## License

MIT License - see LICENSE file

## Credits

- Code highlighting: [highlight.js](https://highlightjs.org/)
- CSS framework: [Simple.css](https://simplecss.org/)
- Syntax highlighting advice: Found on Stack Overflow (link lost)
