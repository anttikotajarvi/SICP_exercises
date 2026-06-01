#lang sicp
(define (wrap tag fn)
	(lambda (x y)
		(attach-tag tag (fn x y))))

(#%provide wrap)