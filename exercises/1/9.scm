; 1. Building Abstractions with Procedures
(load "_dependencies.scm")
; Exercise 1.9 
; Each of the following two procedures deﬁnes
;  a method for adding two positive integers in terms of the
;  procedures inc , which increments its argument by 1, and
;  dec , which decrements its argument by 1.
    (define (+ a b)
        (if (= a 0) b (inc (+ (dec a) b))))
    (define (+ a b)
        (if (= a 0) b (+ (dec a) (inc b))))
; Using the substitution model, illustrate the process gener-
; ated by each procedure in evaluating (+ 4 5) . Are these
; processes iterative or recursive?
;  abstraction of these square-root and cube-root procedures.)
;____________________________________________________________

; Note that `inc` wont be expanded, as per the substitution model to not introduce a
;  `+` procedure with another definition
;  Running this will lead to an time out error
    (define (+ a b)
        (if (= a 0) b (inc (+ (dec a) b))))
    
    (+ 4 5)
    (if (= 4 0) 5 (inc (+ (dec 4) 5)))
    (if false 5 (inc (+ 3 5)))
    (inc (if (= 3 0) 5 (inc (+ (dec 3) 5))))
    (inc (if false 5 (inc (+ 2 5))))
    (inc (inc (+ 2 5)))
    (inc (inc (if (= 2 0) 5 (inc (+ (dec 2) 5)))))
    (inc (inc (if false 5 (inc (+ 1 5)))))
    (inc (inc (inc (+ 1 5))))
    (inc (inc (inc (if (= 1 0) 5 (inc (+ (dec 1) 5))))))
    (inc (inc (inc (if false 5 (inc (+ 0 5))))))
    (inc (inc (inc (inc (+ 0 5)))))
    (inc (inc (inc (inc (if true 5 (inc (+ -1 5)))))))
    (inc (inc (inc (inc 5))))
    (inc (inc (inc 6)))
    (inc (inc 7))
    (inc 8)
    9
; Looks like a recursive process
; Don't know how to elaborate

    (define (+ a b)
        (if (= a 0) b (+ (dec a) (inc b))))

    (+ 4 5)
    (if (= 4 0) 5 (+ (dec 4) (inc 5)))
    (if false 5 (+ 3 6))
    (+ 3 6) 
    (if (= 3 0) 6 (+ (dec 3) (inc 6)))
    (if false 6 (+ 2 7))
    (+ 2 7)
    (if (= 2 0) 7 (+ (dec 2) (inc 7)))
    (if false 7 (+ 1 8))
    (+ 1 8)
    (if (= 1 0) 8 (+ (dec 1) (inc 8)))
    (if false 8 (+ 0 9))
    (+ 0 9)
    (if true 9 (+ -1 10))
    9
; Looks like an iterative process
; Doesn't create deferred state















    



    
