#lang sicp
(#%require sicp-lib/arithmetic)
(#%require sicp-lib/generic)
(#%require "main.rkt")

(define (install-dense-terms-package)

  (define (tag x)
    (attach-tag 'dense x))

  ;; dense term-list representation:
  ;; (coeff coeff coeff ...)
  ;;
  ;; Example:
  ;; (1 2 0 3 -2 -5)
  ;; means:
  ;; x^5 + 2x^4 + 0x^3 + 3x^2 - 2x - 5

  (define (adjoin-term-internal term term-list)
    (if (=zero? (coeff term))
        term-list
        (let ([target-order (order term)]
              [next-order (length term-list)])
          (cond [(= target-order next-order)
                 (cons (coeff term) term-list)]
                [(> target-order next-order)
                 (adjoin-term-internal term (cons 0 term-list))]
                [else
                 (error "term order too small: ADJOIN-TERM"
                        (list term term-list))]))))

  (define (the-empty-termlist-internal) '())

  (define (first-term-internal term-list)
    (make-term (- (length term-list) 1)
               (car term-list)))

  (define (rest-terms-internal term-list)
    (cdr term-list))

  (define (empty-termlist?-internal term-list)
    (null? term-list))

  (define (=zero?-termlist-internal terms)
    (cond [(empty-termlist?-internal terms) true]
          [(=zero?-term (first-term-internal terms))
           (=zero?-termlist-internal (rest-terms-internal terms))]
          [else false]))

  ;; use map to preserve zero placeholders
  (define (negate-termlist-internal terms)
    (map negate terms))

  ;; interface
  (put 'adjoin-term 'dense
       (lambda (term terms)
         (tag (adjoin-term-internal term terms))))

  (put 'the-empty-termlist 'dense
       (lambda ()
         (tag (the-empty-termlist-internal))))

  (put 'first-term '(dense)
       (lambda (terms)
         (first-term-internal terms)))

  (put 'rest-terms '(dense)
       (lambda (terms)
         (tag (rest-terms-internal terms))))

  (put 'empty-termlist? '(dense)
       (lambda (terms)
         (empty-termlist?-internal terms)))

  (put '=zero?-termlist '(dense)
       (lambda (terms)
         (=zero?-termlist-internal terms)))

  (put 'negate-termlist '(dense)
       (lambda (terms)
         (tag (negate-termlist-internal terms))))

  'done)

(#%provide install-dense-terms-package)