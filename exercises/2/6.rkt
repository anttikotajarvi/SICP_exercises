; SICP 2.1.3
; Chapter: Building Abstractions with Data
; Section: Introduction to Data Abstraction
; Subsection: What is Meant by Data?
; Exercise 2.6:
; Incase representing pairs as procedures wasn't mind-boggling
;  enough, consider that, in a language that can manipulate
;  procedures, we can get by without numbers (at least insofar
;  as nonnegative integers are concerned) by implementing 0 and 
;  the operation of adding 1 as
#lang sicp
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; This representation is known as Church numerals, after its 
;  inventor, Alonzo Church, the logician who inveted the lambda-
;  calculus.
; Define 'one' and 'two' directly (not in terms of 'zero' and 
;  'add-1'). 
; (Hint: Use substitution to evaluate (add-1 zero))).
; Give a direct definition of the addition procedure + (not in
;  terms of repeated application of 'add-1').
; ______________________________________________________________

; So 
; 0 := \f.\x. x
; 1 := \f.\x. f x
; 2 := \f.\x. f (f x)
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))

; Addition without succ/add-1 works is:
; \a.\b.\f.x. a f (b f x)
; or: apply f b times to x, and then apply f a more times
(define addition
  (lambda (a)
    (lambda (b)
      (lambda (f)
        (lambda (x)
          ((a f) ((b f) x)))))))

; Test
(define three ((addition one) two))
(#%require "../lib.rkt")
(inspect ((three inc) 0))
