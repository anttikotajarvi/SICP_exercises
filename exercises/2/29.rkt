; SICP 2.2.2
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Hierarchical Structures
; Exercise 2.29:
; A binary mobile consists of two branches, a left branch and a
;  right branch.
; Each branch is a rod of a certain length, from which hangs
;  either a weight or an other binary mobile.
; We can represent a binary mobile using compound data by
;  constructing it from two branches (for example, using list):
#lang sicp
(define (make-mobile left right)
  (list left right))
; A branch is constructed from a length (which must be a number)
;  together with a 'structure', which may be either a number
;  (representing a simple weight) or another mobile:
(define (make-branch length structure)
  (list length structure))
; ______________________________________________________________
; a. Write the corresponding selectors 'left-branch' and
;  'right-branch', which return the branches of a mobile,
;  and 'branch-length' and 'branch-structure', which return the
;  components of a branch.
; ______________________________________________________________
(define (left-branch m)
  (car m))
(define (right-branch m)
  (cadr m))

(define (branch-length b)
  (car b))
(define (branch-structure b)
  (cadr b))
; ______________________________________________________________
; b. Using our selectors, define a procedure 'total-weight' that
;  returns the total weight of the mobile.
; ______________________________________________________________
(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile)) 
     (branch-weight (right-branch mobile))))

(define (branch-weight branch)
  (define s (branch-structure branch))
  (if (number? s)
      s
      (total-weight s)))

(define m1 (make-mobile (make-branch 2 3) (make-branch 2 3)))
(#%require "../lib.rkt")
(inspect (total-weight m1))

; ______________________________________________________________
; c. A mobile is said to be "balanced" if the torque applied by
;  its top-left branch is equal to that applied by its top-right
;  branch (that is, if the length of the left rod multiplied by
;  the weight hanging from that rod is equal to the
;  corresponding product for the right side) and if each of the
;  submobiles hanging off its branches is balanced.
; Design a predicate that tests whether a binary mobile is
;  balanced.
; ______________________________________________________________
(define (balanced-mobile? m)
  (define (torque b)
    (* (branch-length b)
       (branch-weight b)))
  (= (torque (left-branch m))
     (torque (right-branch m))))
(define m2 (make-mobile
  (make-branch 4 2)
  (make-branch 2 2)))

(inspect (balanced-mobile? m1))
(inspect (balanced-mobile? m2))


; ______________________________________________________________
; d. Suppose we change the representation of modules so that the
;  constructors are
(define (make-mobile-2 left right) (cons left right))
(define (make-branch-2 length structure)
  (cons length structure))
; How much do you need to change your programs to convert to the
;  new representation?
; ______________________________________________________________

(define (left-branch-2 m)
  (car m))
(define (right-branch-2 m)
  (cdr m))

(define (branch-length-2 b)
  (car b))
(define (branch-structure-2 b)
  (cdr b))

(define (branch-weight-2 branch)
  (define s (branch-structure-2 branch))
  (if (number? s)
      s
      (total-weight-2 s)))

(define (total-weight-2 mobile)
  (+ (branch-weight-2 (left-branch-2 mobile)) 
     (branch-weight-2 (right-branch-2 mobile))))

; Testing
(define m3 (make-mobile-2 (make-branch-2 2 3) (make-branch-2 2 3)))
(inspect (total-weight-2 m3))
