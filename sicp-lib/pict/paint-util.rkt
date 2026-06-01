#lang racket

(require sicp-pict
         racket/class
         racket/file
         racket/path
         racket/runtime-path)

(provide paint-output-dir
         save-painter
         log-painter)

;; SICP 2.2.4: Example: A Picture Language.
;; Utility helpers for saving painters while working through exercises.
;; Keep the existing repository-level paint-out folder from the old
;; exercises/paint-util.rkt location.
(define-runtime-path paint-output-dir "../../paint-out")

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
