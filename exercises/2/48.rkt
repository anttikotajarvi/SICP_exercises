; SICP 2.2.4
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Example: A Picture Language
; Exercise 2.48:
; Here are two possible constructors for frames:
; A directed line segment in the placen can be represented as a
;  pair of vectors---the vector running from the origin to the 
;  start-point of the segment, and the vector running from the 
;  origin to the end-point of the segment.
; Use your vector representation from Exercise 2.46 to define a
;  representation for segments with a constructor 'make-segment'
;  and selectors 'start-segment' and 'end-segment'.
; ______________________________________________________________
#lang sicp
(define (make-segment v1 v2) (cons v1 v2))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))
