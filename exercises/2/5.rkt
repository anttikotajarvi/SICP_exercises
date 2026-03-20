; SICP 2.1.3
; Chapter: Building Abstractions with Data
; Section: Introduction to Data Abstraction
; Subsection: What is Meant by Data?
; Exercise 2.5:
; Show that we can represent pairs of nonnegative integers using 
;  only numbers and arithmetic operations if represent the pair 
;  'a' and 'b' as the integer that is the product 2^a3^b.
; Give the corresponding definitions of the procedures cons, 
;  car and cdr.
; ______________________________________________________________

; Test
; For a = 2 and b = 3
; pair = 2^2 * 3^3
;      = 4 * 27 = 108
; For a = 1 and b = 2
; pair = 2^1 * 3^2
;      = 2 * 9 = 18

; Had to look up how to calculate this and its:
; and a is how many times you can divide evenly by 2 
; and b is how many times you can divide evenly by 3
; so counting factors
#lang sicp

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (count-factors n p)
  (define (iter n count)
    (if (= (remainder n p) 0)
        (iter (/ n p) (inc count))
        count))
  (iter n 0))

(define (car z)
  (count-factors z 2))
(define (cdr z)
  (count-factors z 3))

(#%require "../lib.rkt")
(inspect (car (cons 3 4)))
(inspect (cdr (cons 3 4)))
