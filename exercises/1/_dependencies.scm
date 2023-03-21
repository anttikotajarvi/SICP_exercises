(define (square x) (* x x))
(define (cube x) (* x x x))
(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))

(define (improve guess x)
    (average guess (/ x guess)))
(define (average x y)
    (/ (+ x y) 2))


(define (inc x) (+ x 1))
(define (dec x) (- x 1))
(define (display-all . vs)
  (for-each display vs))