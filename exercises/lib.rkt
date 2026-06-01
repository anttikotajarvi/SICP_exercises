#lang sicp

;; Compatibility wrapper for the old exercise helper path.
(#%require sicp-lib
           sicp-lib/pict
           sicp-lib/symbolic
           sicp-lib/sets
           sicp-lib/huffman
           sicp-lib/generic)

(#%provide (all-from sicp-lib)
           (all-from sicp-lib/pict)
           (all-from sicp-lib/symbolic)
           (all-from sicp-lib/sets)
           (all-from sicp-lib/huffman)
           (all-from sicp-lib/generic))
