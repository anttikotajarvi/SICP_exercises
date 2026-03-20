; 1. Building Abstractions with Procedures
; Exercise 1.38:
; In 1737, the Swiss mathematician Leonhard Euler published a
;  memoir "De Fractionibus Continuis", which included a 
;  continued fraction expansion for 'e - 2', where 'e' is the 
;  base of the natural logarithms.  In this fraction, the N_i
;  are all 1, and the D_i are successively 1, 2, 1, 1, 4, 1, 1, 
;  6, 1, 1 , 8, ... .  
; Write a program that uses your cont-fract procedure from 
;  [Exercise 1.37] to approximate e, based on Euler's expansion.
; ______________________________________________________________

#lang sicp
(#%require "../lib.rkt")

(define (N i) 1)

;          1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ...
; Index    1  2  3  4  5  6  7  8  9  10 11
; nth.spc.    1        2        3        4


(define (D i)
  (define (special? n)
    (= (remainder n 3) 2))
  
  (if (special? i) 
      (* 2
        (floor (/ (+ i 1) 
                  3)))
      1))
  
(define (test-D k)
  (define (iter i)
    (if (<= i k)
        (begin (display (D i))
               (display " ")
               (iter (inc i)))))
  (iter 1)
  (newline))

(test-D 11)

(define (e k) 
  (+ 2 (cont-frac N D k)))

(inspect (e 10))
(inspect (e 30))