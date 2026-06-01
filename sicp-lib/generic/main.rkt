#lang sicp

;; SICP 2.4.3: Data-Directed Programming and Additivity.
;; SICP 2.5: Systems with Generic Operations.
(define (attach-tag type contents)
  (cons type contents))

(define (type-tag datum)
  (car datum))

(define (contents datum)
  (cdr datum))

(define (get . x) (error "undefined"))
(define (put . x) (error "undefined"))

(define (apply-generic op . args)
  (let* ([type-tags (map type-tag args)]
         [proc (get op type-tags)])
    (if proc
        (apply proc (map contents args))
        (if (= (length args) 2)
            (let* ([type1 (car type-tags)]
                   [type2 (cadr type-tags)]
                   [a1 (car args)]
                   [a2 (cadr args)]
                   [t1->t2 (get-coercion type1 type2)]
                   [t2->t1 (get-coercion type2 type1)])
              (cond
                [t1->t2
                 (apply-generic op (t1->t2 a1) a2)]
                [t2->t1
                 (apply-generic op a1 (t2->t1 a2))]
                [else
                 (error "No method for these types"
                        (list op type-tags))]))
            (error "No method for these types"
                   (list op type-tags))))))

(define (get-coercion . x) (error "undefined"))
(define (put-coercion . x) (error "undefined"))

(#%provide attach-tag
           type-tag
           contents
           get
           put
           apply-generic
           get-coercion
           put-coercion)
