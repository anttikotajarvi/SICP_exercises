; SICP 2.2.2
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Hierarchical Structures
; Exercise 2.27:
; Modify your 'reverse' procedure of Exercise 2.18 to produce a
;  'deep-reverse' procedure that takes a list as argument and
;  and returns as its value the list with its elements reversed
;  and with all sublists deep-reversed as well.
; ...
; ______________________________________________________________
#lang sicp
(define (deep-reverse l)
  (define (iter l rl)
    (if (null? l)
        rl
        (let ([val (car l)])
          (iter (cdr l)
                (cons (if (pair? val)
                          (deep-reverse val)
                          val)
                      rl)))))
  (iter l (list)))

(#%require "../lib.rkt")
(define x   (list (list (list 1 2)  
              (list 3 4))
        (list (list 5 6)
              (list 7 8))))
(inspect (deep-reverse x))
(inspect (deep-reverse (deep-reverse x)))
