; SICP 2.2.4
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Example: A Picture Language
; Exercise 2.47:
; Here are two possible constructors for frames:
#lang sicp
(define (make-frame1 origin edge1 edge2)
  (list origin edge1 edge2))
(define (make-frame2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
; For Each constructor supply the appropriate selectors to
;  produce an implementation for frames.
; ______________________________________________________________
(#%require "../lib.rkt")

;; First implementation
(define (origin-frame1 f) (car f))
(define (edge1-frame1 f) (cadr f))
(define (edge2-frame1 f) (caddr f))

;; Second implementation
(define (origin-frame2 f) (car f))
(define (edge1-frame2 f) (cadr f))
(define (edge2-frame2 f) (cddr f))


;; Tests
(define (test-frame f)
  (f (make-vect 1 2) 
     (make-vect 3 4)  
     (make-vect 5 6)))

(define f1 (test-frame make-frame1))
(inspect (origin-frame1 f1))
(inspect (edge1-frame1 f1))
(inspect (edge2-frame1 f1))

(define f2 (test-frame make-frame2))
(inspect (origin-frame2 f2))
(inspect (edge1-frame2 f2))
(inspect (edge2-frame2 f2))