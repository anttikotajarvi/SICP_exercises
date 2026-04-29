; SICP 2.3.3
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Example: Representing Sets
; Exercise 2.61:
; Give an implementation of 'adjoin-set' using the ordered
;  representation.  By analogy with 'element-of-set?' show how 
;  to take advantage of the ordering to produce a procedure that
;  requires on the average about half as many steps as with the
;  unordered representation.
; ______________________________________________________________
#lang sicp
; Same as with the ordered implementation of 'element-of-set?',
;  here we only have to traverse on average half the length of 
;  the set.
(define (adjoin-set x set)
  (define head (car set))
  (define rest (cdr set))
  (cond [(null? set) (list x)]
        [(= x head) set]
        [(< x head) (cons x set)]
        [else (cons head
                    (adjoin-set x rest))]))

