#lang racket/base
;; lang0
(provide (prefix-out lang3: (all-defined-out)))

;; Grammar
;; <exp>       := (exp <op> <exp> <exp>)
;;              | <integer>
;; <integer>   := integer?

(struct exp (op lhs rhs))
