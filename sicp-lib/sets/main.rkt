#lang sicp

;; SICP 2.3.3: Example: Representing Sets.
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

;; SICP 2.3.3: Sets as binary trees.
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

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let* ([left-size (quotient (- n 1) 2)]

             [left-result (partial-tree elts left-size)]
             [left-tree (car left-result)]
             [non-left-elts (cdr left-result)]

             [right-size (- n (+ left-size 1))]
             [this-entry (car non-left-elts)]

             [right-result
              (partial-tree (cdr non-left-elts) right-size)]
             [right-tree (car right-result)]
             [remaining-elts (cdr right-result)])

        (cons (make-tree this-entry
                         left-tree
                         right-tree)
              remaining-elts))))

(#%provide element-of-set?
           adjoin-set
           intersection-set
           entry
           left-branch
           right-branch
           make-tree
           print-tree
           partial-tree)
