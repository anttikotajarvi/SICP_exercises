; SICP 2.2.3
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Sequences as Conventional Interfaces
; Exercise 2.35:
; Redefine 'count-leaves' from Section 2.2.2 as an accumulation:
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")
(define t (cons (list 1 2) (list 3 4)))
(define (count-leaves t)
  (accumulate + 0 (map (lambda (_) 1) (enumerate-tree t))))
(inspect (count-leaves t))