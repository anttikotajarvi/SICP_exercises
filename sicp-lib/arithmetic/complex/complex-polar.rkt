#lang sicp
;; SICP 2.4.3: Data-Directed Programming and Additivity.
(#%require sicp-lib/generic)
(#%require sicp-lib/arithmetic sicp-lib/arithmetic/internal)

(define (install-polar-package)
  ;; internal procedures
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))

  (define (make-from-mag-ang r a)
    (cons r a))

  (define (real-part z)
    (mul (magnitude z) (cosine (angle z))))

  (define (imag-part z)
    (mul (magnitude z) (sine (angle z))))

  (define (make-from-real-imag x y)
    (cons (square-root (add (mul x x) (mul y y)))
          (arctangent y x)))

  ;; interface
  (define (tag x) (attach-tag 'polar x))

  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)

  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))

  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))

  'done)

(#%provide install-polar-package)