; SICP 2.2.4
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Example: A Picture Language
; Exercise 2.49:
; Use 'segments->painter' to define the following primitive 
;  painters:
; a. The painter that draws the outline of the designated frame.
; ______________________________________________________________
#lang sicp
(#%require sicp-pict)
(#%require "../paint-util.rkt")
(#%require "../lib.rkt")

(define outline-painter (segments->painter (list 
    (make-segment (make-vect 0 0) (make-vect 1 0))
    (make-segment (make-vect 1 0) (make-vect 1 1))
    (make-segment (make-vect 1 1) (make-vect 0 1))
    (make-segment (make-vect 0 1) (make-vect 0 0)))))

(inspect (log-painter outline-painter "2-49-outline"))
; ______________________________________________________________
; b. The painter that draws an "X" by connecting the opposite
;    corners of the frame.
; ______________________________________________________________
(define x-painter (segments->painter (list
  (make-segment (make-vect 0 0) (make-vect 1 1))
  (make-segment (make-vect 1 0) (make-vect 0 1)))))
(inspect (log-painter x-painter "2-49-x"))
; ______________________________________________________________
; c. The painter that draws a diamong shape by connecting the 
;    midpoints of the sides of the frame.
; ______________________________________________________________
(define diamond-painter (segments->painter (list
  (make-segment (make-vect 0.5 0) (make-vect 0 0.5))
  (make-segment (make-vect 0 0.5) (make-vect 0.5 1))
  (make-segment (make-vect 0.5 1) (make-vect 1 0.5))
  (make-segment (make-vect 1 0.5) (make-vect 0.5 0)))))
(inspect (log-painter diamond-painter "2-49-diamond"))

; ______________________________________________________________
; d. The 'wave' painter.
; ______________________________________________________________
; ???
; Really not sure what we are supposed to do here.
; Either we are supposed to make an approximation of the curvy
;  figure using segments (not going to do that) or we implement
;  Bezier curves using segments (still we would have to 
;  manually type out bunch of bezier curves).

