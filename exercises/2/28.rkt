; SICP 2.2.2
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Hierarchical Structures
; Exercise 2.28:
; Write a procedure 'fringe' that takes as argument a tree 
;  (represented as a list) and returns a list whose elements are
;  all the leaves of the tree arranged in left-to-right order.
; For example,
;   (define x (list (list 1 2) (list 3 4)))
;   (fringe x)
;   (1 2 3 4)
;   (fringe (list x x))
;   (1 2 3 4 1 2 3 4)
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")
(define (fringe t)
  (define left (car t))
  (define right (cadr t))
  (define (rec l)
    (if (pair? l)
        (fringe l)
        (list l)))
  (append
    (rec left)
    (rec right)))

(inspect (fringe (list (list 1 2) (list 3 4))))
