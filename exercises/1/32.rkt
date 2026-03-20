; 1. Building Abstractions with Procedures
; Exercise 1.32:
; a. Show that 'sum' and 'product' ([Ecercise 1.31]) are both 
;     special cases of a still more general notion called 
;     'accumulate' that combines a collection of terms, using
;     some general accumulation function:
;     (accumulate combiner null-value term a next b)
;    'accumulate' takes as arguments the same term and range
;     specifications as sum and product, together with a
;     'combiner' procedure (of two arguments) that specifies how
;     the current term is to be combined with the accumulation
;     of the preceding terms and a 'null-value' that specifies
;     what base value to use when the terms run out. 
;    Write 'accumulate' and show how sum and product can both be
;     defined as simple calls to 'accumulate'.
; b. If your 'accumulate' procedure generates a recursive 
;     process, write on that generates an iterative process.
;    If it generates an iterative process, write on that 
;     generates a recursive process.
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")
; Recursive
(define (accumulate-rec combiner null-value term a next b)
  (define (rec a)
    (if (> a b) null-value
                (combiner (term a)
                          (rec (next a)))))
  (rec a))

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b) result
                (iter (next a) 
                      (combiner (term a)
                                 result))))
  (iter a null-value))

; Test
(define (sum-rec term a next b) 
  (accumulate-rec + 0 term a next b))
(define (sum-iter term a next b)
  (accumulate-iter + 0 term a next b));

; Trying out an inspect macro
(display "Sum of integers 1..0 \n")
(inspect (sum-rec + 1 inc 10))
(inspect (sum-iter + 1 inc 10))

(define (product-rec f a b)
  (accumulate-rec * 1 f a inc b))

(define (product-iter f a b)
  (accumulate-iter * 1 f a inc b))

(display "Factorial of 4 \n")
(inspect (product-rec identity 1 4))
(inspect (product-iter identity 1 4))

