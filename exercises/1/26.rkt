#lang sicp
; 1. Building Abstractions with Procedures
; Exercise 1.26:
; Louis Reasoner is having great difficulty doing [Exercise 1.24].
; His 'fast-prime?' test seems to run more slowly than his
;  'prime?' test. Louis calls his friend Eva Lu Ator over to help.
; When they examine Louis's code, they find that he has rewritten
;  the 'expmod' procedure to use explicit multiplication, rather
;  than calling square:
(define (expmod base exp m
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m)
                    m))
        (else 
          (remainder (* base 
                        (expmod base (-1 exp 1) m))
                      m))))))
; "I don't see what difference that could make," says Louis.
; "I do." says Eva. "By wriing the procedure like that, you
;  you have transformed the O(log n) process into an O(n)
;  process." Explain.
; ______________________________________________________________

; Compare with correct version:
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
          (remainder 
            (square (expmod base (/ exp 2) m))
            m))x
        (else 
          (remainder
            (* base (expmod base (- exp 1) m))
            m))))

; Everystep halves n, so n hits 0 after log_2 n steps

; Louis's version:
; Each level halves n so depth is still log_2 n
;  but each call splits into 2 calls:
; number of calls at level k: 2^k

; depth = log_2 n
; leaves at bottom = 2^depth = 2^(log_2 n) = n
