; SICP 2.5.2
; Chapter: Building Abstractions with Data
; Section: Systems with Generic Operations
; Subsection: Combining Data of Different Types
; Exercise 2.83:
; Suppose you are designing a generic arithmetic system for 
;  dealing with the tower of types shown in Figure 2.25: 
;  integer, rational, real, complex.
; For each type (except complex), design a procedure that raises
;  objects of that type one level in the tower. 
; Show how to install a generic raise operation that ill work
;  for each type (except complex.)
; ______________________________________________________________

;; Figure 2.25: integer -> rational -> real -> complex

(define (raise-integer x) (make-rational x 1))
(define (raise-rational x) (make-real (/ (numer x) (denom x))))
(define (raise-real x) (make-complex-from-real-imag x 0))

(put 'raise '(integer) raise-integer)
(put 'raise '(rational) raise-rational)
(put 'raise '(real) raise-real)

(define (raise x) (apply-generic 'raise x))

; ______________________________________________________________
; Exercise 2.84:
; Using the 'raise' operation, modify the 'apply-generic' 
;  procedure so that coerces its arguments to have the same type
;  by the method of successive raising, as discussed in this 
;  section.  
; You will need to devise a way to test which of two types is 
;  higher in the tower.  Do this in a manner that is "compatible"
;  with the rest of the system and will not lead to problems in
;  adding new levels to the tower.
; ______________________________________________________________

(define tower '(integer rational real complex))
(define (tower-nth type)
  (define (iter i rest)
    (cond [(null? rest) i]
          [(eq? type (car rest)) i]
          [else (iter (inc i) (cdr rest))]))
    (iter 0))

(define (raise-to x current-idx target-idx)
  (if (= current-idx target-idx)
      x
      (raise-to (raise x)
                (+ current-idx 1)
                target-idx)))

;; flattening args to highest argument
;; this whole approach is stupid
(define (coercion-raise-loop op . args)
  (define type-tags (map type-tag args)).
  (define tower-idx (map tower-nth type-tags))
  (define highest
    (accumulate (lambda (a b)
                  (if (> a b) a b))
                0
                tower-idx))

  (define (iter args tower-idx)
    (cond [(null? args) '()]
          [else
           (cons (raise-to (car args)
                           (car tower-idx)
                           highest)
                 (iter (cdr args)
                       (cdr tower-idx)))]))

  (let* ([raised-args (iter args tower-idx)]
         [raised-type-tags (map type-tag raised-args)]
         [proc (get op raised-type-tags)])
    (if proc
        (apply proc (map contents raised-args))
        (error "No method for these types"
               (list op type-tags)))))


(define (apply-generic op . args)
  (let* ([type-tags (map type-tag args)]
         [proc (get op type-tags)])
    (if proc
        (apply proc (map contents args))
        (apply coercion-raise-loop op args))))

; ______________________________________________________________
; Exercise 2.85:
; This section mentioned a method for "simplifying" a data 
;  object by lowering it in the tower of types as far as 
;  possible.  Design a procedure drop that accomplishes this for 
;  the tower described in Exercise 2.83.
; The key is to decidem in some general way, whether an object
;  can be lowered.  
; For example, the complex number 1.5 + 0i can be lowered as far
;  as 'real', the complex number 1 + 0i can be lowered as far as
;  'integer', and the complex number 2 + 3i cannot be lowered at
;  all.  
; Here is a plan for determining whther an object can be lowered:
; Begin by defining a generic operation 'project' that "pushes"
;  an object down in the tower.  For example, projecting a 
;  complex number would involve throwing away the imaginary part.
; Then a number can be dropped if, when we 'project' it and 
;  'raise' the result back to the type we started with, we end up
;  with something equal to what we started with.
; Show how to implement this idea in detail, by writing a 'drop'
;  procedure that drops an object as far as possible.
; You will need to design the various projection operations and
;  install 'project' as a generic operation ins the system. 
; You will also need to make use of a generic equality predicate,
;  such as described in Exercise 2.79.
; Finally, use 'drop' to rewrite 'apply'generic' from 
;  Exercise 2.84 so that it "simplifies" its answers.
; ______________________________________________________________

(put 'project '(complex)
     (lambda (x)
       (make-real (real-part x))))

(put 'project '(real)
     (lambda (x)
       (let ([r (inexact->exact x)])
         (make-rational (numerator r)
                        (denominator r)))))
(put 'project '(rational)
     (lambda (x)
       (make-integer (round (/ (numer x)
                               (denom x))))))

(define (project x) (apply-generic 'project x))

(define (project x)

  (apply-generic 'project x))
(define (projectable? x)
  (get 'project (list (type-tag x))))

(define (drop x)
  (if (not (projectable? x))
      x
      (let* ([projected (project x)]
             [raised (raise projected)])
        (if (equ? x raised) ; generic equality check
            (drop projected)
            x))))

;; I dont see a good reason for rewriting apply-generic again...

; ______________________________________________________________
; Exercise 2.86:
; Suppose we want to handle complex numbers whose real parts, 
;  imaginary parts, magnitudes, and angles can be either 
;  ordinary numbers, rational numbers, or other numbers we might 
;  wish to add to the system.
; Describe and implement the changes to the system needed to
;  accomodate this.
; You will have to define operations such as 'sine' and 'cosine' 
;  that are generic over ordinary numbers and rational numbers.
; ______________________________________________________________
;; Implemented in systems/generic-arithmetic/ which is a 
;;  slightly different system than this hierarchic one.
;; It is very weird that the previous arithmetic system
;;  that we were asked to define and add methods to
;;  used the type scheme-number, rational and polar when these
;;  last few exercises gave a new setup with integer, rational,
;;  real and complex.  This seems like an oversight left over
;;  from the fisrt version of this book or something.

;; Implementation is pretty simple and consists of adding:
(define (cosine x) (apply-generic 'cosine x))
(define (sine x) (apply-generic 'sine x))
(define (arctangent x) (apply-generic 'arctanget x))
(define (square-root x) (apply-generic 'square-root x))

