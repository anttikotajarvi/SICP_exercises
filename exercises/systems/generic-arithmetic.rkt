#lang sicp
(#%require "../lib.rkt")

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (equ? x y) (apply-generic 'equ? x y))

(#%provide add sub mul div equ?)

;; Helpers
(define (wrap tag fn)
	(lambda (x y)
		(attach-tag tag (fn x y))))

(define (install-scheme-number-package)
  (define tag 'scheme-number)

  (put 'add '(scheme-number scheme-number) (wrap tag +))
  (put 'sub '(scheme-number scheme-number) (wrap tag -))
  (put 'mul '(scheme-number scheme-number) (wrap tag *))
  (put 'div '(scheme-number scheme-number) (wrap tag /))

  (put 'equ? '(scheme-number scheme-number) =)
	(put '=zero? '(scheme-number)
		(lambda (x) (= x 0)))

  (put 'make 'scheme-number
       (lambda (x) (attach-tag tag x)))

  'done)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(#%provide install-scheme-number-package make-scheme-number)


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

(define (make-rational n d)
  ((get 'make 'rational) n d))

(#%provide install-rational-package make-rational)


(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))


(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))

  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))

  ;; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))

  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))

  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))

  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))

	;; predicates
  (define (equ?-complex z1 z2)
    (and (= (real-part z1) (real-part z2))
         (= (imag-part z1) (imag-part z2))))

	(define (=zero?-complex z)
		(and (= (real-part z) 0)
				(= (imag-part z) 0)))

  ;; interface
  (define tag 'complex)

  (put 'add '(complex complex) (wrap tag add-complex))
  (put 'sub '(complex complex) (wrap tag sub-complex))
  (put 'mul '(complex complex) (wrap tag mul-complex))
  (put 'div '(complex complex) (wrap tag div-complex))

  (put 'equ? '(complex complex) equ?-complex)
	(put '=zero? '(complex) =zero?-complex)

  (put 'make-from-real-imag 'complex
       (lambda (x y)
         (attach-tag tag (make-from-real-imag x y))))

  (put 'make-from-mag-ang 'complex
       (lambda (r a)
         (attach-tag tag (make-from-mag-ang r a))))

  ; Exercise 2.77
  (put 'real-part '(complex) real-part)
  (put 'imag-part '(complex) imag-part)
  (put 'magnitude '(complex) magnitude)
  (put 'angle '(complex) angle)

  'done)

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

(#%provide install-complex-package
           make-complex-from-mag-ang
           make-complex-from-real-imag
           real-part
           imag-part
           magnitude
           angle)