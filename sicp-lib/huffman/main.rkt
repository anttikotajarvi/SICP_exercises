#lang sicp
(#%require sicp-lib/sets)

;; SICP 2.3.4: Example: Huffman Encoding Trees.
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

;; The ordering of the elements accommodates the left-branch and
;; right-branch procedures from the tree-set exercises.
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
                    (adjoin-leaf-set x (cdr set)))]))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ([pair (car pairs)])
        (adjoin-leaf-set (make-leaf (car pair)   ; symbol
                                    (cadr pair)) ; frequency
                          (make-leaf-set (cdr pairs))))))

(define A->C-sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                    (make-leaf 'B 2)
                    (make-code-tree
                      (make-leaf 'D 1)
                      (make-leaf 'C 1)))))

(define (encode-symbol symbol tree)
  (cond [(not (element-of-set? symbol (symbols tree)))
         (error "Symbol not in tree: " symbol)]
        [(leaf? tree)
         '()]
        [(element-of-set? symbol (symbols (left-branch tree)))
         (cons 0
               (encode-symbol symbol (left-branch tree)))]
        [else
         (cons 1
               (encode-symbol symbol (right-branch tree)))]))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(#%provide make-leaf
           leaf?
           symbol-leaf
           weight-leaf
           symbols
           weight
           make-code-tree
           decode
           choose-branch
           adjoin-leaf-set
           make-leaf-set
           A->C-sample-tree
           encode-symbol
           encode)
