; SICP 2.2.1
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Representing Sequences
; Exercise 2.18:
; Define a procedure 'reverse' that takes list as argument and
;  returns a list of the same elements in reverse order:
; (reverse (list 1 4 9 16 25))
; (25 16 9 4 1)
; ______________________________________________________________
#lang sicp
(define (reverse l)
  (define (iter l rl)
    (if (null? l)
        rl
        (iter (cdr l) (cons (car l) rl))))
  (iter l (list)))

(#%require "../lib.rkt")
(inspect (reverse (list 1 4 9 16 25)))