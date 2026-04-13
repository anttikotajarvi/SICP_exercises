#lang racket

(require sicp-pict
         racket/class
         racket/file
         racket/path
         racket/runtime-path)

(provide paint-output-dir
         save-painter
         log-painter)

;; Change this if you want a different fixed output folder.
;; This is anchored relative to paint-util.rkt itself.
(define-runtime-path paint-output-dir "../paint-out")

(define (save-painter painter filename [width 400] [height 400])
  (make-directory* paint-output-dir)
  (define path
    (build-path paint-output-dir
                (string-append filename ".png")))
  (define snip (paint painter #:width width #:height height))
  (define bm (send snip get-bitmap))
  (send bm save-file path 'png)
  path)

;; Alias with the same behavior, if you prefer this name.
(define log-painter save-painter)