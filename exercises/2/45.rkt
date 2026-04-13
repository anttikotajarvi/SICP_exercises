; SICP 2.2.4
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Example: A Picture Language
; Exercise 2.45:
; 'right-split' and 'up-split' can be expressed as instances of
;  a general splitting operation.
; Define a procedure 'split' with the property that evaluating
; ...
;  produces procedures 'right-split' and 'up-split' with the same
;  behaviors as the ones already defined.
; ______________________________________________________________
#lang sicp
(#%require sicp-pict)
(#%require "../lib.rkt")
(#%require "../paint-util.rkt")

(define (split a b)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ([smaller (up-split painter (- n 1))]) 
             (a painter (b smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))
(inspect (log-painter (right-split diagonal-shading 2) "2-45-right-split"))
(inspect (log-painter (up-split diagonal-shading 2) "2-45-up-split"))
