; SICP 2.5.2
; Chapter: Building Abstractions with Data
; Section: Systems with Generic Operations
; Subsection: Combining Data of Different Types
; Exercise 2.82:
; Show how to generalize 'apply-generic' to handle coercion in
;  the general case of multiple arguments.
; One strategy is to attempt to coerce all the arguments to the
;  type of the first argument, then to the type of the second 
;  argument, and so on.  
; Give an example of a situation where this strategy is not 
;  sufficiently general. (Hint: Consider the case where there 
;  are some suitable mixed-type operations present in the table
;  that will not be tried.)
; ______________________________________________________________
(define (coercion-loop op . args)
  (define type-tags (map type-tag args))
  (define unique-types (unique type-tags))

  (define (can-coerce-to? target types)
    (cond
      [(null? types) true]
      [(eq? (car types) target)
       (can-coerce-to? target (cdr types))]
      [(get-coercion (car types) target)
       (can-coerce-to? target (cdr types))]
      [else false]))

  (define (coerce-one target arg)
    (let ([arg-type (type-tag arg)])
      (if (eq? arg-type target)
          arg
          ((get-coercion arg-type target) arg))))

  (define (coerce-all target args)
    (map (lambda (arg)
           (coerce-one target arg))
         args))

  (define (iter-types types)
    (cond
      [(null? types)
       (error "No common coercion" (list op type-tags))]
      [else
       (let* ([target (car types)]
              [target-tags (map (lambda (_) target) args)]
              [proc (get op target-tags)])
         (if (and proc
                  (can-coerce-to? target type-tags))
             (apply proc (map contents (coerce-all target args)))
             (iter-types (cdr types))))]))

  (iter-types unique-types))

(define (apply-generic op . args)
  (let* ([type-tags (map type-tag args)]
         [proc (get op type-tags)])
    (if proc
        (apply proc (map contents args))
        (apply coercion-loop op args))))

;; This implementation seems way more complicated than it needs
;;  to be but its fine.

;; One type of case where this fails would be where the types
;;  are of different hierarchies:
;;   (intersect shape1 shape2)
;; and the table contains
;;   (put 'intersect '(line circle) intersect-line-circle)
;; and a coercion for segment->line exists
;; but 
;;    (intersect segment circle)
;; is called,
;;    (intersect (segment->line segment) circle)
;; would be obvious
;; but
;;   segment->circle or circle->segment 
;; would be incoherent and undefined.

; helpers
(define (unique xs)
  (define (iter remaining seen)
    (cond
      [(null? remaining) (reverse seen)]
      [(memq (car remaining) seen)
       (iter (cdr remaining) seen)]
      [else
       (iter (cdr remaining)
             (cons (car remaining) seen))]))
  (iter xs '()))