; SICP 2.1.1 
; Chapter: Building Abstractions with Data
; Section: Introduction to Data Abstraction
; Subsection: Example: Arithmetic Operations for Rational Numbers
; Exercise 2.1:
; Define a better version of 'make-rat' that handles both
;  positive and negative arguments.
; 'make-rat' should normalize the sign so that if the rational
;  number is positive, both the numerator and denominator are
;  positive, and if the rational number is negative, only the 
;  numerator is negative.
; ______________________________________________________________
#lang sicp
; The rule is:
; 1/2 -> 1/2
; -1/2 -> -1/2
; 1/-2 -> -1/2
; -1/-2 -> 1/2
(define (make-rat n d)
  (let ((g (gcd n d)))
    (let ((n (/ n g))
          (d (/ d g)))
      (if (< d 0)
          (cons (- 0 n) (- 0 d))
          (cons n d)))))

(make-rat 1 -3)