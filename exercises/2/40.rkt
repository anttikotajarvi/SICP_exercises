; SICP 2.2.3
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Sequences as Conventional Interfaces
; Exercise 2.40:
; Define a procedure 'unique-pairs' that, given an integer n,
;  generates the sequence of pairs (i, j) with 1 <= j < i <= n.
; Use 'unique-pairs' to simplify the definition of
;  'prime-sum-pairs' given above.
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")
;; Unique pairs
(define (unique-pairs n)
  (flatmap
    (lambda (i)
      (map (lambda (j) (list i j))
           (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

;; Dependencies
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

;; Prime sum pairs
(define (prime-sum-pairs n)
  (map make-pair-sum
    (filter prime-sum? (unique-pairs n))))

(inspect (prime-sum-pairs 4))