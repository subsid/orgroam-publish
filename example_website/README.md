# Example Website

This is a complete, working example of a blog built with orgroam-publish.

## Quick Start

From this directory:

```bash
# Build the example site
../scripts/build.sh

# Serve it locally
../scripts/serve.sh
# Open http://localhost:8000

# View the private blog (includes unpublished notes)
../scripts/serve.sh private
```

## What's Included

```
example_website/
├── site-config.el         # Configuration (points to ./pages)
├── pages/                 # Example org files
│   ├── article/
│   │   ├── getting-started.org     # Tagged 'publish'
│   │   └── example-post.org        # Tagged 'publish'
│   ├── main/
│   │   ├── example-note.org        # Tagged 'publish'
│   │   └── private-note.org        # NOT tagged (private only)
│   ├── reference/
│   │   └── useful-links.org        # Tagged 'publish'
│   └── about.org                   # Tagged 'publish'
├── content/
│   └── published/
│       └── static/
│           └── css/
│               └── custom.css      # Custom styles
├── public/                         # Generated (git ignored)
└── private/                        # Generated (git ignored)
```

## Using This as a Template

1. **Copy this directory** to start your own blog:
   ```bash
   cp -r example_website ~/my-blog
   cd ~/my-blog
   ```

2. **Edit `site-config.el`** to point to your org files:
   ```elisp
   (setq my-org-pages-dir 
     (expand-file-name "~/org-roam/pages"))
   ```

3. **Customize navigation** in `site-config.el`

4. **Build and preview**:
   ```bash
   ../scripts/build.sh
   ../scripts/serve.sh
   ```

## Publishing Content

Add `#+TAGS: publish` to any org file you want on the public blog:

```org
#+TITLE: My Post
#+TAGS: publish
#+EXPORT_FILE_NAME: my-post
#+DATE: <2024-01-15>

Content here...
```

Files without the `publish` tag only appear in the private blog.

## Directory Structure

Organize your org files:

- `article/` — Long-form blog posts
- `main/` — Short notes and thoughts  
- `reference/` — Links, snippets, resources

## See Also

- [Generator README](../README.md) — Full documentation
- [Getting Started](pages/article/getting-started.org) — Tutorial (becomes HTML after build)
