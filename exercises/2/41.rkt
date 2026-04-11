; SICP 2.2.3
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Sequences as Conventional Interfaces
; Exercise 2.41:
; Write a procedure to find all ordered triples of distinct
;  positive integers i, j, and k less than or equal to a given 
;  integer n that sum to a given integer s.
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")
(define (unique-triples n)
    (flatmap (lambda (i)
            (map (lambda (jk) (cons i jk))
                 (unique-pairs (- i 1))))
         (enumerate-interval 0 n)))

(define (ordered-triples-equal-to-s n s)
  (define (pred? triple) (= (sum-list triple) s))
  (filter pred?
        (unique-triples n)))

(inspect (ordered-triples-equal-to-s 5 9))