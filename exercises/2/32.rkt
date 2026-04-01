; SICP 2.2.2
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Hierarchical Structures
; Exercise 2.32:
; We can represent a set as a list of distinct elements, and we
;  can represent the of all subsets of the set as a list of
;  lists.
; For example, if the set is (1 2 3), then the set of all
;  subsets is (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)).
; Complete the following definition of a procedure that
;  generates the set of subsets of a set and give a clear
;  explanation of why it works:
; ______________________________________________________________
#lang sicp
(define (subsets s)
  (define (f ss) (append (list (car s)) ss))
  (if (null? s)
      (list nil)
      (let ([rest (subsets (cdr s))]) 
           (append rest (map f rest)))))
(define set (list 1 2 3))
(#%require "../lib.rkt")
(display "Should be:      (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))\n")
(inspect (subsets set))
; To determine the function we need need to map over 'rest'
;  assume rest in the first iteration of subsets(1 2 3) to be correct:
;; (subsets '(2 3)) ; (() (3) (2) (2 3))
; The result includes every subset of (2 3)
;  so to get every subset of (1 2 3), we need to append 1 to every
;  subset of (2 3) and append that to the subsets of (2 3).
; So:
; subsets(1 2 3) = subsets(2 3)
;                  appended with
;                  1 added to every subset of subsets(2 3)
; or:
; subsets(1 2 3) = rest . map(f rest)
; where: 
; f(ss) = (append 1 ss) = (append (car(1 2 3) ss))
; rest = subsets(2 3) = subsets(cdr(1 2 3))

