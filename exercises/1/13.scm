; 1. Building Abstractions with Procedures
; Exercise 1.12
; The following pattern of numbers is called
;  Pascal’s triangle .
; 
;         1
;       1   1
;     1   2   1
;   1   3   3  1
; 1   4   6   4  1
; 
; The numbers at the edge of the triangle are all 1, and each
;  number inside the triangle is the sum of the two numbers
;  above it*. 
;  Write a procedure that computes elements of
;  Pascal’s triangle by means of a recursive process.
;____________________________________________________________

; Not sure how to format this.
; Using strings feels out of place so I guess
;  we just print line-by-line.
; Weird how this all of the sudden requires scheme procedures
;  that haven even been eluded to yet.

(load "_dependencies.scm") ; for `display-all`

; Calculates xth number on the yth layer ( top-down )
; Reasonably happy with this procedure even though it
;  does a lot of redundant calculation
    (define (f x y)
        (cond 
         	((or (> x y) (< x 0)) 0)
        	((and (= y 1) (= x 1)) 1)
            (else (+ (f x (- y 1)) (f (- x 1) (- y 1))) ) ))

; Initially did this but realized that while the process 
;  for calculating the number for the triangle is recursive,
;  the iterating through the rows is, indeed, iterative.
    (define (pascals-triangle depth)
        (define (iter nth-char nth-row)
        (if (<= nth-row depth)
            (and (display (f nth-char nth-row))
                (if (= nth-char nth-row); end of row
                    (and (newline)
                            (iter 1 (+ nth-row 1))); first char of next row
                    (iter (+ nth-char 1) nth-row))); next char of this row
            (display ""))); void
        (iter 1 1))

    (pascals-triangle 5)


; Recursive version
    (define (pascals-triangle depth)
        (define (row-iter y) 
            (define (char-iter x y)
                (and (display (f x y))
                    (if (= x y) 
                        (newline)
                        (char-iter (+ x 1) y))))
        
            (and (char-iter 1 y)
                (if (= y depth)
                    (display ""); void 
                    (row-iter (+ y 1)))))
        (row-iter 1))
    
    (pascals-triangle 5)

    ;=> 1
    ;=> 11
    ;=> 121
    ;=> 1331
    ;=> 14641
    ;=> 1
    ;=> 11
    ;=> 121
    ;=> 1331
    ;=> 14641
    ; Tabulation is beside the point


;____________________________________________________________
; *The elements of Pascal’s triangle are called the binomial coeﬃcients , because the
; row consists of the coeﬃcients of the terms in the expansion of (x + y)^n . This pat-
; tern for computing the coeﬃcients appeared in Blaise Pascal’s 1653 seminal work on
; probability theory, Traité du triangle arithmétique . According to Knuth (1973), the same
; pattern appears in the Szu-yuen Yü-chien (“The Precious Mirror of the Four Elements”),
; published by the Chinese mathematician Chu Shih-chieh in 1303, in the works of the
; twelth-century Persian poet and mathematician Omar Khayyam, and in the works of
; the twelh-century Hindu mathematician Bháscara Áchárya.