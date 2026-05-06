; SICP 2.3.3
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
  ; Subsection: Example: Representing Sets
; Exercise 2.66:
; Implement the 'lookup' procedure for the case where the set of
;  of records is tructured as a binary tree, ordered by the 
;  numerical values of the keys.
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")
(define (make-record key data) (cons key data))
(define key car)
(define record-data cdr)

;; Augmented element-of-set? for binary trees.
(define (lookup x db)
  (cond [(null? db) false]
        [else
         (let ([item (entry db)])
           (cond [(= x (key item)) item]
                 [(< x (key item))
                  (lookup x (left-branch db))]
                 [else
                  (lookup x (right-branch db))]))]))