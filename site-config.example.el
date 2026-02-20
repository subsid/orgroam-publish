;; Example site-config.el - Copy this to your blog repository root
;; This file demonstrates how to customize orgroam-publish for your site

;; ============================================================================
;; Required: Point to your org-roam directory
;; ============================================================================
;; This is the most important setting - where your org files live
;; Note: You can also use ORG_PAGES_DIR environment variable to override temporarily
(setq my-org-pages-dir 
  (expand-file-name "~/path/to/your/org-roam/pages"))

;; Customize navigation for public blog
(setq my-site-preamble
  "<div class=\"site-header\">
  <nav class=\"site-nav\">
    <a href=\"/about.html\">About</a>
    <a href=\"/notes.html\">Notes</a>
    <a href=\"/references.html\">References</a>
  </nav>
</div>")

;; Customize navigation for private blog (with additional link)
(setq my-private-site-preamble
  "<div class=\"site-header\">
  <nav class=\"site-nav\">
    <a href=\"/about.html\">About</a>
    <a href=\"/notes.html\">Notes</a>
    <a href=\"/references.html\">References</a>
    <a href=\"/private.html\">Unpublished/Private</a>
  </nav>
</div>")

;; Optional: Customize HTML head (CSS/JS includes)
;; Uncomment and modify if needed
;; (setq my-html-head
;;   "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />
;; <link rel=\"stylesheet\" href=\"/static/css/custom.css\" />
;; <script src=\"/js/main.js\"></script>")

;; Optional: Customize exclude patterns
;; Uncomment to exclude additional files/directories
;; (setq my-exclude-always "^\\(project\\|work\\|private\\)/.*\\.org$\\|^Inbox\\.org$")

;; Optional: Customize sitemap files
;; (setq my-public-sitemap-files '("notes.org" "references.org"))
;; (setq my-private-sitemap-files '("notes.org" "references.org" "private.org"))
