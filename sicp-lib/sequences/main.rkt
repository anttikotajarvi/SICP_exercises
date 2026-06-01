#lang sicp
(#%require sicp-lib/core)

;; SICP 2.2.1: Representing Sequences.
(define (reverse l)
  (define (iter l rl)
    (if (null? l)
        rl
        (iter (cdr l) (cons (car l) rl))))
  (iter l (list)))

;; SICP 2.2.3: Sequences as Conventional Interfaces.
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

(#%provide reverse
           accumulate
           enumerate-tree
           accumulate-n
           fold-left
           fold-right
           enumerate-interval
           flatmap
           filter
           unique-pairs
           sum-list
           nth)
