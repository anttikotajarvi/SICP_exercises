#lang sicp

(#%require sicp-lib/arithmetic)
(#%require sicp-lib/generic)

(#%provide make-term order coeff
           =zero?-term negate-term

           adjoin-term the-empty-termlist
           first-term rest-terms empty-termlist?
           =zero?-termlist negate-termlist

           sub-terms add-terms mul-terms)

;; Basic term

(define (make-term order coeff)
  (list order coeff))

(define (order term)
  (car term))

(define (coeff term)
  (cadr term))

(define (=zero?-term term)
  (=zero? (coeff term)))

(define (negate-term term)
  (make-term (order term)
             (negate (coeff term))))

;; Generic term-list interface

(define (adjoin-term term term-list)
  ((get 'adjoin-term (type-tag term-list))
   term
   (contents term-list)))

(define (the-empty-termlist kind)
  ((get 'the-empty-termlist kind)))

(define (first-term term-list)
  (apply-generic 'first-term term-list))

(define (rest-terms term-list)
  (apply-generic 'rest-terms term-list))

(define (empty-termlist? term-list)
  (apply-generic 'empty-termlist? term-list))

(define (=zero?-termlist term-list)
  (apply-generic '=zero?-termlist term-list))

(define (negate-termlist term-list)
  (apply-generic 'negate-termlist term-list))

;; Arithmetic over term-list interface

(define (sub-terms L1 L2)
  (add-terms L1 (negate-termlist L2)))

(define (add-terms L1 L2)
  (cond [(empty-termlist? L1) L2]
        [(empty-termlist? L2) L1]
        [else
         (let ([t1 (first-term L1)]
               [t2 (first-term L2)])
           (cond [(> (order t1) (order t2))
                  (adjoin-term
                   t1
                   (add-terms (rest-terms L1) L2))]

                 [(< (order t1) (order t2))
                  (adjoin-term
                   t2
                   (add-terms L1 (rest-terms L2)))]

                 [else
                  (adjoin-term
                   (make-term (order t1)
                              (add (coeff t1) (coeff t2)))
                   (add-terms (rest-terms L1)
                              (rest-terms L2)))]))]))

(define (mul-terms L1 L2)
  (if (empty-termlist? L1)
      (the-empty-termlist (type-tag L1))
      (add-terms (mul-term-by-all-terms (first-term L1) L2)
                 (mul-terms (rest-terms L1) L2))))

(define (mul-term-by-all-terms t1 L)
  (if (empty-termlist? L)
      (the-empty-termlist (type-tag L))
      (let ([t2 (first-term L)])
        (adjoin-term
         (make-term (+ (order t1) (order t2))
                    (mul (coeff t1) (coeff t2)))
         (mul-term-by-all-terms t1 (rest-terms L))))))