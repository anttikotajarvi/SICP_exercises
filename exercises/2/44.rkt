; SICP 2.2.4
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Example: A Picture Language
; Exercise 2.44:
; Define the procedure 'up-split' used by 'corner-split'.
; It is similiar to 'right-split', except that it switches the
;  roles of 'below' and 'beside'
; ______________________________________________________________
#lang sicp
(#%require sicp-pict)
(#%require "../lib.rkt")
(#%require "../paint-util.rkt")

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ([smaller (up-split painter (- n 1))])
           (below
             painter
             (beside smaller smaller)))))

(inspect (log-painter (up-split einstein 2) "2-44-up-split"))
