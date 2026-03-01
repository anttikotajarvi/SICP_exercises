; 1. Building Abstractions with Procedures
; Exercise 1.18:
; Using the results of [Exercise 1.16] and [Exercise 1.17],
;  devise a procedure that generates an iterative process
;  for multiplying two integers in terms of adding, doubling,
;  and halving and uses a logarithmic number of steps.
; ______________________________________________________________
#lang sicp
(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (fast-mult a b)
  (define (iter a b c)
    (cond ((= b 0) c)
          ((even? b) (iter (double a) (halve b) c))
          (else (iter a (- b 1) (+ c a)))))
  (iter a b 0))

(fast-mult  4 7)
; (iter 4 7 0)
; (iter 4 6 4)
; (iter 8 3 4)
; (iter 8 2 12)
; (iter 16 1 12)
; (iter 16 0 28)
; 28
