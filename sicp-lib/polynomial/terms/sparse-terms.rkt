#lang sicp
(#%require sicp-lib/arithmetic)
(#%require sicp-lib/generic)
(#%require "main.rkt")

(define (install-sparse-terms-package)

  (define (tag x)
    (attach-tag 'sparse x))

  ;; sparse term-list representation:
  ;; ((order coeff) (order coeff) ...)

  (define (adjoin-term-internal term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))

  (define (the-empty-termlist-internal) '())

  (define (first-term-internal term-list)
    (car term-list))

  (define (rest-terms-internal term-list)
    (cdr term-list))

  (define (empty-termlist?-internal term-list)
    (null? term-list))

  (define (=zero?-termlist-internal terms)
    (cond [(empty-termlist?-internal terms) true]
          [(=zero?-term (first-term-internal terms))
           (=zero?-termlist-internal (rest-terms-internal terms))]
          [else false]))

  (define (negate-termlist-internal terms)
    (if (empty-termlist?-internal terms)
        (the-empty-termlist-internal)
        (adjoin-term-internal
         (negate-term (first-term-internal terms))
         (negate-termlist-internal (rest-terms-internal terms)))))

  ;; interface
  (put 'adjoin-term 'sparse
       (lambda (term terms)
         (tag (adjoin-term-internal term terms))))

  (put 'the-empty-termlist 'sparse
       (lambda ()
         (tag (the-empty-termlist-internal))))

  (put 'first-term '(sparse)
       (lambda (terms)
         (first-term-internal terms)))

  (put 'rest-terms '(sparse)
       (lambda (terms)
         (tag (rest-terms-internal terms))))

  (put 'empty-termlist? '(sparse)
       (lambda (terms)
         (empty-termlist?-internal terms)))

  (put '=zero?-termlist '(sparse)
       (lambda (terms)
         (=zero?-termlist-internal terms)))

  (put 'negate-termlist '(sparse)
       (lambda (terms)
         (tag (negate-termlist-internal terms))))

  'done)

(#%provide install-sparse-terms-package)