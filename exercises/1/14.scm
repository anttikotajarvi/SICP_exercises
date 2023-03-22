; 1. Building Abstractions with Procedures
; Exercise 1.14
; Draw the tree illustrating the process gen-
;  erated by the count-change procedure of Section 1.2.2 in
;  making change for 11 cents. What are the orders of growth
;  of the space and number of steps used by this process as
;  the amount to be changed increases?
;____________________________________________________________

; Change counting process from 1.2.2
(define (count-change amount) (cc amount 5))
(define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
          ((or (< amount 0) 
               (= kinds-of-coins 0)) 0)
          (else (+ (cc amount (- kinds-of-coins 1))
                   (cc (- amount
                          (first-denomination kinds-of-coins))
                        kinds-of-coins)))))
    
    (define (first-denomination kinds-of-coins)
        (cond ((= kinds-of-coins 1) 1)
              ((= kinds-of-coins 2) 5)
              ((= kinds-of-coins 3) 10)
              ((= kinds-of-coins 4) 25)
              ((= kinds-of-coins 5) 50)))
            
(count-change 11)
(cc 11 5)
(cond ((= 11 0) 1)
      ((or (< 11 0) 
           (= 5 0)) 0)
      (else (+ (cc 11 (- 5 1))
               (cc (- 11 (first-denomination 5))
                    5)))))
(cond (false 1)
      (false 0)
      (else (+ (cc 11 4)
               (cc (- 11 50) 5)))))
(+ (cc 11 4) 
   (cc -39 5)))))
