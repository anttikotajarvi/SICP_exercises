; SICP 2.2.2
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Hierarchical Structures
; Exercise 2.31:
; Abstract your answer to Exercise 2.30 to produce a proocedure
;  'tree-map' with the property that 'square'tree' could be
;  defined as
;   (define (square-tree tree) (tree-map square tree))
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")
(define (tree-map f t)
  (define (f-mod t)
    (cond
      [(null? t) nil]
      [(not (pair? t)) (f t)]
      [else (tree-map f t)]))
  (map f-mod t))
(define tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(inspect (tree-map square tree))
