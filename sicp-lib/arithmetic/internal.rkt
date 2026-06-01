#lang sicp
;; SICP 2.5: Systems with Generic Operations.
(#%require sicp-lib/generic)
(define (wrap tag fn)
	(lambda (x y)
		(attach-tag tag (fn x y))))

(#%provide wrap)