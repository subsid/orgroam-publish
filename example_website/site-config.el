;; Example site configuration for orgroam-publish
;; Copy this file to your blog repository and customize

;; Point to the example pages directory
;; For your own blog, change this to your org-roam pages directory
;; Example: (setq my-org-pages-dir (expand-file-name "~/org-roam/pages"))
(setq my-org-pages-dir 
  (expand-file-name "pages" 
    (file-name-directory load-file-name)))

;; Customize the public blog navigation
(setq my-site-preamble
  "<div class=\"site-header\">
  <nav class=\"site-nav\">
    <a href=\"/about.html\">About</a>
    <a href=\"/notes.html\">Notes</a>
    <a href=\"/references.html\">References</a>
  </nav>
</div>")

;; Customize the private blog navigation (adds link to unpublished content)
(setq my-private-site-preamble
  "<div class=\"site-header\">
  <nav class=\"site-nav\">
    <a href=\"/about.html\">About</a>
    <a href=\"/notes.html\">Notes</a>
    <a href=\"/references.html\">References</a>
    <a href=\"/private.html\">Private</a>
  </nav>
</div>")

;; Optional: Customize HTML head (CSS/JS includes)
;; The defaults include simple.css, highlight.js, and custom.css
;; Uncomment to override:
;; (setq my-html-head
;;   "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />
;; <link rel=\"stylesheet\" href=\"/static/css/custom.css\" />
;; <script src=\"/js/main.js\"></script>")

;; Optional: Customize exclude patterns
;; Default excludes: project/, work/, Inbox.org, Mobile Inbox.org
;; Uncomment to override:
;; (setq my-exclude-always "^\\(project\\|work\\|drafts\\)/.*\\.org$\\|^Inbox\\.org$")
