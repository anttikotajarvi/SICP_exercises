; SICP 2.2.4
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Example: A Picture Language
; Exercise 2.50:
; Define the transformation 'flip-horiz', which flips painters
;  horizontally, and transformations that rotate painters
;  counterclockwise by 180 degrees and 270 degrees.
; ______________________________________________________________
#lang sicp
(#%require sicp-pict)
(#%require "../lib.rkt")
(#%require "../paint-util.rkt")
(define (flip-horiz painter)
  (transform-painter painter 
    (make-vect 0 1)
    (make-vect 1 1)
    (make-vect 0 0)))
(inspect (log-painter (flip-horiz einstein) "2-50-flip-horiz"))

(define (rotate-180 painter)
  (transform-painter painter
    (make-vect 1 1)
    (make-vect 0 1)
    (make-vect 1 0)))
(inspect (log-painter (rotate-180 einstein) "2-50-rotate-180"))

(define (rotate-270 painter)
  (transform-painter painter
    (make-vect 0 0)
    (make-vect 0 1)
    (make-vect 1 0)))
(inspect (log-painter (rotate-270 einstein) "2-50-rotate-270"))
