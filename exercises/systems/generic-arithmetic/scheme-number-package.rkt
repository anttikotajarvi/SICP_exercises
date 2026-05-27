#lang sicp
(#%require "./exercises/lib.rkt")
(#%require "helpers.rkt")

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





