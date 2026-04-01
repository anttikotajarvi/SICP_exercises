; SICP 2.2.2
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Hierarchical Structures
; Exercise 2.30:
; Define a procedure 'square-tree'...
; ... both directly (i.e., without using any higher order
;  procedures) and also by using 'map' and recursion.
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")

(define tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(define (square-tree-1 t)
  (cond
    [(null? t) nil]
    [(not (pair? t)) (square t)]
    [else (cons (square-tree-1 (car t)) (square-tree-1 (cdr t)))]))

(inspect (square-tree-1 tree))

(define (square-tree-2 t)
  (define (f t)
    (cond
      [(null? t) nil]
      [(not (pair? t)) (square t)]
      [else (square-tree-2 t)]))
  (map f t))
(inspect (square-tree-2 tree))
