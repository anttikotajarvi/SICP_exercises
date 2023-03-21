; 1. Building Abstractions with Procedures
(load "_dependencies.scm")
; Exercise 1.8
; Newton’s method for cube roots is based on
;  the fact that if y is an approximation to the cube root of x,
;  then a better approximation is given by the value
    x/y^2 + 2y
    __________
        3

; Use this formula to implement a cube-root procedure anal-
;  ogous to the square-root procedure. (In Section 1.3.4 we will
;  see how to implement Newton’s method in general as an
;  abstraction of these square-root and cube-root procedures.)
;____________________________________________________________

(define (improve-cubic guess x) 
  (/ (+ (/ x 
           (square guess)) 
        (* 2 guess))
      3))

(define (good-enough? guess x)
    (< (abs (- (cube guess) x)) 
       (/ guess 1000)))

(define (cube-root-iter guess x)
    (if (good-enough? guess x)
        guess
        (cube-root-iter (improve-cubic guess x) x)))

(define (cube-root x)
  	(cube-root-iter 1.0 x))

(cube-root 64)
;=> 4.000017449510739
