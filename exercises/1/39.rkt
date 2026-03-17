; 1. Building Abstractions with Procedures
; Exercise 1.39:
; A continued fraction representation of the tangent function
;  was published in 1770 by the German mathematician J.H Lambert:
;    tan x =      x
;        _____________________
;        1 -       x^2 
;               ______________
;                3 -     x^2
;                     _________
;                     5 - ...
;
;  where x is in radians.  Define a procedure (tan-cf x k) that
;  computes an approximation to the tangent function based on 
;  Lambert's formula.  k specifies the number of terms to 
;  compute, as in [Exercise 1.37].
; ______________________________________________________________
#lang sicp
(#%require "_dependencies.rkt")

(define (tan-cf x k)
  (define x^2 (square x))
  (define (iter i result)
    (define o_i (- (* 2 i) 1)) 
    (if (= i 1) 
        (/ x (- 1 result)) ; top case
        (iter (dec i)
              (/ x^2 
                 (- o_i result)))))
  (iter k 0))
(inspect (tan-cf 0 10))
(inspect (tan 0))

(inspect (tan-cf 0.2 10))
(inspect (tan 0.2))

(inspect (tan-cf 0.5 10))
(inspect (tan 0.5))

(inspect (tan-cf 1.0 10))
(inspect (tan 1.0))

(display "Convergence \n")
(inspect (tan-cf 1.0 1))  ; rough
(inspect (tan-cf 1.0 2))
(inspect (tan-cf 1.0 8))
(inspect (tan-cf 1.0 15))
(inspect (tan-cf 1.0 20))
(inspect (tan 1.0))        ; reference
