; SICP 2.2.1
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Representing Sequences
; Exercise 2.21:
; The procedure 'square-list' takes a list of numbers as 
;  argument and returns a list of the squares of those numbers.
;  (square-list (list 1 2 3 4))
;  (1 4 9 16)
; Here are two different definitions of 'square-list'.
;  Complete both of hem by filling in the missing expressions:
; ______________________________________________________________
#lang sicp
(define (square-list-1 items)
  (if (null? items)
      nil
      (cons (square (car items)) 
            (square-list-1 (cdr items)))))

(define (square-list-2 items)
  (map square items))

(#%require "../lib.rkt")
(inspect (square-list-1 (list 1 2 3 4 5 6)))
(inspect (square-list-2 (list 1 2 3 4 5 6)))
