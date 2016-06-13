;;; Emacs org-mode support for blogging with Jekyll.
;;;
;;; To use, just put this file somewhere in your emacs load path and
;;; (require 'org-jekyll)
;;;
;;; An article showing its use can be found at:
;;;    - http://www.gorgnegre.com/linux/using-emacs-orgmode-to-blog-with-jekyll.html
;;;
;;; Adapted from
;;;    - http://orgmode.org/worg/org-tutorials/org-jekyll.html
;;;    - https://github.com/metajack/jekyll/blob/master/emacs/jekyll.el
;;;
;;; Gorg Negre 2012-07-05

(provide 'org-jekyll)

;; Define our org project to be exported. Run "M-x org-export X mvm" to
;; export.
(setq org-publish-project-alist
      '(

   ("org-mvm"
          :base-directory "~/org-jekyll/org/" ;; Path to your org files.
          :base-extension "org"
          :publishing-directory "~/org-jekyll/rootdir/" ;; Path to your Jekyll project.
          :recursive t
          :publishing-function org-publish-org-to-html
          :headline-levels 6
          :html-extension "html"
          :body-only t ;; Only export section between &lt;body&gt; &lt;/body&gt; tags
          :section-numbers nil
          :table-of-contents nil

          :author "Your Name"
          :email "user@example.cat"
    )

    ("org-static-mvm"
          :base-directory "~/org-jekyll/org/"
          :base-extension "css\\|js\\|png\\|jpg\\|ico\\|gif\\|pdf\\|mp3\\|flac\\|ogg\\|swf\\|php\\|markdown\\|md\\|html\\|htm\\|sh\\|xml\\|gz\\|bz2\\|vcf\\|zip\\|txt\\|tex\\|otf\\|ttf\\|eot\\|rb\\|yml\\|htaccess\\|gitignore"
          :publishing-directory "~/org-jekyll/rootdir/"
          :recursive t
          :publishing-function org-publish-attachment)

    ("mvm" :components ("org-mvm" "org-static-mvm"))

))
