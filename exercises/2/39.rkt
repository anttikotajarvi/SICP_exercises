; SICP 2.2.3
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Sequences as Conventional Interfaces
; Exercise 2.39:
; Complete the following definitions of 'reverse' 
;  (Exercise 2.18) in terms of 'fold-right' and 'fold-left' from
;  Exercise 2.38:
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")
(define (reverse sequence)
  (fold-right (lambda (x y) (append y (list x))) nil sequence))
(inspect (reverse (list 1 2 3)))

(define (reverse-2 sequence)
  (fold-left (lambda (x y) (cons y x)) nil sequence))
(inspect (reverse-2 (list 1 2 3)))

  