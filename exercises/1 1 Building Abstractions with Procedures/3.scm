;Exercise 1.3: Deﬁne a procedure that takes three numbers
;as arguments and returns the sum of the squares of the two
;larger numbers.
(define (bigger a b) 
        (if (> b a)
            b
            a))

(define (square x) (* x x))
(define (sum-of-squares-of-two-largest a b c) 
        (if (> a b) 
                (+ (square (bigger b c)) (square a))
                (+ (square (bigger a c)) (square b))))


(sum-of-squares-of-two-largest 1 2 3)
;=>13

