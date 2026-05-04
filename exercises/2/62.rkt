; SICP 2.3.3
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Example: Representing Sets
; Exercise 2.62:
; Give an O(n) implementation of 'union-set' for sets 
;  represented as ordered lists.
; ______________________________________________________________
#lang sicp
(define (union-set set1 set2)
  (cond [(null? set1) set2]
        [(null? set2) set1]
        [else
         (let ([x1 (car set1)]
               [x2 (car set2)])
           (cond [(= x1 x2)
                  (cons x1
                        (union-set (cdr set1)
                                   (cdr set2)))]
                 [(< x1 x2)
                  (cons x1
                        (union-set (cdr set1)
                                   set2))]
                 [else
                  (cons x2
                        (union-set set1
                                   (cdr set2)))]))]))
(#%require "../lib.rkt")
(inspect (union-set (list 1 2 6 8) (list 1 3 7 8)))

; Visualization for travelsa goes something like this:
; 1 2 6 8
; 1 3 7 8
; ^ pick either

; 1 2 6 8
;   3 7 8
;   ^ pick smaller

; 1 2 6 8
;     3 7 8
;     ^ pick smaller

; 1 2   6 8
;     3 7 8
;       ^ pick smaller
; 1 2   6 8
;     3   7 8
;         ^ pick smaller

; 1 2   6   8
;     3   7 8
;           ^ pick either
