; SICP 2.2.3
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Sequences as Conventional Interfaces
; Exercise 2.33:
; Fill the missing expressions to complete the following 
;  definitions of some basic list-manipulation operatiosn
;  as acumulations.
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")
(define (map p sequence)    
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))
(inspect (map square (list 1 2 3 4)))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
(inspect (append (list 1 2 3) (list 4 5 6)))

(define (length sequence)
  (accumulate (lambda (_ y) (+ 1 y)) 0 sequence))
(inspect (length (list 1 2 3 4 5 6)))