; 1. Building Abstractions with Procedures
; Exercise 1.40:
; Define a procedure 'cubic' that can be used together with the 
;  'newtons-method' procedure in expressions of the form
; (newtons-method (cubic a b c) 1)
;  to aproximate zeros of the cubic: x^3 + ax^2 + bx + c
; ______________________________________________________________
#lang sicp
(#%require "_dependencies.rkt")

(define (cubic a b c)
  (lambda (x) (+ (* x x x)
                 (* a (* x x))
                 (* b x)
                 c)))
(display "For x^3 - 1") (newline)
(inspect (newtons-method (cubic 0 0 -1) 10))