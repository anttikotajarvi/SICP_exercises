; 1. Building Abstractions with Procedures
; Exercise 1.17:
; The exponentiation algorithms in this section are based on
;  performing exponentiation by means of repeated multiplication.
; In a similiar way, one can perform integer multiplication by 
;  means of repeated addition.  The following multiplication
;  procedure (in which it is assumed that our language can only
;  add, not multiply) is analogous to the expt procedure:
#lang sicp
(define (* a b)
    (if (= b 0)
        0
        (+ a (* a (- b 1)))))

; This algorithm takes a number of steps that is linear in b.
; Now suppose we include, together with addition, operations
;  'double', which doubles an integer, and 'halve', which
;  divides an (even) integer by 2.  Using these, design a
;  multiplication procedure analogous to fast-expt that uses
;  a logarithmic number of steps.
; ______________________________________________________________

(define (double x) (+ x x))
(define (halve x) (/ x 2))
; The values here could be transformed in place instead of 
;  with deferred ops but this establishes parity with the 
;  fast-expt procedure.
(define (fast-mult a b)
    (cond ((= b 0) 0)
          ((even? b) (double (fast-mult a (halve b))))
          (else (+ a (fast-mult a (- b 1))))))

(fast-mult 7 8)
; 2(7*4)
; 2(2(7*2))
; 2(2(2(7*1)))
; 2(2(2(7 + (7*0))))
; 2(2(2(7 + 0)))
; 2(2(2(7)))
; 2(2(14))
; 2(28)
; 56

