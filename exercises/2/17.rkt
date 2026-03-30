; SICP 2.2.1
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Representing Sequences
; Exercise 2.17:
; Define a procedure 'last-pair' that returns the list that 
;  contains only the last element of a given (nonempty) list:
; (last-pair (list 23 72 149 34))
; (34)
; ______________________________________________________________
#lang sicp
(define (last-pair l)
    (if (null? (cdr l))
        (car l)
        (last-pair (cdr l))))

(#%require "../lib.rkt")
(last-pair (list 23 72 149 34))