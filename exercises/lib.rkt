#lang sicp
(define (pow base exp)
  (define (iter counter product)
    (if (= counter 0)
        product
        (iter (- counter 1) (* product base))))
  (iter exp 1))

(define (average . xs)
  (/ (apply + xs) (length xs)))

(define (log-base b)
  (lambda (x) (/ (log x) (log b))))

(#%provide average pow log-base)

; Iterative fibonnaci procedure
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))

(#%provide fib)

(define (indent n)
  (make-string (* 2 n) #\space))
(#%provide indent)

(define (print-seq . xs)
  (define (loop ys)
    (if (null? ys)
        (newline)
        (begin
          (display (car ys))
          (loop (cdr ys)))))
  (loop xs))
(#%provide print-seq)

(define (square x)
  (* x x))
(#%provide square)

(define big-prime-1 1000000000039)
(define big-prime-2 1000000000000037)
(define big-prime-3 999999999999999023)
(define big-prime-4 9223372036854675811)
(#%provide big-prime-1)
(#%provide big-prime-2)
(#%provide big-prime-3)
(#%provide big-prime-4)

(define (expmod base exp m)
  (cond
    [(= exp 0) 1]
    [(even? exp) (remainder (square (expmod base (/ exp 2) m)) m)]
    [else (remainder (* base (expmod base (- exp 1) m)) m)]))
(#%provide expmod)

(define (identity x)
  x)
(#%provide identity)

; This is nutty but cool
(define-syntax inspect
  (syntax-rules ()
    [(_ (f args ...))
     (let ([v (f args ...)])
       (write '(f args ...))
       (display " ; ")
       (write v)
       (newline))]
    [(_ expr)
     (let ([v expr])
       (write 'expr)
       (display " ; ")
       (write v)
       (newline))]))

; rv = return value
(define-syntax inspect-rv
  (syntax-rules ()
    [(_ (f args ...))
     (let ([v (f args ...)])
       (write '(f args ...))
       (display " ; ")
       (write v)
       (newline)
       v)]
    [(_ expr)
     (let ([v expr])
       (write 'expr)
       (display " ; ")
       (write v)
       (newline)
       v)]))
(#%provide inspect inspect-rv)

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond
    [(> (square test-divisor) n) n]
    [(divides? test-divisor n) test-divisor]
    [else (find-divisor n (+ test-divisor 1))]))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (prime? n)
  (and (>= n 2) (= n (smallest-divisor n))))
(#%provide divides? find-divisor smallest-divisor prime?)

;; From 1.37
(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (dec i) (/ (n i) (+ (d i) result)))))
  (iter k 0))
(#%provide cont-frac)

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))

  (define (try guess)
    (let ([next (f guess)])
      (if (close-enough? guess next)
          next
          (try next))))

  (try first-guess))
(#%provide fixed-point)

;; 1.3.4
(define (average-damp f)
  (lambda (x) (average x (f x))))

(define dx 0.00001)
(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))
(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(#%provide average-damp deriv newton-transform newtons-method)

(define (double f)
  (lambda (x) (f (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter result n)
    (if (<= n 1)
        result
        (iter (compose f result) (dec n))))
  (iter f n))

(#%provide double compose repeated)

; 2.2.1
(define (reverse l)
  (define (iter l rl)
    (if (null? l)
        rl
        (iter (cdr l) (cons (car l) rl))))
  (iter l (list)))
(#%provide reverse)

; 2.2.3
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define fold-right accumulate)

(define (enumerate-interval i max)
  (define (iter i res)
    (if (> i max)
        res
        (iter (inc i) (append res (list i)))))
  (iter i '()))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else
         (filter predicate (cdr sequence)))))

(define (unique-pairs n)
  (flatmap
    (lambda (i)
      (map (lambda (j) (list i j))
           (enumerate-interval 1 (- i 1))))
    (enumerate-interval 1 n)))

(define (sum-list sequence)
  (accumulate + 0 sequence))

(define (nth n lst)
  (car ((repeated cdr n) lst)))
(#%provide accumulate enumerate-tree accumulate-n fold-left fold-right enumerate-interval flatmap filter unique-pairs sum-list nth)

;; 2.2.4
(#%require sicp-pict)
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
    (let ([half (beside (flip-horiz quarter) quarter)]) (below (flip-vert half) half))))
(#%provide split right-split up-split corner-split square-limit)

;; 2.3.1
(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))
(#%provide memq)

;; 2.3.2
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num) (and (number? exp) (= exp num)))
(#%provide variable? same-variable? =number?)

(define (make-sum a1 . rest) 
  (define a2
    (if (null? (cdr rest))
        (car rest)
        (apply make-sum (car rest) (cdr rest))))

  (cond [(=number? a1 0) a2]
        [(=number? a2 0) a1]
        [(and (number? a1) 
              (number? a2))
          (+ a1 a2)]
        [else (list '+ a1 a2)]))
(define (sum? x) (and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend p)
  (let ([rest (cddr p)])
    (if (null? (cdr rest))
        (car rest)
        (apply make-sum rest))))
(#%provide make-sum sum? addend augend)

(define (make-product m1 . rest) 
  (define m2
    (if (null? (cdr rest))
        (car rest)
        (apply make-product (car rest) (cdr rest))))

  (cond [(or (=number? m1 0) (=number? m2 0)) 0]
        [(=number? m1 1) m2]
        [(=number? m2 1) m1]
        [(and (number? m1) (number? m2)) (* m1 m2)]
        [else (list '* m1 m2)]))
(define (product? x) (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplicand p)
  (let ([rest (cddr p)])
    (if (null? (cdr rest))
        (car rest)
        (apply make-product rest))))
(#%provide make-product product? multiplier multiplicand)

(define (make-expt base exp)
  (cond [(=number? exp 0) 1]
        [(=number? exp 1) base]
        [(=number? base 0) 0]
        [(=number? base 1) 1]
        [(and (number? base) (number? exp)) (expt base exp)]
        [else (list '^ base exp)]))
(define (expt? s) (eq? '^ (car s)))
(define (base s) (cadr s))
(define (exponent s) (caddr s))
(#%provide make-expt expt? base exponent)

;; 2.3.3 Sets
(define (element-of-set? x set)
  (cond [(null? set) false]
        [(equal? x (car set)) true]
        [else (element-of-set? x (cdr set))]))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond [(or (null? set1) (null? set2)) '()]
        [(element-of-set? (car set1) set2)]
        [(cons (car set1) (intersection-set (cdr set1) set2))]
        [else (intersection-set (cdr set1) set2)]))
(#%provide element-of-set? adjoin-set intersection-set)

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))


(define (print-tree tree)
  (define (empty-tree? tree)
    (null? tree))

  (define (print-node tree prefix connector)
    (if (empty-tree? tree)
        'done
        (begin
          (display prefix)
          (display connector)
          (display (entry tree))
          (newline)

          (let ((left (left-branch tree))
                (right (right-branch tree))
                (child-prefix
                 (string-append prefix
                                (cond [(string=? connector "") ""]
                                      [(string=? connector "|-- ") "|   "]
                                      [else "    "]))))

            (cond [(and (empty-tree? left)
                        (empty-tree? right))
                   'done]

                  [(empty-tree? left)
                   (print-node right child-prefix "`-- ")]

                  [(empty-tree? right)
                   (print-node left child-prefix "`-- ")]

                  [else
                   (print-node right child-prefix "|-- ")
                   (print-node left child-prefix "`-- ")])))))

  (print-node tree "" ""))
(#%provide entry left-branch right-branch make-tree print-tree)

; 2.3.4 Huffman Trees
(define (make-leaf symbol weight) (list 'leaf symbol weight))
(define (leaf? object) (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (car tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))
  
; The ordering of the elemnts is weird to accomodate the
;  left-branch and right-branch procedures of 2.3.3.
(define (make-code-tree left right)
  (list 
        (append (symbols left) (symbols right))
        left
        right
        (+ (weight left) (weight right))))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ([next-branch
                (choose-branch (car bits) current-branch)])
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond [(= bit 0) (left-branch branch)]
        [(= bit 1) (right-branch branch)]
        [else (error "bad bit: CHOOSE-BRANCH" bit)]))

(define (adjoin-leaf-set x set)
  (cond [(null? set) (list x)]
        [(< (weight x) (weight (car set))) (cons x set)]
        [else (cons (car set)
                    (adjoin-set x (cdr set)))]))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ([pair (car pairs)])
        (adjoin-set (make-leaf (car pair)  ; symbol
                               (cadr pair) ; frequency
                    (make-leaf-set (cdr pairs)))))))
                    
(#%provide make-leaf leaf? symbol-leaf weight-leaf symbols 
          weight make-code-tree decode choose-branch
          adjoin-leaf-set make-leaf-set)