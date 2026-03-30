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
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
  (make-interval (min p1 p2 p3 p4)
                 (max p1 p2 p3 p4))))

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

; You have to create some sort of table to determine the
;  smallest and largest products by classifying x and y into groups:
;  negative, spans-zero and positive
; This seems annoying.

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
; Exercise 2.12:
; Define a cosntructor 'make-center-percent' that takes a center
;  and a percentage tolerance and produces the desired interval.
; You must also define a selector 'percent' that produces the
;  the percentage tolerance for a given interval.
; The 'center' selector is the same as the one shown above. 
; ______________________________________________________________
(define (make-center-percent c p)
  (define w (* c (/ p 100)))
  (make-interval (- c w) (+ c w)))

(define (percent i) 
  (* 100 (/ (width-interval i) (center i))))


; ______________________________________________________________
; Exercise 2.13:
; Show that under the assumption of small percentage tolerances 
;  there is a simple formula for the approximate percentage 
;  tolerance of the product of two intervals in terms of the 
;  tolerances of the factors.
; You may simplify the problem by assuming that all numbers are 
;  positive.
; ______________________________________________________________

; (1 . 2)     w0.5 c1.5 t1/3
; (2 . 4) x   w1   c3   t1/3
; (2 . 8)     w2   c6   t2/3

; (20 . 28)   w4   c24  t1/6    = 0.166...
; (3 . 13) x  w5   c8   t5/8    = 0.625
; (60 . 364)  w152 c212 t38/53  =~0.7169

; It seems t(i_1 * i_2) ~= t(i_1) + t(i_2)

; Trying small tolerance
; (199 - 201)     w1 c200 t0.005
; (499 - 501) x   w1 c500 t0.002
; (99301 . 100701) w700 c100001 t0.00699993
; Pretty close
 
; ______________________________________________________________
; After considerable work, Alyssa P. Hacker delivers her 
;  finiished system.  Several years later, after she has 
;  forgotten all about it, she gets a frenzied call from an 
;  irate user, Lem E. Tweakit.
; It seems that Lem has noticed that the formula for parallel
;  resistors can be written in two algebraically equivalent ways:
;   R_1 * R_2
;  ___________
;   R_1 + R_2
; and
;         1
;   ______________
;   1/R_1 + 1/R_2
;
; He has written the following two programs, each of which 
;  computes the parallel-resistors formula differently:
(define (par1 r1 r2) 
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
      one (add-interval (div-interval one r1)
                        (div-interval one r2)))))
; Lem complains that Alyssa's program gives different answers
;  for the two ways of computing.  This is a serious complaint.
; ______________________________________________________________
; Exercise 2.14:
; Demonstrate that Lem is right.
; Investigate the behavior of the system on a variety of 
;  arithmetic expressions.
; Make some intervals A and B, and use them in computing 
;  expressions A/A and A/B. 
; You will get the most insight by using intervals whose width
;  is a small percentage of the center value.
; Examine the results of the computation in center-percent form
;  (see [Exercise 2.12]).
; ______________________________________________________________
(define A (make-interval 2 8))
(define B (make-interval 4 10))
(#%require "../lib.rkt")
(inspect (percent (par1 A A)))
(inspect (percent (par2 A A)))
(inspect (percent (par1 A B)))
(inspect (percent (par2 A B)))
(define (par1-numbers r1 r2)
  (/ (* r1 r2)
     (+ r1 r2)))
(define (par3 r1 r2)
  (make-interval
    (par1-numbers (lower-bound r1) (lower-bound r2))
    (par1-numbers (upper-bound r1) (upper-bound r2))))

(inspect (par3 A A))
(inspect (par2 A A))
(inspect (par3 A B))
(inspect (par2 A B))

; The notes are a mess but here is waht a came away with:
; par1 is somewhat incoherent when using it with intervals,
;  it is referencing the interval twice assuming its the same "value".
; 

; ______________________________________________________________
; Exercise 2.15: 
; Eva Lu Ator, another user, has also noticed the different 
;  intervals computed by different but algebraically equivalent
;  expressions.  
; She says that a formula to compute with intervals using 
;  Alyssa's system will produce tighter error bounds if it can
;  be written in such a form that no variable that represents an
;  uncertain number is repeated.
; Thus she says, 'par2' is a "better" program for parallel 
;  resistances than 'par1'. 
; Is she right? Why?
; ______________________________________________________________


; ______________________________________________________________
; Exercise 2.16: 
; Explain, in general, why equivalent algebraic expressions may
;  lead to different answers.
; Can you devise an interval-arithmetic package that does not
;  have this shortcoming, or is this task impossible?
; (Warning: This problem is very difficult.)
; ______________________________________________________________

; Tried messing around with this, and apparently to get it to work
;  you have to implement lazy evaluation and basically a small 
;  symbolic engine. Very involved.
