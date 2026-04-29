; SICP 2.3.3
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Example: Representing Sets
; Exercise 2.60:
; We specified that a set would be represented as a list with
;  no duplicates.  Now suppose we allow duplicates.  
; For instance, the set {1, 2, 3} could be represented as the 
;  list (2 3 2 1 3 2 2).  Design procedures element-of-set?,
;  adjoin-set, union-set, and intersection-set that operate on
;  this representation.  
; How does the efficiency of each compare with the corresponding
;  procedure for the non-duplicate representation? 
; Are there applications which you would use this representation
;  in preference to the non duplicate one?
; ______________________________________________________________
#lang sicp

(define (element-of-set? x set)
  (cond [(null? set) false]
        [(equal? (car set) x) true]
        [else (element-of-set? x (cdr set))]))

(define (adjoin-set x set) (cons x set))

(define (union-set set1 set2) (append set1 set2))

;; Same as the previous implementation
(define (intersection-set set1 set2)
  (cond [(or (null? set1) (null? set2)) '()]
        [(element-of-set? (car set1) set2)]
        [(cons (car set1) (intersection-set (cdr set1) set2))]
        [else (intersection-set (cdr set1) set2)]))

;; This representation might be useful for short-lived sets 
;;  where we mostly build sets with adjoin-set or union-set, 
;;  and do not care about accumulating some duplicates.