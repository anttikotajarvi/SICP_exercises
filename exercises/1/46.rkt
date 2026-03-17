; 1. Building Abstractions with Procedures
; Exercise 1.46:
; Several of the numerical methods described in this chapter
;  are instances of an extremely general computational strategy
;  known as _iterative improvement_.
; Iterative improvement says that, to compute something, we
;  start with an initial guess for the asnwer, test if the guess
;  is good enough, and otherwise improve the guess and continue
;  the process using the improved guess as the new guess.
; Write a procedure 'iterative-improve' that takes two
;  procedures as arguments: a method for telling whether a guess
;  is good enough and a methood for improving a guess.
; 'iterative-improve' should return as its value a procedure
;  that takes a guess as argument and keeps improving the guess
;  until it is good enough.
; Rewrite the 'sqrt' procedure of [Section 1.1.7] and the
;  'fixed-point' oricedure of [Section 1.3.3] in terms of
;  'iterative-improve'.
; ______________________________________________________________
#lang sicp
(#%require "_dependencies.rkt")
(define (iterative-improve good-enough? improve)
  (lambda (guess)
    (define (iter guess)
      (if (good-enough? guess)
          guess
          (iter (improve guess))))
    (iter guess)))

(define (sqrt x)
  (define tolerance 0.00001)
  (define (good-enough? guess)
    (< (abs (- (* guess guess) x)) tolerance))
  (define (improve guess)
    (/ (+ guess (/ x guess)) 2))

  ((iterative-improve good-enough? improve) 1.0))

(sqrt 25)

(define (fixed-point f first-guess)
  (define tolerance 0.0001)
  (define (close-enough? guess)
    (< (abs (- guess (f guess))) tolerance))

  ((iterative-improve close-enough? f) first-guess))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)

; Writing these functions threw me for a loop since I was trying to 
;  write it so that the iterator function would only be generated once for the
;  base function but that doesnt work since they depend on the argument
;  from the base function

