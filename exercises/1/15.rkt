#lang sicp
; 1. Building Abstractions with Procedures
; Exercise 1.15:

; The sine of an angle (specified in radians) can be computed
;  by making use of the approximation of sin x ~= x if x is 
;  sufficiently small, and the trigonometric identity
;       sin x = 3 sin(x/3) - 4 sin^3(x/3)
;  to reduce the size of the argument of sin.
; (For purposes of this exercise an angle is considered 
;  "sufficiently small" if its magnitude is not greater than
;   0.1 radians.)
; These ideas are incorporated in the following procedures:

(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
    (if (not (> (abs angle) 0.1))
    angle
    (p (sine (/ angle 3.0)))))

; a. How many times is the procedure p applied when (sine 12.15)
;  is evaluated?

; b. What is the order of growth in the space and number of 
;  steps (as function of alpha) used by the process generated 
;  by the sine procedure when (sine a) is evaluated?
; ______________________________________________________________

; Answer for a: 5.
; (sine 12.15)
; (p (sine 4.05))     1.
; (p (p (sine 1.35)))     2.
; (p (p (p (sine 0.45))))   3.
; (p (p (p (p (sine 0.15))))) 4.
; (p (p (p (p (p (sine 0.05)))))) 5.
; (p (p (p (p (p (p 0.05))))))
; (p (p (p (p (p 0.1495)
; (p (p (p (p 0.4351345505)
; (p (p (p 0.9758465331678772)))
; (p (p -0.7895631144708228))
; (p -0.39980345741334)
; -0.9437875486176319

; Answer for b:
; Let k be be the number of iterations
; We stop recursing when:
;   |angle| <= 0.1
; So at k depth:
;   |a/3^k| <= 0.1
;   |a|/3^k <= 0.1

; Multiply by 3^k
;   |a| <= 0.1 * 3^k 
; Divide by 0.1
;   |a|/0.1 <= 3^k
; Same as:
;   3^k >= |a|/0.1
;   3^k >= 10|a|
; Apply log_3
;   k >= log_3(10|a|)

; Order of growth of sine for number of steps:
; The procedure makes only one recursive call and some constant work
;  so each level costs O(1) work plus recursive call.lang
; Since k levels until base case the total work is:
; steps = O(k) = theta of log|a|


; Order of growth of sines call stack depth:
; This is not tail recursion since there are deferred processes.
; Since each recursion defers one p -> the stack grows 1 per level
;  thus:
; space = O(k) = theta of log|a|

