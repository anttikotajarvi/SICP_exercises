; 1. Building Abstractions with Procedures
; Exercise 1.29:
; Simpson's Rule is a more accurate method of numerical
;  integration than the method illustrated above.
; Using Simpson's Rule, integral of a function 'f' between
;  a and b is approximated as:
; h/3(y_0 + 4y_1 + 2y_2 + 4y_3 + 2y_4 + ... + 2y_(n-2) + 4y_(n-1) + y_n).
;  where h = (b - a)/n, for some even integer n, and 
;  y_k = f(a + kh). (Increasing n increases the accuracy of the 
;  approximation.)
; Define a procedure that takes as arguments f, a, b and n and 
;  returns the value of the integral, computed using Simpson's
;  Rule.
; Use your procedure to integrate a cube between 0 and 1 (with
;  n = 100 and n = 1000), and compare the results to those of
;  the integral procedure shown above.
; ______________________________________________________________
#lang sicp

; The books sum procedure
(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))

(define (simpsons f a b n)
  (define h 
    (/ (- b a) n))
  
  (define (y_k k)
    (f (+ a (* k h))))

  (define (weight k) 
    (if (even? k) 2 4))

  (define (term k)
    (* (weight k) (y_k k)))

  (* (/ h 3)
     (+ (y_k 0)
        (sum term 1 inc (- n 1))
        (y_k n))))

(define (cube x) (* x x x))

(simpsons cube 0 1 100)     ; 1/4
(simpsons cube 0 1.0 100)   ; 0.24999999999999992
(simpsons cube 0 1.0 1000)  ; 0.2500000000000003

; Comparing with the books definite integral approximation:
(define (integral f a b dx)
  (define (add-dx x)
    (+ x dx))
  
  (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(integral cube 0 1 0.01)    ; 0.24998750000000042
(integral cube 0 1 0.001)   ; 0.249999875000001



  