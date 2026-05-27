#lang sicp
(#%require "./exercises/lib.rkt")

(define (make-rational n d)
  ((get 'make 'rational) n d))

(#%provide make-rational)

(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))

  (define (make-rat n d)
    (let ([g (gcd n d)])
      (cons (/ n g) (/ d g))))

  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))

  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))

  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))

  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))

	;; predicates
  (define (equ?-rat x y)
    (and (= (numer x) (numer y))
         (= (denom x) (denom y))))

	(define (=zero?-rat x)
		(= x 0))

  ;; interface
  (define tag 'rational)

  (put 'add '(rational rational) (wrap tag add-rat))
  (put 'sub '(rational rational) (wrap tag sub-rat))
  (put 'mul '(rational rational) (wrap tag mul-rat))
  (put 'div '(rational rational) (wrap tag div-rat))

  (put 'equ?-rat '(rational rational) equ?-rat)
  (put ''=zero?-rat '(rational rational) '=zero?-rat)


  (put 'make 'rational
       (lambda (n d) (attach-tag tag (make-rat n d))))

  'done)


(#%provide install-rational-package)