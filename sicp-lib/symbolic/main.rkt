#lang sicp

;; SICP 2.3.2: Example: Symbolic Differentiation.
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num) (and (number? exp) (= exp num)))

(define (make-sum a1 . rest)
  (define a2
    (if (null? (cdr rest))
        (car rest)
        (apply make-sum (car rest) (cdr rest))))

  (cond [(=number? a1 0) a2]
        [(=number? a2 0) a1]
        [(and (number? a1)
              (number? a2))
          (+ a1 a2)]
        [else (list '+ a1 a2)]))
(define (sum? x) (and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend p)
  (let ([rest (cddr p)])
    (if (null? (cdr rest))
        (car rest)
        (apply make-sum rest))))

(define (make-product m1 . rest)
  (define m2
    (if (null? (cdr rest))
        (car rest)
        (apply make-product (car rest) (cdr rest))))

  (cond [(or (=number? m1 0) (=number? m2 0)) 0]
        [(=number? m1 1) m2]
        [(=number? m2 1) m1]
        [(and (number? m1) (number? m2)) (* m1 m2)]
        [else (list '* m1 m2)]))
(define (product? x) (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplicand p)
  (let ([rest (cddr p)])
    (if (null? (cdr rest))
        (car rest)
        (apply make-product rest))))

(define (make-expt base exp)
  (cond [(=number? exp 0) 1]
        [(=number? exp 1) base]
        [(=number? base 0) 0]
        [(=number? base 1) 1]
        [(and (number? base) (number? exp)) (expt base exp)]
        [else (list '^ base exp)]))
(define (expt? s) (eq? '^ (car s)))
(define (base s) (cadr s))
(define (exponent s) (caddr s))

(#%provide variable?
           same-variable?
           =number?
           make-sum
           sum?
           addend
           augend
           make-product
           product?
           multiplier
           multiplicand
           make-expt
           expt?
           base
           exponent)
