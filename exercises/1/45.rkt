; 1. Building Abstractions with Procedures
; Exercise 1.45:
; We saw in [Section 1.3.3] that attempting to compute square
;  roots by naively finding a fixed point of y |-> x/y does not
;  converge, and that this can be fixed by average damping.
; The same method works for finding cube roots as fixed points
;  of the average-damped y |-> x/y^2.
; Unfortunately, the process does not work for fourth roots---a
;  single average damp is not enough to make a fixed-point
;  search for y |-> x/y^3 converge.
; On the other hand, if we average damp twice (i.e., use the
;  average damp of the average damp of y |-> x/y^3) the
;  fixed-point search *does* converge.
; Do some experiments to determine how many average damps are
;  required to compute n^th roots as a fixed-point search based
;  upon repeated average damping of y |-> x/y^(n-1).
; Use this to impement a simple procedure for computing n^th
;  roots using 'fixed-point', 'average-damp', and the 'repeated'
;  procedure of [Exercise 1.43].
; Assume that any arithmetic operations you need are available
;  as primitives.
; ______________________________________________________________
#lang sicp
(#%require "_dependencies.rkt")
(define log2 (log-base 2))

(define (damps n)
  (floor (log2 n)))
; guessed log_2 n by intuition
; flooring log_2 seems to give the smallest necessary damps
;  to converge, this can be verified by damps - 1

(define (nth-root x n)
  (define (f y)
    (/ x (pow y (- n 1))))
  (fixed-point ((repeated average-damp (damps n)) f) 1.0))

(inspect (nth-root (pow 10 2) 2))
(inspect (nth-root (pow 10 3) 3))
(inspect (nth-root (pow 10 4) 4))
(inspect (nth-root (pow 10 5) 5))
(inspect (nth-root (pow 10 6) 6))
(inspect (nth-root (pow 10 7) 7))
(inspect (nth-root (pow 10 8) 8))
(inspect (nth-root (pow 10 9) 9))
(inspect (nth-root (pow 10 16) 16))
