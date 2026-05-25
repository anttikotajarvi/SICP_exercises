; SICP 2.5.2
; Chapter: Building Abstractions with Data
; Section: Systems with Generic Operations
; Subsection: Combining Data of Different Types
; Exercise 2.81:
; Louis Reasoner has noticed that 'apply-generic' may try to 
;  coerce the arguments to each other's type even if they 
;  already have the same type.  Therefore, he reasons we need to
;  put procedures in the coercion table to coerce arguments of 
;  of each type to their own type.
; For example, in addition to the 'scheme-number->complex' 
;  coercion shown above, he would do:
; (define (scheme-nuumber->scheme-nnumber n) n)
; (define (complex->complex z) z)
; (put-coercion 'scheme-number
;               'scheme-number
;                scheme-number->scheme-number)
; (put-coercion 'complex 'complex complex->complex)
; 
; a. With Louis's coercien procedures installed, what happens if
;    'apply-generic' is called with two arguments of the type 
;    'scheme-number' or two arguments of 'complex' for an 
;    operation that is not found in the table for those types?
;    For example, assume that we've defined a generic 
;    exponentiation operation:
;    (define (exp x y) (apply-generic 'exp x y))
;    and have put a procedure for exponentiation in the 
;    Scheme-number package but not in any other package:
;    (put 'exp '(scheme-number scheme-number)
;       (lambda (x y) (tag (expt x y))))
;    What happens if we call 'exp' with two complex numbers as
;    arguments?
; ______________________________________________________________

(define (apply-generic op . args)
  (let* ([type-tags (map type-tag args)]
         [proc (get op type-tags)])
    (if proc ; proc is falsey
        (apply proc (map contents args))
        (if (= (length args) 2) ; two args
            (let* ([type1 (car type-tags)]
                   [type2 (cadr type-tags)]
                   [a1 (car args)]
                   [a2 (cadr args)]
                   ; Both are called with the "identity"
                   ;  coercement
                   [t1->t2 (get-coercion type1 type2)] 
                   [t2->t1 (get-coercion type2 type1)])
              (cond
                [t1->t2 ; truthy -> loop
                 (apply-generic op (t1->t2 a1) a2)]
                [t2->t1 
                 (apply-generic op a1 (t2->t1 a2))]
                [else
                 (error "No method for these types"
                        (list op type-tags))]))
            (error "No method for these types"
                   (list op type-tags))))))

;; The apply-generic procedure gets stuck in an infinite loop

; ______________________________________________________________
; b. Is Louis correct that something had to be done about 
;    coercion with arguments of the same type, or does 
;   'apply-generic' work correctly as is?
; ______________________________________________________________

;; Calling a procedure with two of the same types where there 
;;  which dont have the prcoedure implemented just causes an
;;  expected error in simple clean pass.
;; Not sure what Louis is on about.

; ______________________________________________________________
; c. Modify 'apply-generic' so that it doesn't try coercion if
;    the two arguments have the same type.
; ______________________________________________________________

;; Added an error case while keeping nesting clean.
;; Still not sure what this is accomplishing.
;; Reducing unnecessary get-coercion calls?

(define (apply-generic op . args)
  (let* ([type-tags (map type-tag args)]
         [proc (get op type-tags)])
    (cond
      [proc
       (apply proc (map contents args))]
      [(not (= (length args) 2))
       (error "No method for these types"
              (list op type-tags))]
      [else
       (let* ([type1 (car type-tags)]
              [type2 (cadr type-tags)]
              [a1 (car args)]
              [a2 (cadr args)]
              [t1->t2 (and (not (eq? type1 type2))
                           (get-coercion type1 type2))]
              [t2->t1 (and (not (eq? type1 type2))
                           (get-coercion type2 type1))])
         (cond
           [t1->t2
            (apply-generic op (t1->t2 a1) a2)]
           [t2->t1
            (apply-generic op a1 (t2->t1 a2))]
           [else
            (error "No method for these types"
                   (list op type-tags))]))])))