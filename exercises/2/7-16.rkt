; SICP 2.1.4
; Chapter: Building Abstractions with Data
; Section: Introduction to Data Abstraction
; Subsection: Extended Exercise: Interval Arithmetic
; ______________________________________________________________
#lang sicp
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
       ((p2 (* (lower-bound x) (upper-bound y)))
       ((p3 (* (upper-bound x) (lower-bound y)))
       ((p4 (* (upper-bound x) (upper-bound y))))
  (make-interval (min p1 p2 p3 p4)
                 (max p1 p2 p3 p4)))))))

(define (div-interval-deprecated x y)
  (mul-interval 
    x
    (make-interval (/ 1.0 (upper-bound y))
                   (/ 1.0 (lower-bound y)))))
; ______________________________________________________________
; Exercise 2.7:
; Alyssa's program is incomplete because she has not specified
;  the implementation of the interval abstraction. 
; Here is the definition of the interval constructor:
(define (make-interval a b) (cons a b))
; Define selectors upper-bound and lower-bound to complete the
;  implementation.
; ______________________________________________________________
(define lower-bound car)
(define upper-bound cdr)
; ______________________________________________________________
; Exercise 2.8:
; Using reasoning analogous to Alyssa's, describe how the 
;  difference of two intervals may be computed.
; Define a corresponding subtraction procedure, called 
; 'sub-interval'.lang
; ______________________________________________________________
; for lower-bound we want smallest possible value:
;  lower-bound x - upper-bound y
; for upper-bound we want the largest possible:
;  upper bound x - lower bound y
; So [1, 4] - [3, 5] should be:
;   [-4, 1]
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))
; ______________________________________________________________
; Exercise 2.9:
; The width of an interval is half of the difference between its
;  upper and lower bounds.  
; The width is a measure of uncertainty of the number specified 
;  by the interval.  For some arithmetic operations the width of 
;  the result of combining two intervals is a function is a 
;  function only of the widths of the argument intervals. 
; Show that the width of the sum (or difference) of two 
;  intervals is a function only of the widths of the intervals 
;  being added (or subtracted). 
; Give examples to show that this is not true for multiplication
;  or division. 
; ______________________________________________________________
(define (width-interval x)
  (/ (- (upper-bound x) (lower-bound x)) 2))
; width([a, b] + [c, d]) = width([a, b]) + width([c, d])
; width([a + c, b + d]) = (b - a)/2 + (d - c)/2
; ((b + d) - (a + c))/2 = (b - a)/2 + (d - c)/2
; (b + d - a - c)/2 = (b - a)/2 + (d - c)/2
; ((b - a) + (d - c))/2 = (b - a)/2 + (d - c)/2

; ______________________________________________________________
; Exercise 2.10:
; Ben Bitdiddle, an expert systems programmer, looks over 
;  Alyssa's shoulder and comments that it is not clear what it 
;  means to divide by an interval that spans zero.
; Modify Alyssa's code to check for this condition and to signal
;  an error if it occurs.
; ______________________________________________________________
(define (spans-zero? interval)
  (and (<= (lower-bound interval) 0)
       (>= (upper-bound interval) 0)))

(define (div-interval x y)
  (if (spans-zero? y)
      (error "division by an interval that spans zero" y)
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

; ______________________________________________________________
; Exercise 2.11:
; In passing, Ben also cryptically comments:
;  "By testing the signs of the endpoints of the intervals, it 
;  is possible to break 'mul-interval' into nine cases, only one
;  of which requires more than two multiplications."
; Rewrite this procedure using Ben's suggestion.
; ______________________________________________________________
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
       ((p2 (* (lower-bound x) (upper-bound y)))
       ((p3 (* (upper-bound x) (lower-bound y)))
       ((p4 (* (upper-bound x) (upper-bound y))))
  (make-interval (min p1 p2 p3 p4)
                 (max p1 p2 p3 p4)))))))

; ______________________________________________________________
; After debugging her program, Alyssa shows it to a potential 
;  user, who complains that her program solves the wrong 
;  problem.  He wants a program that can deal with numbers 
;  represented as a center value and an additive tolerance; for
;  example, he wants to work with intervals such as 3.5 +- 0.15
;  rather than [3.35, 3.65].  Alyssa returns to her desk and 
;  fixes this problem by supplying an alternate constructor
;  and alternate selectors:
(define (make-center-width c w) 
  (make-interval (- c w) (+ c w)))
(define (center i) 
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))
; Unfortunately, most of Alyssa's users are engineers.
; Real engineering situations usually involve measurements with
;  only a small uncertainty, measured as the ratio of the width
;  of the interval to the midpoint of the interval.
; Engineers ususally specify percentage tolerances on the 
;  parameters of devices, as in the resistor specifications 
;  given earlier.
; ______________________________________________________________


