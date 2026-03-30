; SICP 2.2.2
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Hierarchical Structures
; Exercise 2.24:
; Suppose we evaluate the expression 
; (list 1 (list 2 (list 3 4))).
; Give the result printed by the interpreter, the corresponding
;  box-and-pointer structure, and the interpretation of this as
;  a tree (as in Figure 2.6).
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")
(display (list 1 (list 2 (list 3 4))))
; (1 (2 (3 4)))

; box-and-pointer strcture:
; [1][]->[2][]->[3][]->[4][/]

; tree representation
; / \
;1  /\
;  2 /\
;   3 4  