; 1. Building Abstractions with Procedures
; Exercise 1.20:
; The process that a procedure generates is of course dependent
;  on the rles used by the interpreter.  As an example, consider
;  the iterative 'gcd' procedure given above.  Suppose we were
;  to interpret this procedure using normal-order evaluation,
;  as discussed in [Section 1.1.5]. 
; (The normal-order-evaluation rule for 'if' is described in
;  [Exercise 1.5].)
; Using the substitution method (for normal order), illustrate
;  the process generated in evaluating (gcd 206 40) and indicate
;  the 'remainder' operations that are actually performed.
; How many 'remainder' operations are actually performed in the
;  normal-order evaluation of (gcd 206 40)?
; In the applicative-order evaluation?
; ______________________________________________________________
#lang sicp
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
; For
(gcd 206 40)
; = (gcd 6, 4)
; = (gcd 4, 2)
; = (gcd 2, 0)
; = 2
; Normal order (fully expand then reduce)
; reduce on 'if' until boolean 
; (not going to write out the whole process)
(gcd A0 B0)
; r1 = (rem 206 40)
; r2 = (rem 40 r1)
; r3 = (rem r1 r2)
; r4 = (rem r2 r3)

; (gcd 206 40)
; -> (if (= 40 0) 206 (gcd 40 r1))
; 1 rems (compute r1)
; 
; (gcd 40 r1)
; -> (if (= r1 0) 40 (gcd r1 r2))
; 1 + 1 = 2 rems (compute rem 40 r1)

; (gcd r1 r2)
; -> (if (= r2 0) r1 (gcd r2 r3))
; 1 + 1 + 2 = 4 rems (compute rem r1 r2)

; (gcd r2 r3)
; -> (if (= r3 0) r2 (gcd r3 r4))
; 1 + 2 + 4 = 7 rems (compute rem r3 r4)
; 
; (gcd r3 r4)
; -> (if (= r4 0) r3 ...)
; 4 rems (compute r3)

; Answer: 1 + 2 + 4 + 7 + 4 = 18 remainder ops


; Applicative order (evaluate arguments, then apply)
(gcd 40 (remainder 206 40)) ; 1st 'remainder'
(gcd 40 6)
(gcd 6 (remainder 40 6)) ; 2nd 'remainder'
(gcd 6 4)
(gcd 4 (remainder 6 4)) ; 3rd 'remainder'
(gcd 4 2)
(gcd 2 (remainder 4 2)) ; 4th 'remainder'
(gcd 2 0) ; 2
; Answer: 4 remainder ops
