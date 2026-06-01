#lang sicp
(#%require sicp-pict)

;; SICP 2.2.4: Example: A Picture Language.
(define (split a b)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ([smaller (up-split painter (- n 1))])
             (a painter (b smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ([up (up-split painter (- n 1))]
            [right (right-split painter (- n 1))])
        (let ([top-left (beside up up)]
              [bottom-right (below right right)]
              [corner (corner-split painter (- n 1))])
          (beside (below painter top-left) (below bottom-right corner))))))

(define (square-limit painter n)
  (let ([quarter (corner-split painter n)])
    (let ([half (beside (flip-horiz quarter) quarter)])
      (below (flip-vert half) half))))

(#%provide split
           right-split
           up-split
           corner-split
           square-limit)
