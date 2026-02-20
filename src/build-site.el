;; Determine the generator directory
(defvar generator-dir
  (file-name-directory (directory-file-name (file-name-directory load-file-name)))
  "Path to the generator directory.")

;; Load the configuration from the generator
(load-file (expand-file-name "src/build-site-config.el" generator-dir))

;; Only run the build if this file is being run as a script (not loaded)
(when noninteractive
  ;; Generate the site output
  (org-publish-project "my-org-blog" t)
  (create-index-redirect "./public" "notes.html" my-site-preamble "notes")

  ;; Generate the private blog
  (org-publish-project "my-private-blog" t)
  (create-index-redirect "./private" "private.html" my-private-site-preamble "all articles")

  (message "Build complete - both public and private blogs generated"))
