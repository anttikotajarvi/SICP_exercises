; 1. Building Abstractions with Procedures
; Exercise 1.35:
; Show that the golden ratio phi (Section 1.2.2) is fixed point
;  of the transformation x |-> 1 + 1/x, and use this fact to 
;  compute phi by means of the 'fixed-point' procedure. 
; ______________________________________________________________

; We know the golden ratio:
; phi = (1 + sqrt(5))/2

; Square phi
; phi^2 = ( (1 + sqrt(5)) / 2 )^2 
; phi^2 = (6 + 2sqrt(5)) / 4        ; expand numerator
; phi^2 = (3 + sqrt(5)) / 2         ; simplify

; Compute phi + 1
; phi + 1 = (1 + sqrt(5)) / 2 + 1   
;         = (1 + sqrt(5)) / 2 + 2/2 ; replace 1 with 2/2
;         = (3 + sqrt(5)) / 2

; So phi + 1 = phi^2
; Divide both by phi
; phi = 1 + 1/phi
; same as fixed point equation
; x = 1 + 1/x

;; Compute phi with the fixed point procedure
#lang sicp
(#%require "_dependencies.rkt")
(define tolerance 0.00001)
(define (fixed-point f first-guess) 
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
      tolerance))

  (define (try guess) 
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next 
          (try next))))
  
  (try first-guess))

(inspect (fixed-point (lambda (x) (+ 1 (/ 1 x)))
                      1.0))
