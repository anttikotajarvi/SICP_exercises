; SICP 2.2.1
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Representing Sequences
; Exercise 2.22:
; Louis Reasoner tries to rewrite the first 'square-list'
;  procedure of Exercise 2.21 so that it evolves an iterative
;  process:
#lang sicp
   (define (square-list-1 items)
     (define (iter things answer)
       (if (null? things)
           answer
           (iter (cdr things)
                 (cons (square (car things))
                       answer))))
       (iter items nil))
; Unfortunately, defining 'square-list' this way produces the
;  list in the reverse order of the one desired. Why?
;
; Louis then tries to fix his bug by interchanging the arguments
;  to cons:
   (define (square-list-2 items)
     (define (iter things answer)
       (if (null? things)
           answer
           (iter (cdr things)
                 (cons answer
                       (square (car things))))))
       (iter items nil))
; This doesn't work either. Explain.
; ______________________________________________________________
(#%require "../lib.rkt")
(inspect (square-list-1 (list 1 2 3 4 5)));  (25 16 9 4 1)
; This returns (25 16 9 4 1)
; Or (25 (16 (9 (4 1))))
; Because on every iteration it creates a new pair
;  with the neew value in the car slot and the previous pair/list
;  in the cdr slot.
;  
(inspect (square-list-2 (list 1 2 3 4 5)))
; (((((() . 1) . 4) . 9) . 16) . 25)
; Here it creates a new pair and adds the current list to the 
;  car slot. This would be an "improper list". 
; First item would be accessed from the cdr slot.

; Lists are built from the front so the last element isnt 
;  readily available and needs to be walked to
