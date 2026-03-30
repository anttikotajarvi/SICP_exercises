; SICP 2.2.2
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Hierarchical Structures
; Exercise 2.26:
; Suppose we define x and y to be two lists:
#lang sicp
(define x (list 1 2 3))
(define y (list 4 5 6))
; What result is printed by the interpreter in response to 
;  evaluating each of the following expressions:
(#%require "../lib.rkt")
(inspect (append x y))
(inspect (cons x y))
(inspect (list x y))
; ______________________________________________________________
