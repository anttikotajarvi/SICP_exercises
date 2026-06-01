#lang sicp
(#%require "./exercises/lib.rkt")
(#%require sicp-lib/arithmetic/internal)

(define (install-scheme-number-package)
  (define tag 'scheme-number)

  (put 'add '(scheme-number scheme-number) (wrap tag +))
  (put 'sub '(scheme-number scheme-number) (wrap tag -))
  (put 'mul '(scheme-number scheme-number) (wrap tag *))
  (put 'div '(scheme-number scheme-number) (wrap tag /))

  (put 'sine '(scheme-number)
      (lambda (x)
        (make-scheme-number (sin x))))

  (put 'cosine '(scheme-number)
      (lambda (x)
        (make-scheme-number (cos x))))

  (put 'square-root '(scheme-number)
      (lambda (x)
        (make-scheme-number (sqrt x))))

  (put 'arctangent '(scheme-number scheme-number) (wrap tag atan))

  (put 'equ? '(scheme-number scheme-number) =)
  (put '=zero? '(scheme-number) (lambda (x) (= x 0)))

  (put 'make 'scheme-number (lambda (x) (attach-tag tag x)))

  'done)
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(#%provide install-scheme-number-package make-scheme-number)
