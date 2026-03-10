; 1. Building Abstractions with Procedures
; Exercise 1.37:
; a. An infinite _continued fraction_ is an expression of the 
;     form:
;    f =         N_1
;        _____________________
;        D_1 +       N_2 
;               ______________
;               D_2 +    N_3
;                     _________
;                     D_3 + ...
;
;    As an example, one can show that the infinite continued
;     function expansion with the N_i and the D_i all equal to
;     1 produces 1/phi, where phi is the holden ratio (described
;     in Section 1.2.2).
;    One way to approximate infinite continued fraction is to 
;     truncate the expansion after a given number of terms.
;    Such a truncation--- a so-called "k-term finite continued
;     fraction"---has the form:
;            N_1
;     _____________________
;     D_1 +       N_2 
;        ..  ______________
;         .     N_k / D_k
;
;    Suppose that 'n' and 'd' are procedures of one argument 
;     (the term index i) that return the N_i and D_i of the 
;     terms of the continued fraction. 
;    Define a procedure 'cont-frac' such that evaluating 
;     (cont-fract n d k) computes the value of the k-term finite
;     continued fraction.
;    Check your procedure by approximating 1/phi using
;    (cont-fract (lambda (i) 1.0)
;                (lambda (i) 1.0)
;                k)
;     for successive values of k. 
;    How large must you make k in order to get an approximation
;     that is accurate to 4 decimal places?
;
; b. If your 'cont-frac' procedure generates a recursive process,
;     write on that generates an iterative process.  If it 
;     generates an iterative process, write one that generates a 
;     recursive process.
; ______________________________________________________________

#lang sicp
; Recursive
(define (cont-frac-rec n d k)
  (define (rec i )
    (if (= i k) (/ (n i) (d i))
                (/ (n i)
                  (+ (d i) 
                      (rec (inc i))))))
  (rec 1))

; Iterative
(define (cont-frac-iter n d k)
  (define (iter i result)
    (if (= i 0) 
        result
        (iter (dec i)
              (/ (n i) 
                 (+ (d i) result)))))
  (iter k 0))

(define (test-rec k)
  (cont-frac-rec (lambda (i) 1.0)
                 (lambda (i) 1.0)
                 k))

(define (test-iter k)
  (cont-frac-iter (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  k))

(#%require "_dependencies.rkt")
(display "Recursive test: \n")
(inspect (test-rec 1))
(inspect (test-rec 2))
(inspect (test-rec 3))
(inspect (test-rec 10))

(display "Iterative test: \n")
(inspect (test-iter 1))
(inspect (test-iter 2))
(inspect (test-iter 3))
(inspect (test-iter 10))

