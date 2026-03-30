; SICP 2.2.2
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Hierarchical Structures
; Exercise 2.25:
; Give combinations of cars and cdrs that will pick 7 from each
;  of the following lists:
; (1 3 (5 7) 9)
; ((7))
; (1 (2 (3 (4 (5 (6 7))))))
; ______________________________________________________________
#lang sicp

(#%require "../lib.rkt")

; List 1
(define l1 (list 1 3 (list 5 7) 9))
(display "Should be: (1 3 (5 7) 9)\n")
(inspect l1)
(inspect (cdr (car (cdr (cdr l1)))))
(newline)

; List 2
(define l2 (list (list 7)))
(display "Should be: ((7))\n")
(inspect l2)
(inspect (car (car l2)))
(newline)

; List 3
(define l3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(display "Should be: (1 (2 (3 (4 (5 (6 7))))))\n")
(inspect l3)
(inspect (cadr (cadr (cadr (cadr (cadr (cadr l3)))))))
