; 1. Building Abstractions with Procedures
; Exercise 1.13
; Prove that Fib(n) is the closest integer to phi^n / sqrt(5),
;  where phi = (1 + sqrt(5)) / 2.
; Hint: Let psi = (1 - sqrt(5)) / 2.
; Use induction and the definition of the Fibonacci numbers
;  (see Section 1.2.2) to prove that Fib(n) = (phi^n - psi^n) / sqrt(5).
; ________________________________________________________________________

#lang sicp
(#%require "_dependencies.rkt")

; Distance from phi^n/sqrt(5) to Fib(n) is psi^n/sqrt(5)

(define (phi) (/ (+ 1 (sqrt 5)) 2))
(define (psi) (/ (- 1 (sqrt 5)) 2))

(define (proof-smiley-face n) 
 (if (< (abs (- (/ (expt (phi) n) (sqrt 5)) (fib n))) 0.5)
     "Proof complete :)"
     "Proof failed :("))

(proof-smiley-face 10); trust me bro, just look at it.

; Binet formua for Fibonacci numbers
(define (F n)
  (/ (- (expt (phi) n) (expt (psi) n)) (sqrt 5)))

; turns out that this is just a math question so:

; Prove Binet formula by induction
; F(n + 1) = F(n) + F(n - 1)
; Candidate: G(n) = (phi^n - psi^n) / sqrt(5)
; ∀ n, G(n) = F(n)

; Base cases:
; G(0) = (phi^0 - psi^0) / sqrt(5) 
;      = 0 = F(0)
; G(1) = (phi^1 - psi^1) / sqrt(5) 
;      = 1 = F(1)

; Inductive step ( show that G(n + 1) = G(n) + G(n - 1) ):

; G(n + 1) = phi^(n + 1) - psi^(n + 1)
;           _________________________
;                  sqrt(5)

; Since phi and psi satisfy x^2 = x + 1: (*)
; G(n + 1) = ( phi^n + phi^(n - 1) ) - ( psi^n + psi^(n - 1) )
;           __________________________________________________
;                          sqrt(5)

; group terms:
; G(n + 1) = ( phi^n - psi^n ) + (phi^(n - 1) - psi^(n - 1) )
;            _________________   __________________________ 
;                  sqrt(5)                sqrt(5)
; G(n + 1) = G(n) + G(n - 1)
; Therefore, by induction, G(n) = F(n) for all n.


; Prove that Fib(n) is the closest integer to phi^n / sqrt(5):
; Since Fib(n) = F(n) = (phi^n - psi^n) / sqrt(5)

; F(n) = phi^n / sqrt(5) - psi^n / sqrt(5)
; phi^n / sqrt(5) = F(n) + psi^n / sqrt(5)

; Difference between phi^n / sqrt(5) and F(n) is:
; phi^n / sqrt(5) - F(n) = psi^n / sqrt(5)
; |phi^n / sqrt(5) - F(n)| = |psi^n / sqrt(5)|

; Since |psi| < 1, |psi^n| <= 1 for all n >= 0 so:
; |psi|^n / sqrt(5) <= 1 / sqrt(5)
; 1 / sqrt(5) < 1/2

; Therefore, |phi^n / sqrt(5) - F(n)| < 1/2

; _________________________________________
;[*]: Phi and psi both satisfy: x^2 = x + 1
; Algebraic proof:
; phi^2 = ((1 + sqrt(5)) / 2)^2
;       = (1 + 2*sqrt(5) + 5) / 4
;       = (6 + 2*sqrt(5)) / 4
;       = (3 + sqrt(5)) / 2
;
; phi + 1 = (1 + sqrt(5)) / 2 + 1
;         = (1 + sqrt(5)) / 2 + 2/2
;         = (3 + sqrt(5)) / 2
; Therefore, phi^2 = phi + 1
; same for psi


