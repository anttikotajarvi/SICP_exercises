; 1. Building Abstractions with Procedures
; Exercise 1.44:
; The idea of _smoothing_ a function is an important concept in
;  signal processing.
; If 'f' is a function and 'dx' is some small number, then the 
;  smoothed version of f is the function whose value at a point 
;  x is the average of f(x - dx), f(x), and f(x + dx).
; Write a procedure 'smooth' that takes as input a procedure
;  that computes f and returns a procedurethat computes a 
;  smoothed f.  It is sometimes valuable to repeatedly smooth a 
;  function (that is, smooth the smoothed function, and so on)
;  to obtain the _n-fold_ smoothed function of any given 
;  function using 'smooth' and 'repeated' from [Exercise 1.43].
; ______________________________________________________________
#lang sicp

(define (smooth f)
  (lambda (x dx) 
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
        3)))
        