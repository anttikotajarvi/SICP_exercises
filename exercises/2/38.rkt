; SICP 2.2.3
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Sequences as Conventional Interfaces
; Exercise 2.38:
; The 'accumulate' procedure is also known as 'fold-right', 
;  because it combines the first element of the sequence with 
;  the result of combining all the elements to the right.
#lang sicp
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))
; What are the values of:
; ______________________________________________________________
(#%require "../lib.rkt")
(define fold-right accumulate)
(fold-right / 1 (list 1 2 3))     ; 3/2
(fold-left / 1 (list 1 2 3))      ; 1/6
(fold-right list nil (list 1 2 3))  ; (1 (2 (3 ())))
(fold-left list nil (list 1 2 3))   ; (((() 1) 2) 3)

; ______________________________________________________________
; Give property that 'op' should satisfy to guarantee that 
;  'fold-right' and 'fold-left' will produce the same values
;  for any sequence.
; ______________________________________________________________
; 'op' should be associative, like + or *.