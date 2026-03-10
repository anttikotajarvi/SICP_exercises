; 1. Building Abstractions with Procedures
; Exercise 1.34:
; Suppose we define the procedure
;  (define (f g) (g 2))
; Then we have
;  (f square)
;  4
;  (f (lambda (z) (* z (+ z 1))))
;  6
; What happens if we (perversly) ask the interpreter to 
;  evaluate the combination of (f f)? Explain.
; ______________________________________________________________
#lang sicp
(define (f g) (g 2))

; lets try it 
(f f)
; "not a preocedure; expected a procedure that can be applied to 
;   arguments"

; (f f)
; (f 2)
; (2 2) breaks here?

; The purpose of this exercise will propably be clear in the
;  next chapter.