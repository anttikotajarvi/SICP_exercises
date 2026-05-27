#lang sicp
(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

(#%provide make-complex-from-mag-ang
           make-complex-from-real-imag
           real-part
           imag-part
           magnitude
           angle)

(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))

  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))

  ;; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag (add (real-part z1) (real-part z2))
                         (add (imag-part z1) (imag-part z2))))

  (define (sub-complex z1 z2)
    (make-from-real-imag (sub (real-part z1) (real-part z2))
                         (sub (imag-part z1) (imag-part z2))))

  (define (mul-complex z1 z2)
    (make-from-mag-ang (mult (magnitude z1) (magnitude z2))
                       (add (angle z1) (angle z2))))

  (define (div-complex z1 z2)
    (make-from-mag-ang (div (magnitude z1) (magnitude z2))
                       (sub (angle z1) (angle z2))))

	;; predicates
  (define (equ?-complex z1 z2)
    (and (equ? (real-part z1) (real-part z2))
         (equ? (imag-part z1) (imag-part z2))))

	(define (=zero?-complex z)
		(and (equ? (real-part z) 0)
				(equ? (imag-part z) 0)))

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



(#%provide install-complex-package)