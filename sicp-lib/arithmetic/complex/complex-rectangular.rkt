#lang sicp
;; SICP 2.4.3: Data-Directed Programming and Additivity.
(#%require sicp-lib/generic)
(#%require sicp-lib/arithmetic sicp-lib/arithmetic/internal)


(define (install-rectangular-package)
  ;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))

  (define (make-from-real-imag x y)
    (cons x y))

  (define (magnitude z)
    (square-root (add (square-g (real-part z))
               (square-g (imag-part z)))))

  (define (angle z)
    (arctangent (imag-part z) (real-part z)))

  (define (make-from-mag-ang r a)
    (cons (mul r (cosine a))
          (mul r (sine a))))

  ;; interface
  (define (tag x) (attach-tag 'rectangular x))

  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)

  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))

  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a)))))

(#%provide install-rectangular-package)