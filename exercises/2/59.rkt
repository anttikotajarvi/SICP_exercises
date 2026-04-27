;; SICP 2.3.3
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Example: Representing Sets
; Exercise 2.59: SICP 2.3.3
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Example: Representing Sets
; Exercise 2.59:
; Implement the 'union-set' operation for the unordered-list
;  representation of sets.
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")

(define (union-set set1 set2)
  (if (null? set1)
      set2
      (union-set (cdr set1)
                 (adjoin-set (car set1) set2))))

(inspect (union-set '(1 2 3) '(3 4 5))) ; (2 1 3 4 5)