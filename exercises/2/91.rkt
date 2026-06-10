; SICP 2.5.3
; Chapter: Building Abstractions with Data
; Section: Systems with Generic Operations
; Subsection: Example: Symbolic Algebra
; Exercise 2.91: 
; A univariate polynomial can be divided by another one to 
;  produce a polynomial quotient and a polynomial remainder.
; For example,
;     x^5 - 1
;     _______ = x^3 - x, remainder x - 1
;     x^2 - 1 
; Division can be performed via long division: divide the 
;  highest-order term of the dividend by the highest-order term
;  of the divisor.  The result is the first term of the quotient.
; Next, multiply the result by the divisor, subtract that from 
;  the dividend, and produce the rest of the answer by 
;  recursively dividing the difference by the divisor.
; Stop when the order of the divisor exceeds the order of the
;  dividend and declare the dividend to be the remainder.
; If the dividend ever becomes zero, return zero as both 
;  quotient and remainder.
;
; We can design a 'div-poly' procedure on the model of 'add-poly'
;  and 'mul-poly'.
; The procedure checks to see if the two polys have the same 
;  variable.  If so, 'div-poly' strips off the variable and 
;  passes the same problem to 'div-terms', which performs the 
;  division operation on term lists.
; 'div-poly' finally reattaches the variable to the result 
;   supplied by 'div-terms'.
; It is convenient to design 'div-terms' to compute both the 
;  quotient and the remainder of a division.
; 'div-terms' can take two term lists as arguments and return a
;  list of the quotient term list and the remainder term list.
;
; Complete the following definition of 'div-terms' by filling in
;  the missing expressions.  
; Use this to implement 'div-poly', which takes two polys as 
;  arguments and returns a list of the quotient and the 
;  remainder polys.
#lang sicp
(#%require sicp-lib/polynomial)
(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (list (the-empty-termlist) (the-empty-termlist))
      (let ([t1 (first-term L1)]
            [t2 (first-term L2)])
        (if (> (order t2) (order t1))
            (list (the-empty-termlist) L1)
            (let* ([new-term 
                    (make-term (div (coeff t1) (coeff t2))
                               (- (order t1) (order t2)))]
                   [term-list 
                    (adjoin-term new-term (the-empty-termlist))]
                   [new-dividend 
                    (sub-terms L1
                               (mul-terms term-list L2))]
                   [rest-of-result 
                     (div-terms new-dividend L2)])
              (list (adjoin-term new-term
                                 (car rest-of-result))
                    (cadr rest-of-result)))))))
; ______________________________________________________________
; For:
;     x^5 - 1
;     _______ 
;     x^2 - 1 
;
; "Divide highest-order term of dividend by the highest-order 
;  term of the divisor"
;     x^5 / x^2 = x^3 ; first term of the quotient
; "Multiply the result by the divisor"
;     x^3 * (x^2 - 1) = x^5 - x^3
; "subtract that from the dividend"
;     (x^5 - 1) - (x^5 - x^3) = x^3 - 1
; "recursively dividing the difference by the divisor"
; now the division is
; x^3 - 1
; _______, and the quotient is x^3
; x^2 - 1
; etc.

; Each recursion adds a term to the quotient and the final
;  recursion also gives the remainder.

; For 'div-poly' we will:
; 1. Ensure arguments have the same variable.
; 2. Ensure divisor not zero
; 3. Exctract the term lists.
; 4. Call 'div-terms'
; 5. Wrap the quotient and the remainder term lists back into 
;    the polynomiasls. 

; Test: (will not work since the put/get shit is still undefined)
(define p1
  (make-poly 'x
             (list (make-term 5 1)
                   (make-term 0 -1))))

(define p2
  (make-poly 'x
             (list (make-term 2 1)
                   (make-term 0 -1))))

(define result (div-poly p1 p2))
(define quotient (car result))
(define remainder (cadr result))

(display "quotient" quotient)
(display "remainder" remainder)
